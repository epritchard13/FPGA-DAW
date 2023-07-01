//NOTES:
// designed for two chips but will be expanded to drive 8
// the axi interface out of this controller is 16 bits wide. This means that two psram chips run in parallel to achieve full 133MHz throughput. 
// The predicted final throughput of the axi interfaces will be near 16.6 MHz, not considering downtime between blocks.

//THE SD CARD INTERFACE HAS A COUPLE REQUIREMENTS:
// must be 16 bits axi. (with valid and ready)
// SD-CARD-READ: Upon a READY signal transitioning from LOW to HIGH, SD must provide valid data on the next CC (assuming SD's data is valid.)
// SD-CARD-WRITE: Upon a VALID signal transitioning from LOW to HIGH, SD must latch onto the data during that CC (assuming SD is ready.)
// must be two single directional ports. (One for read, one for write)
// I am still designing how addresses will work. Obviously not all 24 bits are required because we are using 10 bit blocks. (as of 7/1/2023)
// It is possible that SD __WILL__NOT__ be able to tell psramcontroller which address to write to, as that will instead be directed by monarch/pico (I.E. the psram is the master)
// SD will be given an address from psramcontroller, however it will need additional bits from monarch to form a valid sdaddress. (so we might as well have monarch give the entire address so it arrives sooner)

//TO SPRAM INTERFACE WILL BE PRETTY MUCH THE SAME

module psram_controller#(
	parameter MONARCH_DATA_WIDTH = 8,
	parameter MONARCH_ADDRESS_WIDTH = 2,

	parameter SPRAM_DATA_WIDTH = 16,
	parameter SPRAM_ADDRESS_WIDTH = 16,

	parameter SD_DATA_WIDTH = 16,      //need to confirm with ethan about this.
	parameter SD_ADDRESS_WIDTH = 16,   //need to ^^

	parameter PSRAM_DATA_WIDTH = 8,
	parameter PSRAM_ADDRESS_WIDTH = 24,

    parameter PSRAM_BLOCK_SIZE_BITS = 10,   //number of bits used for the internal psram block index (will vary if I read psram datasheet block read/write incorrectly)
	parameter PSRAM_BLOCK_SIZE = 1024,
	parameter PSRAM_CMD_LENGTH = 8
	)(
	input  clk,
	input  resetn,
	
	//monarch axi interface used to drive settings registers
	input          [MONARCH_DATA_WIDTH-1:0] monarch_axi_tdata,
	input          [MONARCH_ADDRESS_WIDTH-1:0] monarch_axi_taddress,
	input          monarch_axi_tvalid,
	output logic   monarch_axi_tready,

	//spram axi interface for writing to SPRAM (Reading from PSRAM)
	output logic   [SPRAM_DATA_WIDTH-1:0] spram_write_axi_tdata,
	//output logic   [SPRAM_ADDRESS_WIDTH-1:0] spram_write_axi_taddress,   //see above notes about why this may not be necessary.
	output logic   spram_write_axi_tvalid,
	input          spram_write_axi_tready,

	//spram axi interface for reading from SPRAM (Writing to PSRAM)
	input          [SPRAM_DATA_WIDTH-1:0] spram_read_axi_tdata,
	//output logic   [SPRAM_ADDRESS_WIDTH-1:0] spram_read_axi_taddress,    //see above notes about why this may not be necessary.
	output logic   spram_read_axi_tready,
	input          spram_read_axi_tvalid,

	//sd axi interface for writing to SD CARD (Reading from PSRAM)
	output logic   [SD_DATA_WIDTH-1:0] sd_write_axi_tdata,
	//output logic   [SD_ADDRESS_WIDTH-1:0] sd_write_axi_taddress,     //see above notes about why this may not be necessary.
	output logic   sd_write_axi_tvalid,
	input          sd_write_axi_tready,

	//sd axi interface for reading from SD CARD (Writing to PSRAM)
	input          [SD_DATA_WIDTH-1:0] sd_read_axi_tdata,
	//output logic   [SD_ADDRESS_WIDTH-1:0] sd_read_axi_taddress,        //see above notes about why this may not be necessary.
	output logic   sd_read_axi_tready,
	input          sd_read_axi_tvalid,
	
	//psram serial interfaces
	output logic   chip_enable_0,
	input          serial_in_0,
	output logic   serial_out_0,
	output logic   sclk

	);

//constants used for sending psram commands			(double check and verify)
const bit [7:0] SPI_FAST_READ_COMMAND 	= 8'b11010000;
const bit [7:0] SPI_WRITE_COMMAND 		= 8'b01000000;
const int SPI_RW_COOLDOWN 				= 2;		//measured in cc

