`timescale 1ns / 1ps

module top(
	input SYSCLK,
	
	input SS,
	input SCLK,
	input MOSI,
	output MISO,
	
	output A_OUT,
	output [3:0] LED
);

wire spi_valid;
wire [7:0] spi_data;
wire [7:0] spi_data_tx;
wire spi_tx_valid;
wire [7:0] signal_out;

SPI_Slave spslv(
	.i_Rst_L(1'b1),
	.i_Clk(SYSCLK),
	.i_TX_DV(spi_tx_valid),
	.i_TX_Byte(spi_data_tx),
	.i_SPI_Clk(SCLK),
	.i_SPI_CS_n(SS),
	.i_SPI_MOSI(MOSI),

	.o_RX_DV(spi_valid),
	.o_RX_Byte(spi_data),
	.o_SPI_MISO(MISO)
);

spi_link_sm spi_sm(
	.clk(SYSCLK),
	.rst(1'b0),
	.valid(spi_valid),
	.spi_data(spi_data),
	.spi_data_out(spi_data_tx),
	.spi_tx_valid(spi_tx_valid),

	.dac_state(signal_out)
);

pwm_dac pwmdac(
	.clk(SYSCLK),
	.val(signal_out),
	.analog(A_OUT)
);
/*
psram_controller psram0(
	.clk(SYSCLK),
	.rst(1'b0)
);*/

endmodule
