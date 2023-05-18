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
	input sysclk,
	
	inout [7:0] je,
	output [2:0] rgb
);

assign rgb[1:0] = 2'b0; // not used now
/*
reg [30:0] div = 31'b0;
always @(posedge sysclk) begin
	div <= div + 31'b1;
end
assign led = div[30:(30-4)];
//*/

wire [7:0] spi_data;
wire valid;


//SPI stuff
spi spi0(
	.rst(1'b0),
	.clk(1'b0),
	.spi_miso(je[0]),
	.spi_cs(je[1]),
	.spi_clk(je[2]),
	.spi_mosi(je[3]),

	.data_out(spi_data),
	.valid(valid),
	
	.data_in(8'b0),
	.data_write(1'b0)
);

reg [7:0] spi_out = 8'b0;
always @(posedge sysclk) begin
	if (valid) begin
		spi_out <= spi_data;
	end
end

assign led = spi_out[3:0];


// PWM DAC
pwm_dac dac(sysclk, spi_out, rgb[2]);

endmodule
