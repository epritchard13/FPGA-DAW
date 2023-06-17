module verilog_tb();

reg clk = 0;
reg rst = 0;

initial repeat (4096*12) #1 clk = ~clk;

reg [6:0] addr;
reg we = 0;
reg [7:0] data_in;
wire [7:0] data_out;

task write(input [6:0] addr_in, input [7:0] data);
    addr = addr_in;
    data_in = data;
    #2 we = 1;
    #2 we = 0;
endtask

initial begin
    $dumpfile("verilog_tb.vcd");
    $dumpvars;
    #3 rst = 1;
    #2 rst = 0;
    #50;

    //CMD0 (reset)
    write(5, 0);
    write(0, 0);
    #500;

    //CMD2 (get CID)
    /*write(5, 2);
    write(4, 'b10);
    write(0, 0);*/

    //CMD7 (select card)
    write(5, 7);
    write(4, 0);
    write(2, 'h13);
    write(0, 0);
    #1000;

    write(5, 55);
    write(4, 0);
    write(2, 'h13);
    write(0, 0);
    #1000;

    //CMD17 (read single block)
    write(5, 51);
    write(4, 'b0111101);
    write(0, 0);

end

wire sd_clk;
wire sd_cmd_out;
wire sd_cmd_in;

wire [3:0] sd_data_in;
pullup(sd_data_in[0]);
pullup(sd_data_in[1]);
pullup(sd_data_in[2]);
pullup(sd_data_in[3]);


wire [3:0] sd_data_out;

wire [15:0] rddata;
wire [39:0] rdaddr;

sdc_controller sdc_controller (
    .clk(clk),
    .rst(rst),
    .addr(addr),
    .data_in(data_in),
    .data_out(data_out),
    .we(we),

    .sd_cmd_out_o(sd_cmd_out),
    .sd_cmd_dat_i(sd_cmd_in),
    .sd_dat_dat_i(sd_data_in),
    .sd_dat_out_o(sd_data_out),

    .sd_clk_o_pad(sd_clk)
);

sd_fake sd_fake(
    .rstn_async(~rst),
    .sdclk(sd_clk),
    .sdcmdout(sd_cmd_in),
    .sdcmdin(sd_cmd_out),
    .sddat(sd_data_in),

    .rdaddr(rdaddr),
    .rddata(rddata)
);

brom brom(
    .clk(sd_clk),
    .en(1'b1),
    .addr(rdaddr),
    .dout(rddata)
);

endmodule