`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2023 11:24:10 AM
// Design Name: 
// Module Name: top
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


module top(
	output [3:0] led,
	input sysclk
);

reg [30:0] div = 31'b0;
always @(posedge sysclk) begin
	div <= div + 31'b1;
end

assign led = div[30:(30-4)];

endmodule
