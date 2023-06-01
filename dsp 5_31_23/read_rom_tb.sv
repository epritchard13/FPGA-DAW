`timescale 1ns / 1ps

module read_rom_tb();

parameter width = 16;
logic axis_aclk;
logic axis_aresetn;
logic [width-1:0] write_val;
logic [width-1:0] read_val;
logic valid;
logic ready;
logic [1:0] warning;

ring_fifo ring_fifo_0(.axis_aclk(axis_aclk),
                                    .axis_aresetn(axis_aresetn),
                                    .write_val(write_val),
                                    .read_val(read_val),
                                    .valid(valid),
                                    .ready(ready),
                                    .warning(warning));

initial begin
    axis_aclk = 0;
    while (1) begin
        axis_aclk = ~axis_aclk;
        #1;
    end
end

initial begin
    axis_aresetn = 1;
    write_val = 0;
    valid = 0;
    ready = 0;
    #5;
    axis_aresetn = 0;
    valid = 1;
    for(int i = 0; i < 512; i = i + 1)begin
        write_val = i+16'h55;
        #2;
    end
    valid = 0;
    #20;
    ready = 1;
    #20000;
    ready = 0;
    valid = 1;
    for(int i = 0; i < 5000; i = i + 1)begin
        write_val = i+16'h55;
        #2;
    end
    valid = 0;
    #20;
    ready = 1;
    #20000;
    
    //for(int i = 0; i < 10000; i = i + 1)begin
    //    write_val = i+16'h55;
    //    valid = 1;
    //    #2;
    //    valid = 0;
    //    #20;
    //    ready = 1;
    //end
    $stop;
    
    
end

endmodule

