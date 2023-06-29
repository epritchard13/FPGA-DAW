module processor_core#(
	parameter SAMPLE_BLOCK_ADDRESS_BIT_WIDTH = 8,
	parameter SAMPLE_BIT_WIDTH = 16,
	
	parameter COEFFI_BLOCK_ADDRESS_BIT_WIDTH = 4,
	parameter COEFFI_BIT_WIDTH = 16,

	parameter OUTPUT_BLOCK_ADDRESS_BIT_WIDTH = 8,
	parameter OUTPUT_BIT_WIDTH = 16,
	
	parameter PROGRAM_COUNTER_BIT_WIDTH = 16,
	
	parameter MONARCH_DATA_BIT_WIDTH = 8,
	parameter MONARCH_ADDRESS_BIT_WIDTH = 8,
	
	parameter INSTRUCTION_BIT_WIDTH = 8,
	
	parameter ACCUMULATOR_BIT_WIDTH = 32
	)(
	input  clk,
	input  resetn,
	
	//axi interface to receive updates to control registers and receive instructions. Requires axi splitter beforehand to generate unique valid signal for this core.
	input  [MONARCH_DATA_BIT_WIDTH-1:0] monarch_axi_tdata,
	input  [MONARCH_ADDRESS_BIT_WIDTH-1:0] monarch_axi_taddress,
	input  monarch_axi_tvalid,
	output monarch_axi_tready,
	
	//axi interface to read sample data
	input  [SAMPLE_BIT_WIDTH-1:0] sample_axi_tdata,
	output [SAMPLE_BLOCK_ADDRESS_BIT_WIDTH-1:0] sample_axi_taddress,
	input  sample_axi_tbusy,
	output sample_axi_twrite,
	
	//axi interface to read coefficient data
	input  [COEFFI_BIT_WIDTH-1:0] coeffi_axi_tdata,
	output [COEFFI_BLOCK_ADDRESS_BIT_WIDTH-1:0] coeffi_axi_taddress,
	input  coeffi_axi_tbusy,
	output coeffi_axi_twrite,
	
	//axi interface to write output to spram
	output [OUTPUT_BIT_WIDTH-1:0] output_axi_tdata,
	output [OUTPUT_BLOCK_ADDRESS_BIT_WIDTH-1:0] output_axi_taddress,
	input  output_axi_tbusy,
	output output_axi_twrite);
	
//state machine control signals:
logic dsp_state;
logic proceed_to_next_microinstruction;

//instruction control signals:
logic increment_sample_pointer;
logic increment_coeffi_pointer;
logic increment_output_pointer;
logic increment_program_counter;

logic [INSTRUCTION_BIT_WIDTH-1:0] current_instruction;

assign increment_sample_pointer  = current_instruction[0];
assign increment_coeffi_pointer  = current_instruction[1];
assign increment_output_pointer  = current_instruction[2];
assign increment_program_counter = current_instruction[3] & proceed_to_next_microinstruction;		//this hold current instruction until all dsp math and writeback has been completed. Managed by dsp_state_machine.

//counters representing current accessed location in spram.
logic [SAMPLE_BLOCK_ADDRESS_BIT_WIDTH-1:0] 	spr_sample_pointer;
logic [COEFFI_BLOCK_ADDRESS_BIT_WIDTH-1:0]	spr_coeffi_pointer;
logic [OUTPUT_BLOCK_ADDRESS_BIT_WIDTH-1:0]	spr_output_pointer;
logic [PROGRAM_COUNTER_BIT_WIDTH-1:0]		program_counter;

//decode incoming instruction using microinstruction ROM	(clocked because it will likely be populated in SPRAM at startup)
instruction_decoder instruction_decoder_0(	.clk(clk),
						.resetn(resetn),
						.program_counter(program_counter),
						.current_instruction(current_instruction));

//internal registers used to preload the dsp macro core
logic [SAMPLE_BIT_WIDTH-1:0] sample;
logic [COEFFI_BIT_WIDTH-1:0] coefficient;
logic [ACCUMULATOR_BIT_WIDTH-1:0] accumulator_in;
logic [ACCUMULATOR_BIT_WIDTH-1:0] accumulator_out;	

//do da math P = (A*B) + C
dsp_macro dsp_macro_0(	.clk(clk),
			.resetn(resetn),
			.operandA(sample),
			.operandB(coefficient),
			.operandC(accumulator_in),
			.productP(accumulator_out));
			


logic [ACCUMULATOR_BIT_WIDTH-1:0] accumulator_A;
logic [ACCUMULATOR_BIT_WIDTH-1:0] accumulator_B;
logic [ACCUMULATOR_BIT_WIDTH-1:0] accumulator_C;
logic [ACCUMULATOR_BIT_WIDTH-1:0] accumulator_D;

//internal control registers:
logic sample_axi_tvalid_int;
logic coeffi_axi_tvalid_int;
logic output_axi_twrite_int;

