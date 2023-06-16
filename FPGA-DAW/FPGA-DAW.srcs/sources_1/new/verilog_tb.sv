module verilog_tb();

reg clk = 0;
reg rst = 0;

initial repeat (4096*4) #1 clk = ~clk;

reg [6:0] addr;
reg we = 0;
reg [7:0] data_in;
wire [7:0] data_out;

function void write(input [6:0] addr_in, input [7:0] data);
    addr = addr_in;
    data_in = data;
endfunction

initial begin
    $dumpfile("verilog_tb.vcd");
    $dumpvars;
    #3 rst = 1;
    #2 rst = 0;

    #50;
    write(0, 0);
    #2 we = 1;
    #2 we = 0;

    write(5, 0);
    #2 we = 1;
    #2 we = 0;

    data_in = 8'b0;
    #2 addr = 7'b0000000;
    #2 we = 1;
    #2 we = 0;

    #500;

    write('h5, 2);
    #2 we = 1;
    #2 we = 0;

    data_in = 8'b10;
    #2 addr = 7'h4;
    #2 we = 1;
    #2 we = 0;

    data_in = 8'b0;
    #2 addr = 7'h1;
    #2 we = 1;
    #2 we = 0;

    write(0, 0);
    we = 1;
    #2 we = 0;

end

wire [3:0] sd_dat_dat_i;
wire [3:0] sd_dat_out_o;
wire sd_clk_o_pad;

wire sdcmd;
pullup(sdcmd);

sdc_controller sdc_controller (
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out),
    .we(we),
    .sd_cmd(sdcmd),

    .sd_clk_o_pad(sd_clk_o_pad)
);

sd_fake sd_fake(
    .rstn_async(~rst),
    .sdclk(sd_clk_o_pad),
    .sdcmd(sdcmd),
    .sddat(sd_dat_out_o)
);

endmodule