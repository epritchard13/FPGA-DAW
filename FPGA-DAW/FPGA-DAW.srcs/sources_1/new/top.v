`timescale 1ns / 1ps

module top(
	output [3:0] led,
	input sysclk,
	
	input [7:0] spi_data,
	input valid,

	output [2:0] rgb
);

reg [7:0] spi_byte = 8'b0;
always @(posedge sysclk) begin
	if (valid) begin
		spi_byte <= spi_data;
	end
end

assign led = spi_byte[3:0];


// PWM DAC
wire analog_out;
pwm_dac dac(sysclk, spi_byte, analog_out);
assign rgb = 3'b0;//{3{analog_out}};

endmodule