//connect internals to externals
assign sample 			= sample_axi_tdata;		//sample and coef constantly multiplied everycc. result is latched on the cc following a valid read.
assign coefficient 		= sample_axi_tdata;
assign output_axi_tdata 	= accumulator_out;		//output constantly tied to result. output valid only on cc when calculation is complete.
assign sample_axi_tvalid 	= sample_axi_tvalid_int;
assign coeffi_axi_tvalid 	= coeffi_axi_tvalid_int;
assign output_axi_twrite	= output_axi_twrite_int;
assign proceed_to_next_microinstruction = output_axi_tbusy;	//TODO: think more about what sorts of blocking conditions for writeback may exist. Think about how long it takes computation to be valid.

//dsp state machine implementation
always @(posedge clk) begin
	if(resetn == 0)begin
		sample 		<= 0;
		coefficient 	<= 0;
		accumulator_in 	<= 0;
		accumulator_out <= 0;
		dsp_state	<= 0;					//0 is reset/wait state. 1 is active/hold state.
		sample_axi_tvalid_int <= 0;
		coeffi_axi_tvalid_int <= 0;
		output_axi_twrite_int <= 0;
	end else begin
		if(dsp_state == 0)begin
			output_axi_twrite_int <= 0;			//DROP VALID WRITE LOW
			if(sample_axi_tbusy == 0)begin
				if(coeffi_axi_tbusy == 0)begin		//if coefficient and sample memories are available (maybe switch this to parallel access if timing is bad)
					if(output_axi_tbusy == 0)begin	//maybe remove this check?
						sample_axi_tvalid_int <= 1;
						coeffi_axi_tvalid_int <= 1;
						dsp_state <= 1;
						case(current_instruction[7:6]) //TODO: switch this to a multiplexer to choose internal register. (maybe do this outside of clock domain)
							2'b00: accumulator_in <= accumulator_A;
							2'b01: accumulator_in <= accumulator_B;
							2'b10: accumulator_in <= accumulator_C;
							2'b11: accumulator_in <= accumulator_D;
						endcase
					end
				end
			end
		end else begin						//following clock cycle when data is present (DROP VALID READ LOW)
			sample_axi_tvalid_int <= 0;				
			coeffi_axi_tvalid_int <= 0;
			case(current_instruction[5:4])			//latch the output of the DSP core. TODO: fix the timing issues which will certainly arrive by trying to read from spram and do dsp on the data in 1 clock cycle. (add a delay)
				2'b00: accumulator_A <= accumulator_out;
				2'b01: accumulator_B <= accumulator_out;
				2'b10: accumulator_C <= accumulator_out;
				2'b11: accumulator_D <= accumulator_out;
			endcase
			if(proceed_to_next_microinstruction)begin	//when completed calculation, RAISE VALID WRITE
				output_axi_twrite_int <= 1;
				dsp_state <= 0;
			end
		end
	end
end

//base pointers for counters
logic [SAMPLE_BLOCK_ADDRESS_BIT_WIDTH-1:0] 	spr_sample_base_pointer;
logic [COEFFI_BLOCK_ADDRESS_BIT_WIDTH-1:0]	spr_coeffi_base_pointer;
logic [OUTPUT_BLOCK_ADDRESS_BIT_WIDTH-1:0]	spr_output_base_pointer;
logic [PROGRAM_COUNTER_BIT_WIDTH-1:0]		program_counter_base;

//control register receiver
always @(posedge clk)begin
	if(resetn == 0)begin
		spr_sample_base_pointer <= 0;
		spr_coeffi_base_pointer <= 0;
		spr_output_base_pointer <= 0;
		program_counter_base <= 0;
	end else begin
		if(monarch_axi_tvalid)begin
			case(monarch_axi_taddress[1:0])
				2'b00: spr_sample_base_pointer 		<= monarch_axi_tdata[SAMPLE_BLOCK_ADDRESS_BIT_WIDTH-1:0];
				2'b01: spr_coeffi_base_pointer 		<= monarch_axi_tdata[COEFFI_BLOCK_ADDRESS_BIT_WIDTH-1:0];
				2'b10: spr_output_base_pointer 		<= monarch_axi_tdata[OUTPUT_BLOCK_ADDRESS_BIT_WIDTH-1:0];
				2'b11: program_counter_base		<= monarch_axi_tdata[PROGRAM_COUNTER_BIT_WIDTH-1:0];
			endcase	
		end
	end
end



//control counters
always @(posedge clk) begin
	if(resetn == 0)begin
		spr_sample_pointer 	<= 0;
		spr_coeffi_pointer 	<= 0;
		spr_output_pointer 	<= 0;
		program_counter		<= 0;
	end else begin
		if(increment_sample_pointer)begin
			spr_sample_pointer <= spr_sample_pointer + 1;
		end
		if(increment_coeffi_pointer)begin
			spr_coeffi_pointer <= spr_coeffi_pointer + 1;
		end
		if(increment_output_pointer)begin
			spr_output_pointer <= spr_output_pointer + 1;
		end
		if(increment_program_counter)begin
			program_counter <= program_counter + 1;
		end
	end
end
endmodule