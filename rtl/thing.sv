// designed for one chip but will be expanded to drive 8

module psram_controller#(
	parameter MONARCH_DATA_WIDTH = 8,
	parameter MONARCH_ADDRESS_WIDTH = 2,

	parameter SPRAM_DATA_WIDTH = 16,
	parameter SPRAM_ADDRESS_WIDTH = 16,

	parameter SD_DATA_WIDTH = 16,      //need to confirm with ethan about this.
	parameter SD_ADDRESS_WIDTH = 16,   //need to ^^

	parameter PSRAM_DATA_WIDTH = 8,
	parameter PSRAM_ADDRESS_WIDTH = 24,

	parameter PSRAM_BLOCK_SIZE = 1023
	)(
	input  clk,
	input  resetn,
	
	//monarch axi interface used to drive settings registers
	input  [MONARCH_DATA_WIDTH-1:0] monarch_axi_tdata,
	input  [MONARCH_ADDRESS_WIDTH-1:0] monarch_axi_taddress,
	input  monarch_axi_tvalid,
	output monarch_axi_tready,

	//spram axi interface for writing - MSB of address will freeze a block of spram in order to write.
	output [SPRAM_DATA_WIDTH-1:0] spram_write_axi_tdata,
	output [SPRAM_ADDRESS_WIDTH-1:0] spram_write_axi_taddress,
	output spram_write_axi_tvalid,
	input  spram_write_axi_tready,

	//spram axi interface for reading - MSB of address will freeze a block of spram in order to read.
	input  [SPRAM_DATA_WIDTH-1:0] spram_read_axi_tdata,
	output [SPRAM_ADDRESS_WIDTH-1:0] spram_read_axi_taddress,
	output spram_read_axi_tvalid,
	input  spram_read_axi_tready,

	//sd axi interface for writing
	output [SD_DATA_WIDTH-1:0] sd_write_axi_tdata,
	output [SD_ADDRESS_WIDTH-1:0] sd_write_axi_taddress,
	output sd_write_axi_tvalid,
	input  sd_write_axi_tready,

	//sd axi interface for reading
	input  [SD_DATA_WIDTH-1:0] sd_read_axi_tdata,
	output [SD_ADDRESS_WIDTH-1:0] sd_read_axi_taddress,
	output sd_read_axi_tvalid,
	input  sd_read_axi_tready,
	
	//chip interfaces
	output chip_enable_0,
	input  sisio0_0,
	output sosio1_0,
	//inout  sio2_0,
	//inout  sio3_0,
	output sclk

	);

//constants used for sending psram commands			(double check and verify)
//ethan says to use SPI not QPI.
//const bit [7:0] SPI_ENTER_QUAD_MODE_COMMAND	= 8'b00110101;
const bit [7:0] SPI_FAST_QUAD_READ_COMMAND 	= 8'b11010000;
const bit [7:0] SPI_QUAD_WRITE_COMMAND 		= 8'b01000000;
//const bit [7:0] QPI_EXIT_QUAD_MODE_COMMAND	= 8'b11110101;
const int SPI_RW_COOLDOWN 				= 10;		//measured in cc


//buffer parallel data to be read/written in serial. concurrent read/writes may be supported with multiple chips? (consider address space overlap)
//logic psram_single_write_data;
//logic psram_block_write_address;

//logic psram_single_read_data;
//logic psram_block_read_address;

//VERY IMPORTANT SECTION: 
//psram spi direction controller: (were using spi not qpi so whatever.)
logic spi_serial_out;   //internal single dir
logic spi_serial_in;    //internal single dir

assign spi_serial_in = sisio0_0;
assign sosio1_0 = spi_serial_out;
assign sclk = clk;



//state machine for shuttling
typedef enum {idle,read_cmd,send_read_addr,reading,write_cmd,send_write_addr,writing,blocked} chip_state_enum;
chip_state_enum chip_0_state;
chip_state_enum chip_0_next_state;

logic want_to_read;
logic want_to_write;

assign monarch_axi_tready = (chip_0_state == idle);

