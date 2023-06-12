module verilog_tb;
	reg sd_clk_o = 0;
	reg reset = 0;
	initial begin
		repeat(4096*8) begin
			#1 sd_clk_o = !sd_clk_o;
		end
	end

	initial begin
		$dumpfile("verilog_tb.vcd");
		$dumpvars;
	end

	//SD clock
	//wire sd_sd_clk_o; //Sd_sd_clk_o used in the system
	wire [3:0] wr_wbm_sel;
	wire [`BLKSIZE_W+`BLKCNT_W-1:0] xfersize;
	wire [31:0] wbm_adr;

	wire go_idle;
	wire cmd_start_wb_sd_clk_o;
	wire cmd_start_sd_sd_clk_o;
	wire cmd_start;
	wire [1:0] cmd_setting;
	wire cmd_start_tx;
	wire [39:0] cmd;
	wire [119:0] cmd_response;
	wire cmd_crc_ok;
	wire cmd_index_ok;
	wire cmd_finish;

	wire d_write;
	wire d_read;
	wire [31:0] data_in_rx_fifo;
	wire [31:0] data_out_tx_fifo;
	wire start_tx_fifo;
	wire start_rx_fifo;
	wire tx_fifo_empty;
	wire tx_fifo_full;
	wire rx_fifo_full;
	wire sd_data_busy;
	wire data_busy;
	wire data_crc_ok;
	wire rd_fifo;
	wire we_fifo;

	wire data_start_rx;
	wire data_start_tx;
	wire cmd_int_rst_wb_sd_clk_o;
	wire cmd_int_rst_sd_sd_clk_o;
	wire cmd_int_rst;
	wire data_int_rst_wb_sd_clk_o;
	wire data_int_rst_sd_sd_clk_o;
	wire data_int_rst;
	
	reg cmd_start_sd_clk = 0;
	reg cmd_int_rst_sd_clk = 0;
	reg [31:0] argument_reg_sd_clk = 0;
	reg [`CMD_REG_SIZE-1:0] command_reg_sd_clk = 0;
	reg [`CMD_TIMEOUT_W-1:0] cmd_timeout_reg_sd_clk = 0;



	initial begin
		#10 reset = 1;
		#10 reset = 0;
		#10 reset=0;

		cmd_start_sd_clk = 1;
		#2 cmd_start_sd_clk = 0;
		while (int_status_o == 4'b0) begin
			#1;
		end

		

	end

wire sdcmd;
assign sdcmd = sd_cmd_out_o;

sd_fake sd_fake0(
	.rstn_async(~reset),
	.sdcmd(sdcmd),
	.sdclk(sd_clk_o)
);


sd_cmd_master sd_cmd_master0(
	.sd_clk       (sd_clk_o),
	//.rst          (wb_rst_i | software_reset_reg_sd_clk[0]),
	.rst(reset),
	.start_i      (cmd_start_sd_clk),
	.int_status_rst_i(cmd_int_rst_sd_clk),
	.setting_o    (cmd_setting),
	.start_xfr_o  (cmd_start_tx),
	.go_idle_o    (go_idle),
	.cmd_o        (cmd),
	.response_i   (cmd_response),
	.crc_ok_i     (cmd_crc_ok),
	.index_ok_i   (cmd_index_ok),
	.busy_i       (sd_data_busy),
	.finish_i     (cmd_finish),
	.argument_i   (argument_reg_sd_clk),
	.command_i    (command_reg_sd_clk),
	.timeout_i    (cmd_timeout_reg_sd_clk),
	.int_status_o (cmd_int_status_reg_sd_clk),
	.response_0_o (response_0_reg_sd_clk),
	.response_1_o (response_1_reg_sd_clk),
	.response_2_o (response_2_reg_sd_clk),
	.response_3_o (response_3_reg_sd_clk)
	);

sd_cmd_serial_host cmd_serial_host0(
	.sd_clk     (sd_clk_o),
	//.rst        (wb_rst_i | software_reset_reg_sd_clk[0] | go_idle),
	.rst(reset),
	.setting_i  (cmd_setting),
	.cmd_i      (cmd),
	.start_i    (cmd_start_tx),
	.finish_o   (cmd_finish),
	.response_o (cmd_response),
	.crc_ok_o   (cmd_crc_ok),
	.index_ok_o (cmd_index_ok),
	.cmd_dat_i  (sd_cmd_dat_i),
	.cmd_out_o  (sd_cmd_out_o),
	.cmd_oe_o   (sd_cmd_oe_o)
	);
//*
sd_data_master sd_data_master0(
	.sd_clk           (sd_clk_o),
	//.rst              (wb_rst_i | software_reset_reg_sd_clk[0]),
	.rst(reset),
	.start_tx_i       (data_start_tx),
	.start_rx_i       (data_start_rx),
	.timeout_i		  (data_timeout_reg_sd_clk),
	.d_write_o        (d_write),
	.d_read_o         (d_read),
	.start_tx_fifo_o  (start_tx_fifo),
	.start_rx_fifo_o  (start_rx_fifo),
	.tx_fifo_empty_i  (tx_fifo_empty),
	.tx_fifo_full_i   (tx_fifo_full),
	.rx_fifo_full_i   (rx_fifo_full),
	.xfr_complete_i   (!data_busy),
	.crc_ok_i         (data_crc_ok),
	.int_status_o     (data_int_status_reg_sd_clk),
	.int_status_rst_i (data_int_rst_sd_clk)
	);

sd_data_serial_host sd_data_serial_host0(
	.sd_clk         (sd_clk_o),
	//.rst            (wb_rst_i | software_reset_reg_sd_clk[0]),
	.rst(reset),
	.data_in        (data_out_tx_fifo),
	.rd             (rd_fifo),
	.data_out       (data_in_rx_fifo),
	.we             (we_fifo),
	.DAT_oe_o       (sd_dat_oe_o),
	.DAT_dat_o      (sd_dat_out_o),
	.DAT_dat_i      (sd_dat_dat_i),
	.blksize        (block_size_reg_sd_clk),
	//.bus_4bit       (controll_setting_reg_sd_clk[0]),
	.blkcnt         (block_count_reg_sd_clk),
	.start          ({d_read, d_write}),
	.byte_alignment (dma_addr_reg_sd_clk),
	.sd_data_busy   (sd_data_busy),
	.busy           (data_busy),
	.crc_ok         (data_crc_ok)
	);//*/
endmodule