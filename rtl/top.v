`timescale 1ns / 1ps

module top(
	input SYSCLK,
	
	input SS,
	input SCLK,
	input MOSI,
	output MISO,
	
	output A_OUT,

	inout SD_CMD,
	inout [3:0] SD_DAT,
	//input SD_CLK_I,
	output SD_CLK

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

wire spi_slave_wr;

spi_slave spi_slave0(
	.clk_i(SYSCLK),
	.spi_ssel_i(SS),
	.spi_sck_i(SCLK),
	.spi_mosi_i(MOSI),
	.spi_miso_o(MISO),

	.do_valid_o(spi_valid),
	.do_o(spi_data),

	.di_req_o(spi_slave_wr),
	.di_i(spi_data_tx),
	.wren_i(spi_tx_valid),
	.wr_ack_o()
);

wire [6:0] sd_addr;
wire sd_we;
wire [7:0] sd_data_o;
wire [7:0] sd_data_i;

wire sd_rd_en_i;
wire [7:0] sd_rd_dat_o;
wire sd_wr_en_i;
wire [7:0] sd_wr_dat_i;

wire spi_sd_rd_en_i;
wire [7:0] spi_sd_rd_dat_o;
wire spi_sd_wr_en_i;
wire [7:0] spi_sd_wr_dat_i;

wire fpga_sd_rd_en_i = 1'b0;
wire [7:0] fpga_sd_rd_dat_o;
wire fpga_sd_wr_en_i = 1'b0;
wire [7:0] fpga_sd_wr_dat_i = 8'b0;

spi_fpga_mux spi_fpga_mux0(
	.fpga_mode(1'b0),

	.rd_en(sd_rd_en_i),
	.rd_dat(sd_rd_dat_o),

	.wr_en(sd_wr_en_i),
	.wr_dat(sd_wr_dat_i),

	.rd_en0(spi_sd_rd_en_i),
	.rd_dat0(spi_sd_rd_dat_o),
	.wr_en0(spi_sd_wr_en_i),
	.wr_dat0(spi_sd_wr_dat_i),

	.rd_en1(fpga_sd_rd_en_i),
	.rd_dat1(fpga_sd_rd_dat_o),
	.wr_en1(fpga_sd_wr_en_i),
	.wr_dat1(fpga_sd_wr_dat_i)
);

spi_link_sm spi_sm(
	.clk(SYSCLK),
	.rst(rst),
	.valid(spi_valid),
	.spi_data(spi_data),
	.spi_data_out(spi_data_tx),
	.spi_tx_valid(spi_tx_valid),

	.sd_addr(sd_addr),
	.sd_we(sd_we),
	.sd_data_o(sd_data_o),
	.sd_data_i(sd_data_i),

	.sd_fifo_rd(spi_sd_rd_en_i),
    .sd_fifo_data_i(spi_sd_rd_dat_o),

	.sd_fifo_we(spi_sd_wr_en_i),
    .sd_fifo_data_o(spi_sd_wr_dat_i)
);

sdc_controller sdc_controller0(
	.clk(SYSCLK),
	.rst(rst),

	.addr(sd_addr),
	.we(sd_we),
	.data_in(sd_data_o),
	.data_out(sd_data_i),

	.sd_cmd(SD_CMD),
	.sd_dat(SD_DAT),

	.sd_clk_o_pad(SD_CLK),

	.rd_en_i(sd_rd_en_i),
    .rd_dat_o(sd_rd_dat_o),

	.wr_en_i(sd_wr_en_i),
    .wr_dat_i(sd_wr_dat_i)
);

pwm_dac pwmdac(
	.clk(SYSCLK),
	//.val(sdc_controller0.sd_data_serial_host0.debug_out),
	.analog(A_OUT)
);

endmodule
