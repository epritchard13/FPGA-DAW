`timescale 1ns / 1ps

//SPI command opcodes
`define WRITE_8BIT_REG 8'h87 		//write a value to the test dac
`define RX_DATA 8'h88 				//receive a packet

module spi_link_sm(
	input clk,
	input rst,
	
	input [7:0] spi_data,
	input valid,
	
	output reg [7:0] dac_state
);

enum logic [2:0] {
	WAITING,
	WRITING_8BIT_REG,
	RECEIVING_RX_HEADER,
	RECEIVING_RX_BODY
} state = WAITING;

`define HEADER_SIZE 2 //size of header in bytes
reg [7:0] header [(`HEADER_SIZE - 1):0]; //rx header
reg [15:0] ctr0; //right now just used for rx headers, but could be used for other stuff


always @(posedge clk) begin
	if (rst) begin
		state <= WAITING;
	end
	
	if (valid) begin
		//run the state machine
		case (state)
		//waiting state
		WAITING:
			//see if the opcode is a command
			if (spi_data == `WRITE_8BIT_REG)
				state <= WRITING_8BIT_REG;
			else if (spi_data == `RX_DATA) begin
				state <= RECEIVING_RX_HEADER;
				ctr0 <= 0;
			end
		
		//writing to dac state
		WRITING_8BIT_REG: begin
			state <= WAITING; //go back to waiting
			dac_state <= spi_data;
		end
		
		//receiving data rx header
		RECEIVING_RX_HEADER: begin
			ctr0 <= ctr0 + 1;
			header[ctr0] <= spi_data;
			if (ctr0 == `HEADER_SIZE - 1) begin
				state <= RECEIVING_RX_BODY;
				ctr0 <= 0;
			end
		end
		
		//receiving the data itself
		RECEIVING_RX_BODY: begin
			ctr0 <= ctr0 + 1;
			dac_state <= spi_data;
			if (ctr0 == {header[1], header[0]}) begin //the header should be one less than the actual data size
				state <= WAITING;
			end
		end
		//end of state machine
		endcase
	end
end

endmodule
