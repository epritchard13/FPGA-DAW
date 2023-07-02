module verilog_tb;

reg clk = 1;
reg rst = 0;
reg [7:0] spi_data = 0;
reg valid = 0;

initial begin
    repeat(4096*24) begin
        #1 clk = !clk;
    end
end

task write(input [6:0] addr, input [7:0] data);
    spi_data = 8'h89;
    #16 valid = 1;
    #2 valid = 0;

    spi_data = {1'b1, addr[6:0]};
    #16 valid = 1;
    #2 valid = 0;

    spi_data = data;
    #16 valid = 1;
    #2 valid = 0;

    spi_data = 8'h00;
    #16 valid = 1;
    #2 valid = 0;
endtask

task read(input [6:0] addr, output [7:0] data);
    spi_data = 8'h89;
    #16 valid = 1;
    #2 valid = 0;

    spi_data = {1'b0, addr[6:0]};
    #16 valid = 1;
    #2 valid = 0;

    spi_data = 8'h00;
    #16 valid = 1;
    #2 valid = 0;

    spi_data = 8'h00;
    #16 valid = 1;
    #2 valid = 0;
endtask

task fifo_read();
    spi_data = 8'h8A;
    #16 valid = 1;
    #2 valid = 0;

    spi_data = 8'h00;
    #16 valid = 1;
    #2 valid = 0;

    spi_data = 8'h00;
    #16 valid = 1;
    #2 valid = 0;
endtask

initial begin
    #10 rst = 1;
    #6 rst = 0;
    #10;

    write('h24, 2); //set clock divider
    //write('h19, 10);

    //CMD0 (reset)
    write(5, 0);
    write(0, 0);
    #1000;

    //read clock divider
    begin
        logic [7:0] clk_div;
        read('h24, clk_div);
    end

    //CMD2 (get CID)
    /*write(5, 2);
    write(4, 'b10);
    write(0, 0);*/

    //CMD7 (select card)
    write(5, 7);
    write(4, 0);
    write(2, 'h13);
    write(0, 0);
    #2000;

    /*write(5, 55);
    write(4, 0);
    write(2, 0);
    write(0, 0);
    #2000;*/

    write('h44, 7);
    write('h45, 0);

    write(5, 51);
    write(4, 'b01_1_1101);
    write(2, 0);
    write(0, 0);
    #10000;

    //for (int i = 0; i < 16; i++)
    //    fifo_read();

    //CMD17 (read single block)
    //*
    write('h48, 0);
    write('h44, 'hff);
    write('h45, 1);
    write(3, 0);
    write(5, 17);
    write(4, 'b01_1_1101);
    write(3, 0);
    write(2, 0);
    write(0, 0);
    #60000;

    for (int i = 0; i < 512 + 16; i++)
        fifo_read();
end

initial begin
    $dumpfile("verilog_tb.vcd");
    $dumpvars;
end

wire [7:0] spi_data_tx;
wire spi_tx_valid;

SPI_Slave spslv(
	.i_Rst_L(~rst),
	.i_Clk(clk),
	.i_TX_DV(spi_tx_valid),
	.i_TX_Byte(spi_data_tx),
	.i_SPI_Clk(SCLK),
	.i_SPI_CS_n(SS),
	.i_SPI_MOSI(MOSI),

	.o_RX_DV(),
	.o_RX_Byte(),
	.o_SPI_MISO(MISO)
);

wire [7:0] data_in;
wire [7:0] data_out;
wire [6:0] addr;
wire we;

wire sd_fifo_rd;
wire [7:0] sd_fifo_data;

spi_link_sm spi_link_sm(
    .clk(clk),
    .rst(rst),
    .spi_data(spi_data),
    .valid(valid),
    .sd_addr(addr),
    .sd_we(we),
    .sd_data_o(data_in),
    .sd_data_i(data_out),

    .sd_fifo_rd(sd_fifo_rd),
    .sd_fifo_data(sd_fifo_data),

    .spi_data_out(spi_data_tx),
    .spi_tx_valid(spi_tx_valid)
);

wire sd_clk;
wire sd_cmd;
pullup(sd_cmd);

wire [3:0] sd_dat;

genvar i;
generate
for (i = 0; i < 4; i++)
    pullup(sd_dat[i]);
endgenerate

sdc_controller sdc_controller (
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out),
    .we(we),

    .sd_cmd(sd_cmd),
    .sd_dat(sd_dat),

    .sd_clk_o_pad(sd_clk),

    .rd_en_i(sd_fifo_rd),
    .rd_dat_o(sd_fifo_data)
);

wire [15:0] rddata;
wire [39:0] rdaddr;

sd_fake sd_fake(
    .rstn_async(~rst),
    .sdclk(sd_clk),
    .sdcmd(sd_cmd),
    .sddat(sd_dat),

    .rdaddr(rdaddr),
    .rddata(rddata)
);

brom brom(
    .clk(sd_clk),
    .en(1'b1),
    .addr(rdaddr[7:0]),
    .dout(rddata)
);

endmodule