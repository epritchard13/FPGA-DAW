`timescale 1ns / 1ps


//each connected module provides an address to the mux before this block. These addresses are 16 bits, making the smallest write increment to PSRAM 256 bits.




module psram_bridge#(
    parameter PSRAM_DATA_WIDTH = 8,
    parameter PSRAM_CMD_LENGTH = 8,
	parameter PSRAM_ADDRESS_WIDTH = 24
	
    )(
    //controls
    input logic clk,
    input logic reset_n,

    //Bridge to Mux address
    input logic [23:0] start_pointer,
    input logic [4:0] block_size,

    //Bridge to Mux interface
    input logic output_enable,
    output logic[7:0] data_out,
    input logic write_enable,
    input logic [7:0] data_in,
    
    
    //psram serial interfaces
	output logic   chip_enable,
	input          serial_in,
	output logic   serial_out,
	output logic   sclk,
	
	//communication interface
	output logic undergoing_command,
	output logic send_me_next_byte
    
    
    
    );
    
//constants used for sending psram commands			(double check and verify)
const bit [7:0] SPI_READ_WRITE_COMMANDS = 16'b0000101100000010;
const int SPI_RW_COOLDOWN 				= 2;		//measured in cc
    
//State machine enumeration
typedef enum {idle,send_cmd,send_addr,read_write,blocked} chip_state_enum;
chip_state_enum chip_state;
chip_state_enum chip_next_state;    

//this always block is used to handle state machine flow.
logic [9:0] remaining_bytes;
logic [PSRAM_ADDRESS_WIDTH-1:0] current_address;
logic [4:0] s_m_counter;
always @(posedge clk) begin
	if(reset_n == 0)begin
		chip_next_state <= idle;
	end else begin
		case(chip_state)
			idle:			chip_next_state	<= idle;
			send_cmd:		chip_next_state	<= send_addr;
			send_addr:      chip_next_state <= read_write;
			read_write:		chip_next_state	<= (remaining_bytes == 0) ? blocked : (current_address[9:0] == 10'b1111111111) ? send_cmd : read_write;
			blocked:		chip_next_state	<= idle;
			default:		chip_next_state	<= idle;
		endcase
	end
end








logic [7:0] latched_data_in;
always_ff @(posedge clk) begin
    if(reset_n == 0)begin
        s_m_counter <= 0;
        chip_state <= idle;
        remaining_bytes <= 0;
        current_address <= 0;
        latched_data_in <= 0;
    end else begin
        if(s_m_counter == 0)begin      //every byte
            case(chip_state)
                idle:           s_m_counter <= (output_enable || write_enable) ? (PSRAM_CMD_LENGTH-1) : 3'b000;         //this gated value will be 0 until output enable or write enable. upon either being high, if WE is high, write cmd is transmitted.       
                send_cmd:       s_m_counter <= PSRAM_ADDRESS_WIDTH-1;
                send_addr:      s_m_counter <= PSRAM_DATA_WIDTH-1;
                read_write:     s_m_counter <= (remaining_bytes == 0) ? SPI_RW_COOLDOWN-1 : (current_address[9:0] == 10'b1111111111) ? PSRAM_CMD_LENGTH-1 : PSRAM_DATA_WIDTH-1;
                blocked:        s_m_counter <= 0;
                default:        s_m_counter <= 0;
            endcase
        
        
            chip_state <= chip_next_state;
        end else begin
            s_m_counter <= s_m_counter - 1;
        end
    
        if(chip_state == idle)begin
            if((output_enable || write_enable)&&(block_size > 0))begin
                chip_state <= send_cmd;
                current_address <= start_pointer;
                remaining_bytes <= {block_size, 5'b00000}-1;
            end
        end else if(chip_state == read_write)begin
            if(s_m_counter == 0)begin
                remaining_bytes <= remaining_bytes-1;
                current_address <= current_address+1;
                latched_data_in <= data_in;
            end
        end
    end
end


assign chip_enable = ~((chip_state != idle) & (chip_state != blocked));
assign undergoing_command = (chip_state != idle);
assign send_me_next_byte = (chip_next_state == read_write) && (remaining_bytes != 0) && (s_m_counter == 1);
    
always @(posedge clk) begin
    if(reset_n == 0)begin
        data_out <= 0;
    end else begin 
        if(chip_state == read_write)begin
            data_out[s_m_counter] <= serial_in;   
        end       
    end
end






//drive Serial Out
assign sclk = clk;
always_comb begin
    case(chip_state)
        idle:               serial_out = 0;
        send_cmd:           serial_out = SPI_READ_WRITE_COMMANDS[{write_enable,s_m_counter}];           //writing takes precedent over reading.
        send_addr:          serial_out = current_address[s_m_counter];
        read_write:         serial_out = latched_data_in[s_m_counter];                  // in this setup, the serial out will be driven during a read. This will only work for SPI. not QPI.
        blocked:            serial_out = 0;
    endcase
end

endmodule
