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
`define WAITING 2'b0
`define WRITING_DAC 2'b1

//SPI command opcodes
`define WRITE_DAC 8'h87 //write a value to the test dac
`define WRITE_RGB 8'h88 //write to the RGB LED

module spi_link_sm(
	input clk,
	input rst,
	
	input [7:0] spi_data,
	input valid,
	
	output reg [7:0] dac_state
);


reg [1:0] state = `WAITING; //TODO: maybe remove when reset is functional


always @(posedge clk) begin
	if (rst) begin
		state <= `WAITING;
	end
	
	if (valid) begin
	
		//run the state machine
		//waiting state
		if (state == `WAITING) begin
			//see if the opcode is a command
			case (spi_data)
				`WRITE_DAC: state <= `WRITING_DAC;
			endcase
			
		//writing to dac state
		end else if (state == `WRITING_DAC) begin
			state <= `WAITING; //go back to waiting
			dac_state <= spi_data;
		end
		//end of state machine
		
	end
end

endmodule
