`timescale 1ns/1ns

module spi_loopback_test();

logic clk;
logic sclk;
logic reset;

logic cs;
logic mosi;
logic miso;
logic sck;

logic di_req;
logic [7:0] di;
logic wren;
logic wr_ack;
logic do_valid;
logic [7:0] dout;

logic sl_do_valid;
logic [7:0] sl_dout;
logic sl_di_req;
logic [7:0] sl_di = 8'h10;
logic sl_wren_i = 0;


// drive clock and reset
initial begin
    //$dumpfile("spi_loopback_test.vcd");
    //$dumpvars();
    clk = 0;
    forever begin
        #4 clk = ~clk;
    end
end

initial begin
    sclk = 0;
    forever begin
        #2 sclk = ~sclk;
    end
end

initial begin
    reset = 1;
    #10 reset = 0;
end

initial begin
    di = 8'h10;
end

always @(posedge clk) begin
    wren <= 0;
    if (!reset)
        @ (posedge di_req) begin
            di <= di + 1;
            wren <= 1;
        end
end

always @(posedge clk) begin
    if (!reset)
        @ (posedge sl_di_req) begin
            sl_di <= sl_di + 1;
        end
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

spi_slave spi_slave0(
    .clk_i(clk),
    .spi_ssel_i(cs),
    .spi_sck_i(sck),
    .spi_mosi_i(mosi),
    .spi_miso_o(miso),

    .do_valid_o(sl_do_valid),
    .do_o(sl_dout),

    .di_req_o(sl_di_req),
    .di_i(sl_di),
    .wren_i(sl_di_req)
);

endmodule