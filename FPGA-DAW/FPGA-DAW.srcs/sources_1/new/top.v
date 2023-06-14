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

reg rst = 0;
reg [3:0] ctr = 3'b111;
always @(posedge SYSCLK) begin
	if (ctr == 3'b111) begin
		rst <= 1;
		ctr <= ctr - 1;
	end else if (ctr != 3'b000) begin
		ctr <= ctr - 1;
	end else begin
		rst <= 0;
	end
end


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

wire [6:0] sd_addr;
wire sd_we;
wire [7:0] sd_data_o;
wire [7:0] sd_data_i;

spi_link_sm spi_sm(
	.clk(SYSCLK),
	.rst(rst),
	.valid(spi_valid),
	.spi_data(spi_data),
	.spi_data_out(spi_data_tx),
	.spi_tx_valid(spi_tx_valid),

	.dac_state(signal_out),

	.sd_addr(sd_addr),
	.sd_we(sd_we),
	.sd_data_o(sd_data_o),
	.sd_data_i(sd_data_i)	
);

sdc_controller sdc_controller0(
	.clk(SYSCLK),
	.rst(rst),

	.addr(sd_addr),
	.we(sd_we),
	.data_in(sd_data_o),
	.data_out(sd_data_i)	
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
