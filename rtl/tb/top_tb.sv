`timescale 1ns/1ps

`include "sd_defines.h"

module top_tb();

logic clk;
logic sclk;
logic reset;

logic cs;
logic mosi;
logic miso;
logic sck;

// SD wires
wire sd_clk;
wire sd_cmd;
wire [3:0] sd_dat;

pullup(sd_cmd);
genvar i;
generate
for (i = 0; i < 4; i++) pullup(sd_dat[i]);
endgenerate

logic di_req;
logic [7:0] di;
logic wren;
logic wr_ack;
logic do_valid;
logic [7:0] dout;

task spi_writeb(bit [7:0] data);
    @(posedge di_req) begin
        di <= data;
        wren <= 1;
    end
endtask

task write(bit [6:0] addr, bit [7:0] data);
    spi_writeb(8'h89);
    spi_writeb({1'b1, addr});
    spi_writeb(data);
    spi_writeb(8'h00);
endtask

task read(bit [6:0] addr);
    spi_writeb(8'h89);
    spi_writeb({1'b0, addr});
    spi_writeb(8'h00);
endtask


// drive clock and reset
initial begin
    //$dumpfile("spi_loopback_test.vcd");
    //$dumpvars();
    clk = 0;
    forever begin
        #8 clk = ~clk;
    end
end

initial begin
    sclk = 0;
    forever begin
        #4.5 sclk = ~sclk;
    end
end

initial begin
    reset = 1;
    #10 reset = 0;
end

initial begin
    di = 8'h00;
end

initial begin
    spi_writeb(8'h00);
    write(`reset, 1);
    write(`reset, 0);
    write('h24, 'h23); //set clock divider
    read('h24);
    write('h24, 0); //set clock divider

    //CMD0 (reset)
    write(5, 0);
    write(0, 0);
    #15000;

    //CMD2 (get CID)
    write(5, 2);
    write(4, 'b00_0_1010);
    write(0, 0);
    #6000;

    //CMD7 (select card)
    write(5, 7);
    write(4, 'b00_1_1101);
    write(2, 'h13);
    write(0, 0);
    #6000;

    //CMD17 (read single block)
    //write('h48, 0);
    //write('h44, 'hff);
    //write('h45, 1);
    write(3, 0);
    write(5, 17);
    write(4, 'b01_1_1101);
    write(3, 0);
    write(2, 0);
    write(1, 0);
    #4;
    write(0, 1);
    #60000;
end

spi_master spi_master0(
    .sclk_i(sclk),
    .pclk_i(clk),
    .rst_i(reset),

    .spi_ssel_o(cs),
    .spi_sck_o(sck),
    .spi_mosi_o(mosi),
    .spi_miso_i(miso),

    .di_req_o(di_req),
    .di_i(di),
    .wren_i(wren),
    .wr_ack_o(wr_ack),
    .do_valid_o(do_valid),
    .do_o(dout)
);

top top_dut(
    .SYSCLK(clk),
    .SS(cs),
    .SCLK(sck),
    .MOSI(mosi),
    .MISO(miso),

    .SD_CLK(sd_clk),
    .SD_CMD(sd_cmd),
    .SD_DAT(sd_dat)
);

logic [15:0] rddata;
logic [39:0] rdaddr;

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