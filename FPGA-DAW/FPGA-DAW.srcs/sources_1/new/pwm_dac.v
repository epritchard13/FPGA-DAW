`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2023 09:12:23 PM
// Design Name: 
// Module Name: pwm_dac
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

module pwm_dac(
	input clk,			// clock
	input [7:0] val,	// 8-bit digital input
	output analog		// PWM output
);

reg [7:0] ctr;
always @(posedge clk) begin
	ctr <= ctr + 1;
end

assign analog = ctr < val;

endmodule
