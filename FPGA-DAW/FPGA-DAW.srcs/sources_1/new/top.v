`timescale 1ns / 1ps

module top(
	output [3:0] led,
	input sysclk,
	
	input MOSI, SCLK, SS,
	output MISO, A_OUT,
	output [2:0] rgb
);

wire [7:0] spi_data;
wire valid;
reg reset = 1'b1;

//spi stuff
SPI_Slave spi0(
	.i_Rst_L(reset),
	.i_Clk(sysclk),

	.o_RX_DV(valid),
	.o_RX_Byte(spi_data),
	.i_TX_DV(1'b0),
	.i_TX_Byte(8'b0),

	.o_SPI_MISO(MISO),
	.i_SPI_CS_n(SS),
	.i_SPI_Clk(SCLK),
	.i_SPI_MOSI(MOSI)
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
assign A_OUT = analog_out;

endmodule