always @(posedge clk) begin
	if(resetn == 0)begin
		chip_0_next_state <= idle;
	end else begin
		case(chip_0_state)
			idle:			chip_0_next_state	<= idle;
			read_cmd:		chip_0_next_state	<= send_read_addr;
			send_read_addr: chip_0_next_state   <= reading;
			reading:		chip_0_next_state	<= blocked;
			write_cmd:		chip_0_next_state	<= send_write_addr;
			send_write_addr:chip_0_next_state   <= writing;
			writing:		chip_0_next_state	<= blocked;
			blocked:		chip_0_next_state	<= idle;
			default:		chip_0_next_state	<= idle;
		endcase
	end
end


//latch and decipher the monarch's command
logic [MONARCH_DATA_WIDTH-1:0] instruction;
logic [MONARCH_DATA_WIDTH-1:0] address_LSB;
logic [MONARCH_DATA_WIDTH-1:0] address_CSB;
logic [MONARCH_DATA_WIDTH-1:0] address_MSB;

//monarch instruction decoder
assign want_to_read  = instruction[0];
assign want_to_write = instruction[1];
logic [PSRAM_ADDRESS_WIDTH-1:0] read_write_address;
assign read_write_address = {address_MSB, address_CSB, address_LSB};

always @(posedge clk) begin
	if(resetn==0)begin
		instruction   <= 0;
		address_LSB <= 0;
		address_CSB <= 0;
		address_MSB <= 0;
	end else begin
		if(monarch_axi_tvalid)begin
			case(monarch_axi_taddress)
				2'b00	:	instruction   <= monarch_axi_tdata;
				2'b01	:	address_LSB <= monarch_axi_tdata;
				2'b10	:	address_CSB <= monarch_axi_tdata;
				2'b11	:	address_MSB <= monarch_axi_tdata;
			endcase
		end	
	end
end

//TODO: convert bit widths of SD_axi interface to the same widths as the spram_axi interface. (this is temporarily replaced with this todo's output)
logic [SPRAM_DATA_WIDTH-1:0] streamlined_sd_read_data;				//input
logic [SPRAM_ADDRESS_WIDTH-1:0] streamlined_sd_read_address;		//output
logic streamlined_sd_read_valid;									//input
logic streamlined_sd_read_ready;									//output

logic [SPRAM_DATA_WIDTH-1:0] streamlined_sd_write_data;				//output
logic [SPRAM_ADDRESS_WIDTH-1:0] streamlined_sd_write_address;		//output
logic streamlined_sd_write_valid;									//output
logic streamlined_sd_write_ready;									//input


assign streamlined_sd_read_data = sd_read_axi_tdata;
assign sd_read_axi_taddress = streamlined_sd_read_address;
assign sd_read_axi_tvalid = streamlined_sd_read_valid;
assign streamlined_sd_read_ready = sd_read_axi_tready;

assign sd_write_axi_tdata = streamlined_sd_write_data;
assign sd_write_axi_taddress = streamlined_sd_write_address;
assign sd_write_axi_tvalid = streamlined_sd_write_valid;
assign streamlined_sd_write_ready = sd_write_axi_tready;


//select which driver for a psram write (read from spram(ins2 == 0) or sd(ins2 == 1))
logic [SPRAM_DATA_WIDTH-1:0] selected_driver_data;					//input  into module	(mux)
logic [SPRAM_ADDRESS_WIDTH-1:0] selected_driver_address;			//output from module	(decoder)
logic selected_driver_valid;										//input  into module	(mux)
logic selected_driver_ready;										//output from module	(decoder)

assign selected_driver_data 		= (instruction[2] == 0)?spram_read_axi_tdata	: streamlined_sd_read_data;
assign selected_driver_ready		= (instruction[2] == 0)?spram_read_axi_tready	: streamlined_sd_read_ready;

assign spram_read_axi_taddress 		= selected_driver_address;
assign spram_read_axi_tvalid		= selected_driver_valid & ~instruction[2];

