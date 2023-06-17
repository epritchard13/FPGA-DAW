`timescale 1ns / 1ps

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
