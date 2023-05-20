`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/18/2023 07:59:56 PM
// Design Name: 
// Module Name: spi_link_sm
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

// SM states
`define WAITING 0
`define WRITING_8BIT_REG 1

`define RECEIVING_RX_HEADER 2
`define RECEIVING_RX_BODY 3

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


reg [2:0] state = `WAITING; //TODO: maybe remove when reset is functional

`define HEADER_SIZE 2 //size of header in bytes
reg [7:0] header [(`HEADER_SIZE - 1):0]; //rx header
reg [15:0] ctr0; //right now just used for rx headers, but could be used for other stuff


always @(posedge clk) begin
	if (rst) begin
		state <= `WAITING;
	end
	
	if (valid) begin
	
		//run the state machine
		//waiting state
		if (state == `WAITING) begin
			//see if the opcode is a command
			if (spi_data == `WRITE_8BIT_REG)
				state <= `WRITING_8BIT_REG;
			else if (spi_data == `RX_DATA) begin
				state <= `RECEIVING_RX_HEADER;
				ctr0 <= 0;
			end
		end
		
		//writing to dac state
		else if (state == `WRITING_8BIT_REG) begin
			state <= `WAITING; //go back to waiting
			dac_state <= spi_data;
		end
		
		//receiving data rx header
		else if (state == `RECEIVING_RX_HEADER) begin
			ctr0 <= ctr0 + 1;
			header[ctr0] <= spi_data;
			if (ctr0 == `HEADER_SIZE - 1) begin
				state <= `RECEIVING_RX_BODY;
				ctr0 <= 0;
			end
		end
		
		else if (state == `RECEIVING_RX_BODY) begin
			ctr0 <= ctr0 + 1;
			if (ctr0 == {header[0], header[1]}) begin //the header should be one less than the actual data size
				state <= `WAITING;
			end
		end
		//end of state machine
		
	end
end

endmodule