assign streamlined_sd_read_address 	= selected_driver_address;
assign streamlined_sd_read_valid	= selected_driver_valid & instruction[2];

//TODO: select which endpoint for a psram read	(write to spram(ins3 == 0) or sd(ins3 == 1))
logic [SPRAM_DATA_WIDTH-1:0] selected_endpoint_data;				//output from module	(decoder)
logic [SPRAM_ADDRESS_WIDTH-1:0] selected_endpoint_address;			//output from module	(decoder)
logic selected_endpoint_valid;										//output from module	(decoder)
logic selected_endpoint_ready;										//input  into module	(mux)

assign selected_endpoint_ready		= (instruction[3] == 0)?spram_write_axi_tready	: streamlined_sd_write_ready;

assign spram_write_axi_tdata		= selected_endpoint_data;
assign spram_write_axi_taddress		= selected_endpoint_address;
assign spram_write_axi_tvalid		= selected_endpoint_valid & ~instruction[3];

assign streamlined_sd_write_data	= selected_endpoint_data;
assign streamlined_sd_write_address	= selected_endpoint_address;
assign streamlined_sd_write_valid	= selected_endpoint_valid & instruction[3];

//TODO: !!!IMPORTANT!!! convert in / out spi into bidirectional spi.

//TODO: add wait for ready functionality. could be wait before process start or intermittent pause

//TODO: serialize / deserialize the data. drive driver / endpoint ready and valid signals to support fifo-less throughput

//TODO: add the valid bit controlling to allow latching when finished reading a byte from psram. (happens just before byte is cleared)

//TODO: FIX DATA WIDTH SHIT!


logic [PSRAM_DATA_WIDTH-1:0] spi_build_byte;
logic [PSRAM_DATA_WIDTH-1:0] spi_send_byte;

//spi builder / receiver indices
int command_word_index;
int serial_to_parallel_bit_index;
int parallel_to_serial_bit_index;
int address_within_block;
int address_tx_index;


//blocker length
int blocked_counter;

logic chip_enable_0_internal;
assign chip_enable_0 = chip_enable_0_internal;      //one cc of delay until spi ctrl