//state machine
typedef enum {idle,read_cmd,send_read_addr,reading,write_cmd,send_write_addr,writing,blocked} chip_state_enum;
chip_state_enum chip_0_state;
chip_state_enum chip_0_next_state;

//monarch control signals and latches
assign monarch_axi_tready = (chip_0_state == idle);     //ready for another incoming command
logic [MONARCH_DATA_WIDTH-1:0] instruction;
logic [PSRAM_ADDRESS_WIDTH-1:0] read_write_address;

//monarch latcher
always @(posedge clk) begin
	if(resetn==0)begin
		instruction         <= 0;
        read_write_address  <= 0;
	end else begin
		if(monarch_axi_tvalid)begin
			case(monarch_axi_taddress)
				2'b00	:	instruction                 <= monarch_axi_tdata;
				2'b01	:	read_write_address[7:0]     <= monarch_axi_tdata;
				2'b10	:	read_write_address[15:8]    <= monarch_axi_tdata;
				2'b11	:	read_write_address[23:16]   <= monarch_axi_tdata;
			endcase
		end	
	end
end

//PSRAM WRITE FROM THIS SELECTED SOURCE. EXTERNAL SOURCE READ INTERFACE
//select which driver for a psram write (read from spram(ins2 == 0) or sd(ins2 == 1))
logic  [SPRAM_DATA_WIDTH-1:0] selected_driver_data;					//input  into module	(mux)
logic  selected_driver_valid;										//input  into module	(mux)
logic  selected_driver_ready;										//output from module	(decoder)
assign selected_driver_data 		= (instruction[2] == 0)?spram_read_axi_tdata	: sd_read_axi_tdata;
assign selected_driver_valid        = (instruction[2] == 0)?spram_read_axi_tvalid	: sd_read_axi_tvalid;
assign spram_read_axi_tready		= selected_driver_ready & ~instruction[2];
assign sd_read_axi_tready           = selected_driver_ready & instruction[2];

//READ FROM PSRAM AND WRITE TO THIS SELECTED DESTINATION. EXTERNAL ENDPOINT WRITE INTERFACE
//select which endpoint for a psram read	(write to spram(ins3 == 0) or sd(ins3 == 1))
logic  [SPRAM_DATA_WIDTH-1:0] selected_endpoint_data;				//output from module	(decoder)
logic  selected_endpoint_ready;										//output from module	(decoder)
logic  selected_endpoint_valid;										//input  into module	(mux)
assign spram_write_axi_tdata		= selected_endpoint_data;
assign sd_write_axi_tdata	        = selected_endpoint_data;
assign spram_write_axi_tready		= selected_endpoint_ready & ~instruction[3];
assign sd_write_axi_tready      	= selected_endpoint_ready & instruction[3];
assign selected_endpoint_valid		= (instruction[3] == 0)?spram_write_axi_tvalid	: sd_write_axi_tvalid;

//SPI and state machine control signals
logic [PSRAM_DATA_WIDTH-1:0] spi_byte;                  //internal structure used to serialize / deserialize input / output spi data
logic [4:0] s_m_counter;                                //use a small logic instead of 32 bit int       NEEDS TO BE USED FOR: command serialization, write serialization, read serialization, address serialization, waiting for blocking.
logic [PSRAM_BLOCK_SIZE_BITS-1:0] block_counter;
logic state_about_to_switch;
assign state_about_to_switch = (s_m_counter == 1);      //used to trigger external source to provide data just before it is required.
assign sclk = clk;

//drive Serial Out
always_comb begin       //INSTANTIATES A ONE-BIT 8-TO-1 MUX
    case(chip_0_state)
        idle:               serial_out_0 = 0;
        read_cmd:           serial_out_0 = SPI_FAST_READ_COMMAND[s_m_counter];
        send_read_addr:     serial_out_0 = read_write_address[s_m_counter];
        reading:            serial_out_0 = 0;
        write_cmd:          serial_out_0 = SPI_WRITE_COMMAND[s_m_counter];
        send_write_addr:    serial_out_0 = read_write_address[s_m_counter];
        writing:            serial_out_0 = spi_byte[s_m_counter];
        blocked:            serial_out_0 = 0;
    endcase
end

