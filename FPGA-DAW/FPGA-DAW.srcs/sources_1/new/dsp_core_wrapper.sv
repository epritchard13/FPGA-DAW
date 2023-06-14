`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////
//                                                                                  //
//                       Digital Signal Processor Core V1.0.0                       //
//                                                                                  //
//    Uses two input buffers of not yet determined length for coef and sample.      //  
//    Stores intermediate results in (8?) temporary buffers (subject to change).    //
//    Primarily a wrapper for a dsp48 but also has ALU operations.                  //
//                                                                                  //
//    SUPPORTS MULTI-CORE       and         EVERY CORE CAN DRIVE SAME OUTPUT FIFO   //
//                                                                                  //
//   Henry E Pritchard   /////////  6 . 13 . 23  /////////   Certain Synthesizers   //
//                                                                                  //
//                                                                                  //
//                  This core will have 4 FIFOs surrounding it                      //
//                      - samples from psram                                        //
//                      - coefficients from psram (used for filters, dfts)          //
//                      - instructions from the pico                                //
//                      - an output buffer / master mixer                           //
//                                                                                  //
//                                                                                  //
//////MSB/////////////////////  INSTRUCTION  FORMAT  ////////////////////////LSB//////
//                                                                                  //
//                C    O    S    A    V    OP    AC2    AC1    AC0                  //
//                                                                                  //
//////MSB/////////////////////   (16 BITS TOTAL)  ///////////////////////////LSB//////
//                                                                                  //
//  EXPLANATION:                                                                    //
//  15   - c   - "coef shift"      - whether or not to shift the coefficient buffer //
//  14   - o   - "coef source"     - shift in new or circular shift in old          //
//  13   - s   - "sample shift"    - whether or not to shift the sample buffer      //
//  12   - a   - "sample source"   - shift in new or circular shift in old          //
//  11   - v   - "output valid"    - the state of interconn_reg is valid output     //
//  10:9 - op  - "operation"       - OPERATION: DSPBLOCK/ALU0/ALU1/ALU2             //
//  8:6  - ac2 - "dest      acc"   - register to write to      (111 is EXT)         //
//  5:3  - ac1 - "operand A acc"   - first operand register    (111 is EXT)         //
//  2:0  - ac0 - "operand B acc"   - second operand register   (111 is EXT)         //
//                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////

module dsp48_macro_wrapper#(
    parameter DAT_BIT_WID = 16,     //width of sample
    parameter INS_BIT_WID = 16,     //total width of instruction
    parameter ACC_BIT_WID = 32,     //width of internal registers/accumulators
    parameter COE_BUF_DEP = 8,
    parameter NUM_ACC_TOT = 8
    )(
    //regmem ctrl registers (one way, read only)
    input   [DAT_BIT_WID-1:0]   coef_data,
    output                      coef_ready,
    input                       coef_valid,
    
    //instruction from bram (one way, read only, no jumps)
    input   [INS_BIT_WID-1:0]   inst_data,
    output reg                  inst_ready,
    input                       inst_valid,
    
    //input data from input firo (one way, read only)
    input   [DAT_BIT_WID-1:0]   samp_data,
    output                      samp_ready,
    input                       samp_valid,
    
    //output data to output fifo (one way, write only)
    output  [DAT_BIT_WID-1:0]   calc_data,
    output                      calc_valid,
    input                       calc_ready,
    
    //input data from ext bus (one way, read only)
    input   [ACC_BIT_WID-1:0]   inhale_data,
    input                       inhale_triggered,
    
    //output data to ext bus (one way, write only)
    output  [ACC_BIT_WID-1:0]   exhale_data,
    output                      exhale_requested,
    
    //  A note about inhaling and exhaling
    //
    //      an exhale is requested when the destination accumulator is 7. 
    //      when an exhale is requested, no other core may proceed to next instruction. every core but the exhaler freezes (inst_ready = !inhale_trig)
    //      this is accomplished using an external OR gate driving the inhale trigger input.
    //      exhaling is used to drive a common output FIFO and ensures no other core is driving the fifo at the same time.
    //      it probably reduces capacity of the system, but assuming we only have 8 dsp cores who cares.
    //      
    //      exhaling MUST require precise compilation of instructions.
    //      the followin instruction MUST be a no-op to allow other cores to resync.
    //
    //  H.P.6.13.23
    
    //controls
    input clk,
    input resetn
    );
    
reg     [ACC_BIT_WID-1:0]   accumulator_a;
reg     [ACC_BIT_WID-1:0]   accumulator_b;
reg     [ACC_BIT_WID-1:0]   accumulator_c;
reg     [ACC_BIT_WID-1:0]   accumulator_d;
reg     [ACC_BIT_WID-1:0]   accumulator_e;
reg     [ACC_BIT_WID-1:0]   accumulator_f;
reg     [ACC_BIT_WID-1:0]   accumulator_g;
reg     [ACC_BIT_WID-1:0]   interconn_reg;
wire    [INS_BIT_WID-1:0]   instruction;


reg     [(COE_BUF_DEP*DAT_BIT_WID)-1:0] sample_buffer;      //8*16 -> 127:0
reg     [(COE_BUF_DEP*DAT_BIT_WID)-1:0] coefficient_buffer; //8*16 -> 127:0
reg     [DAT_BIT_WID-1:0]               sample_delay;
reg     [DAT_BIT_WID-1:0]               coefficient_delay;                               
reg     [ACC_BIT_WID-1:0]               first_selected_accumulator;
reg     [ACC_BIT_WID-1:0]               second_selected_accumulator;
wire    [ACC_BIT_WID-1:0]               dsp_result;
reg     [ACC_BIT_WID-1:0]               operation_result;


assign inst_ready       = ~inhale_triggered;                                    //proceed to next inst only when another core is not freezing.
assign samp_ready       = instruction[12];
assign coef_ready       = instruction[14];
assign exhale_data      = interconn_reg;                                        //exhaling is when cores interact in real time. requires compiler synchronization.
assign calc_data        = interconn_reg;                                        //the same register is used for crosstalk and output fifo population.
assign exhale_requested = (instruction[8] & instruction[7] & instruction[6]);   //request freeze when writing to output fifo or exhaling.
assign instruction      = inst_data;
assign calc_valid       = instruction[11];                                      //exhale into output fifo.

always @(instruction)begin
    if(resetn == 0)begin
        accumulator_a <= 32'h00000000;
        accumulator_b <= 32'h00000000;
        accumulator_c <= 32'h00000000;
        accumulator_d <= 32'h00000000;
        accumulator_e <= 32'h00000000;
        accumulator_f <= 32'h00000000;
        accumulator_g <= 32'h00000000;
        interconn_reg <= 32'h00000000;
    end else begin 
    
        //operand two multiplexer
        case(instruction[2:0])
            3'b000  : second_selected_accumulator <= accumulator_a;
            3'b001  : second_selected_accumulator <= accumulator_b;
            3'b010  : second_selected_accumulator <= accumulator_c;
            3'b011  : second_selected_accumulator <= accumulator_d;
            3'b100  : second_selected_accumulator <= accumulator_e;
            3'b101  : second_selected_accumulator <= accumulator_f;
            3'b110  : second_selected_accumulator <= accumulator_g;
            3'b111  : second_selected_accumulator <= interconn_reg;
            default : second_selected_accumulator <= 32'h00000000;
        endcase
        
        //operand one multiplexer
        case(instruction[5:3])
            3'b000  : first_selected_accumulator <= accumulator_a;
            3'b001  : first_selected_accumulator <= accumulator_b;
            3'b010  : first_selected_accumulator <= accumulator_c;
            3'b011  : first_selected_accumulator <= accumulator_d;
            3'b100  : first_selected_accumulator <= accumulator_e;
            3'b101  : first_selected_accumulator <= accumulator_f;
            3'b110  : first_selected_accumulator <= accumulator_g;
            3'b111  : first_selected_accumulator <= interconn_reg;
            default : first_selected_accumulator <= 32'h00000000;
        endcase
        
        //operation multiplexer
        case(instruction[10:9])
            2'b00   : operation_result <= dsp_result;
            2'b00   : operation_result <= 32'h00000000; //not yet designed
            2'b00   : operation_result <= 32'h00000000; //not yet designed
            2'b00   : operation_result <= 32'h00000000; //not yet designed
            default : operation_result <= 32'h00000000;
        endcase
    end
end

//dsp block instantiation (example atm, will change depending on radiant ip)
dsp48_macro dsp48(  .a(sample_buffer[DAT_BIT_WID-1:0]),
                    .b(coefficient_buffer[DAT_BIT_WID-1:0]),
                    .c(first_selected_accumulator),
                    .d(second_selected_accumulator),
                    .p(dsp_result));


//SYNCHRONOUS INPUT BUFFER IMPLEMENTATION
always @(clk)begin
    if(resetn == 0)begin
        sample_delay        <= 0;
        coefficient_delay   <= 0;
    end else begin
        if(inst_ready)begin                         //CAN ONLY OPERATE WHEN HOLD FLAG IS LOW
        if(inst_valid)begin                         //CAN ONLY OPERATE WHEN INSTRUCTION IS AVAILABLE.
        if(coef_valid)begin                         //CAN ONLY OPERATE WHEN COEFFICIENT FIFO NOT EMPTY.
        if(samp_valid)begin                         //CAN ONLY OPERATE WHEN SAMPLE DATA FIFO NOT EMPTY.
        if(calc_ready)begin                         //CAN ONLY OPERATE WHEN OUTPUT FIFO IS NOT FULL.
            //COEFFICIENT BUFFER
            if(instruction[15] == 1)begin           //SHIFT COEFFICIENT BUFFER
                if(instruction[14] == 1)begin       //SHIFT IN NEW DATA
                    {coefficient_buffer[((COE_BUF_DEP-1)*DAT_BIT_WID)-1:0],coefficient_delay} <= {coef_data,coefficient_buffer[(COE_BUF_DEP*DAT_BIT_WID)-1:0]};
                end else begin                      //CIRCULAR SHIFT OLD DATA
                    {coefficient_buffer[((COE_BUF_DEP-1)*DAT_BIT_WID)-1:0],coefficient_delay} <= {coefficient_delay,coefficient_buffer[(COE_BUF_DEP*DAT_BIT_WID)-1:0]};
                end
            end
            
            //SAMPLE BUFFER
            if(instruction[13] == 1)begin           //SHIFT SAMPLE BUFFER
                if(instruction[12] == 1)begin       //SHIFT IN NEW DATA
                    {sample_buffer[((COE_BUF_DEP-1)*DAT_BIT_WID)-1:0],sample_delay} <= {samp_data,sample_buffer[(COE_BUF_DEP*DAT_BIT_WID)-1:0]};
                end else begin                      //CIRCULAR SHIFT OLD DATA
                    {sample_buffer[((COE_BUF_DEP-1)*DAT_BIT_WID)-1:0],sample_delay} <= {sample_delay,sample_buffer[(COE_BUF_DEP*DAT_BIT_WID)-1:0]};
                end
            end
            
            //RESULT DEMULTIPLEXER
            if         (instruction[8:6] == 3'b000)begin
                accumulator_a <= operation_result;
            end else if(instruction[8:6] == 3'b001)begin
                accumulator_b <= operation_result;
            end else if(instruction[8:6] == 3'b010)begin
                accumulator_c <= operation_result;
            end else if(instruction[8:6] == 3'b011)begin
                accumulator_d <= operation_result;
            end else if(instruction[8:6] == 3'b100)begin
                accumulator_e <= operation_result;
            end else if(instruction[8:6] == 3'b101)begin
                accumulator_f <= operation_result;
            end else if(instruction[8:6] == 3'b110)begin
                accumulator_g <= operation_result;
            end else if(instruction[8:6] == 3'b111)begin
                interconn_reg <= operation_result;

            end
        end
        end
        end
        end
        end else begin  //only if an inhale is triggered (so inst_ready is low)
            interconn_reg <= inhale_data;
        end
    end
end
   
endmodule

