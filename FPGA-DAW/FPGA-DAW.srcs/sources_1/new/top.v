`timescale 1ns / 1ps

module top(
	output [3:0] led,
	input sysclk,
	
	inout [7:0] je,
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

	.o_SPI_MISO(je[0]),
	.i_SPI_CS_n(je[1]),
	.i_SPI_Clk(je[2]),
	.i_SPI_MOSI(je[3])
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
assign je[4] = analog_out;

endmodule