//the following is the control signal to fetch data from SD or SPRAM one clock cycle before it is needed:
//occurs when state is either SEND_WRITE_ADDR or WRITING
//occurs when s_m_counter is one before empty (when transmitting second-to-last serial bit to PSRAM.)
//if the state is WRITING, does not occur if the block counter is 0. (there is no subsequent byte to transmit, so should not provoke SD or SPRAM to send.)
assign selected_driver_ready    =   (s_m_counter == 1) & ((chip_0_state == send_write_addr) | ((chip_0_state == writing) & (block_counter != 0)));

//tell external endpoint to latch the byte when completed transmitting a byte in the psram read state.
assign selected_endpoint_valid  =   (s_m_counter == 0) & (chip_0_state == reading);

//state machine flow
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

//TODO: add wait for valid functionality. could be wait before process start or intermittent pause

always @(posedge clk)begin
    
	if(resetn == 0)begin
	    chip_0_state <= idle;             //reset state to idle state (beginning of SM)
		spi_byte <= 0;                    //clear the serial / deserial reg
		chip_enable_0 <= 1;               //chip enable is active low
	end else begin
	   chip_enable_0 <= ~((chip_0_state != idle) & (chip_0_state != blocked));//TODO: check about this
	   if(chip_0_state == idle)begin
	       if(instruction[0])begin
	           chip_0_state <= read_cmd;
	           s_m_counter <= PSRAM_CMD_LENGTH-1;
	       end else if(instruction[1])begin
	           chip_0_state <= write_cmd;
	           s_m_counter <= PSRAM_CMD_LENGTH-1;
	       end
	   end else if(chip_0_state == read_cmd)begin
			if(s_m_counter == 0)begin		//final clock cycle 
				chip_0_state <= chip_0_next_state;		//go to send read address
				s_m_counter <= PSRAM_ADDRESS_WIDTH-1;     //initialize as maximum value to index MSB first
			end else begin
				s_m_counter <= s_m_counter - 1;
			end
		end else if(chip_0_state == send_read_addr)begin	
			if(s_m_counter == 0)begin
			     chip_0_state <= chip_0_next_state;      //go to reading state.
			     s_m_counter <= PSRAM_DATA_WIDTH-1;        //initialize as maximum value to index MSB first
			     block_counter   <= PSRAM_BLOCK_SIZE-1;
			end else begin
			     s_m_counter <= s_m_counter - 1;
			end
		end else if(chip_0_state == reading)begin //read an entire block
			if(s_m_counter == 0)begin				//collect every serial bit into a parallel vector
				if(block_counter == 0)begin		//READ BLOCK COMPLETE
					chip_0_state <= chip_0_next_state;	//next is blocked state
					s_m_counter <= SPI_RW_COOLDOWN-1;
				end else begin                  //READ NEXT BYTE
					block_counter <= block_counter - 1;
				end
			end else begin
				s_m_counter <= s_m_counter - 1;
				spi_byte[s_m_counter] = serial_in_0;		//collect serial in into byte builder
			end
		end else if(chip_0_state == write_cmd)begin
			if(s_m_counter == 0)begin
				 chip_0_state   <= chip_0_next_state;		//continue to send write address
				 s_m_counter    <= PSRAM_ADDRESS_WIDTH-1;
			end else begin 
				 s_m_counter     <= s_m_counter - 1;
			end
		end else if(chip_0_state == send_write_addr)begin	
			if(s_m_counter == 0)begin
			     spi_byte        <= selected_driver_data[PSRAM_DATA_WIDTH-1:0];	//latch onto the driver's incoming byte.
			     chip_0_state    <= chip_0_next_state;
			     s_m_counter     <= PSRAM_DATA_WIDTH-1;
			     block_counter   <= PSRAM_BLOCK_SIZE-1;
			end else begin
			     s_m_counter     <= s_m_counter - 1;
			end
		end else if(chip_0_state == writing)begin
			if(s_m_counter == 0)begin
				 if(block_counter == 0)begin        //BLOCK WRITE COMPLETE
				 	chip_0_state <= chip_0_next_state;	//next is blocked state
				 	s_m_counter <= SPI_RW_COOLDOWN-1;
				 end else begin                     //WRITE NEXT BYTE
					block_counter <= block_counter - 1;
				 end
				 spi_byte <= selected_driver_data[PSRAM_DATA_WIDTH-1:0];	//latch onto the driver's incoming byte.
				 s_m_counter <= PSRAM_DATA_WIDTH-1;
			end else begin
				s_m_counter <= s_m_counter - 1;
			end
		end else if(chip_0_state == blocked)begin
			if(s_m_counter == 0)begin
			    chip_0_state <= chip_0_next_state;
			end else begin
				s_m_counter <= s_m_counter - 1;
			end
		end
	end
end

endmodule