always @(posedge clk)begin
    
	if(resetn == 0)begin
	    chip_0_state <= idle;
		command_word_index <= 0;
		address_within_block <= 0;
		serial_to_parallel_bit_index <= 0;
		parallel_to_serial_bit_index <= 0;
		spi_serial_out <= 0;
		spi_build_byte <= 0;
		spi_send_byte  <= 0;
		blocked_counter <= 0;
		selected_endpoint_data <= 0;
		selected_endpoint_address <= 0;
		selected_endpoint_valid <= 0;
		selected_driver_address <= 0;
		selected_driver_valid <= 0;
		chip_enable_0_internal <= 1;
		address_tx_index <= PSRAM_ADDRESS_WIDTH-1;
	end else begin
	   chip_enable_0_internal <= ~((chip_0_state != idle) && (chip_0_state != blocked));
	   if(chip_0_state == idle)begin
	       if(want_to_read)begin
	           chip_0_state <= read_cmd;
	       end else if(want_to_write)begin
	           chip_0_state <= write_cmd;
	       end
	   end else if(chip_0_state == read_cmd)begin
			if(command_word_index == 7)begin		//final clock cycle 
				command_word_index <= 0;
				chip_0_state <= chip_0_next_state;		//continue to read block
			end else begin
				spi_serial_out <= SPI_FAST_QUAD_READ_COMMAND[command_word_index];	//transmit read cmd bit by bit.
				command_word_index <= command_word_index + 1;
			end
		end else if(chip_0_state == send_read_addr)begin	
		    spi_serial_out <= read_write_address[address_tx_index];
			if(address_tx_index == 0)begin
			     chip_0_state <= chip_0_next_state;
			end else begin
			     address_tx_index <= address_tx_index - 1;
			end
			
			
			
		end else if(chip_0_state == reading)begin //read an entire block
			if(serial_to_parallel_bit_index == SPRAM_DATA_WIDTH)begin				//collect every serial bit into a parallel vector
				//BYTE COLLECTION COMPLETE
				serial_to_parallel_bit_index <= 0;
				selected_endpoint_data <= spi_build_byte;
				selected_endpoint_address <= address_within_block;
				selected_endpoint_valid <= 1;                           //TODO: add receival confirmation???
				if(address_within_block == PSRAM_BLOCK_SIZE)begin				//repeat for every address in block
					//READ BLOCK COMPLETE
					address_within_block <= 0;
					chip_0_state <= chip_0_next_state;	//READ COMPLETE transfer into blocking / reset wait stage.
				end else begin
					//READ NEXT BYTE
					address_within_block <= address_within_block + 1;
				end
			end else begin
				//COLLECT NEXT BIT IN BYTE
				selected_endpoint_valid <= 0;
				serial_to_parallel_bit_index <= serial_to_parallel_bit_index + 1;
				spi_build_byte[serial_to_parallel_bit_index] = spi_serial_in;		//collect serial in into byte builder
			end
			
			
			
			
		end else if(chip_0_state == write_cmd)begin
		    spi_serial_out <= SPI_QUAD_WRITE_COMMAND[command_word_index];		//transmit write cmd bit by bit
			if(command_word_index == 7)begin
				command_word_index <= 0;
				chip_0_state <= chip_0_next_state;		//continue to write block
			end else begin 
				command_word_index <= command_word_index + 1;
			end
		end else if(chip_0_state == send_write_addr)begin	
			spi_serial_out <= read_write_address[address_tx_index];
			if(address_tx_index == 1)begin
			     selected_driver_valid <= 1;             //jump-the-gun provoke a read
			     address_tx_index <= address_tx_index - 1;
			             //TODO: FIX BIT WIDTH SHIT!
			end else if(address_tx_index == 0)begin                           //ask for byte to write!!!
			     selected_driver_valid <= 0;
			     chip_0_state <= chip_0_next_state;
			     //spi_send_byte <= selected_driver_data[PSRAM_DATA_WIDTH-1:0];
			end else begin
			     address_tx_index <= address_tx_index - 1;
			end
		end else if(chip_0_state == writing)begin
			spi_serial_out <= spi_send_byte[parallel_to_serial_bit_index];
			if(parallel_to_serial_bit_index == 0)begin
			     spi_send_byte <= selected_driver_data[PSRAM_DATA_WIDTH-1:0];	//CHANGE THIS OR GATE IT USING A VALID GATE
			     parallel_to_serial_bit_index <= parallel_to_serial_bit_index + 1;
			end else if(parallel_to_serial_bit_index == SPRAM_DATA_WIDTH - 1)begin
			     selected_driver_valid <= 1;
			     parallel_to_serial_bit_index <= parallel_to_serial_bit_index + 1;
			     
			end else 
			if(parallel_to_serial_bit_index == SPRAM_DATA_WIDTH)begin
				parallel_to_serial_bit_index <= 0;
				selected_driver_valid <= 0;
				selected_driver_address <= address_within_block;
				if(address_within_block == PSRAM_BLOCK_SIZE)begin
					//BLOCK WRITE COMPLETE
					address_within_block <= 0;
					chip_0_state <= chip_0_next_state;	//WRITE COMPLETE transfer into blocking / reset wait stage.
				end else begin
					//WRITE NEXT BYTE
					address_within_block <= address_within_block + 1;
					//TODO: fetch next byte to write. 
					//the concern here is that this condition only happens one cc, so no returning if valid was low.
					
				end
			end else begin
			    selected_driver_valid <= 0;
				parallel_to_serial_bit_index <= parallel_to_serial_bit_index + 1;
			end
		end else if(chip_0_state == blocked)begin
		      selected_endpoint_valid <= 0;
			if(blocked_counter == SPI_RW_COOLDOWN)begin
				blocked_counter <= 0;
			end else begin
				blocked_counter <= blocked_counter + 1;
			end
		end
	end
end

//TODO: set up enter quad mode and exit quad mode.

endmodule
