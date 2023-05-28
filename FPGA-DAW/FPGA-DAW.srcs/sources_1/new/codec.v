`timescale 1ns / 1ps

module codec(
	input clk, 				// should be about 100MHz. This module divides it by 8
	input rst,

	output ac_mclk, 		// aiming for 12.288MHz
	output ac_bclk,
	output ac_muten,
	output IIC_scl_io,
	output IIC_sda_io,
	
	input ac_recdat,
	input ac_reclrc,
	
	output [1:0] test_fw
);

// forward recording outputs
assign test_fw = {ac_recdat, ac_reclrc};

// hopefully the codec works without these
assign IIC_scl_io = 1'b1;
assign IIC_sda_io = 1'b1;

// This needs to be high
assign ac_muten = 1'b1;

reg [2:0] clock_div;
always @(posedge clk) clock_div <= clock_div + 1;

// Divide clk by 8
assign ac_mclk = clock_div[2];

// should work?
assign ac_bclk = ac_mclk;

endmodule
