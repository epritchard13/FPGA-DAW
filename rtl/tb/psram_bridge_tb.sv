`timescale 1ns / 1ps
module psram_bridge_tb();
    logic clk;
    logic reset_n;
    
    logic [23:0] start_pointer;
    logic [4:0] block_size;
    logic send_me_next_byte;
    
    
    logic output_enable;
    logic [7:0] data_out;
    logic write_enable;
    logic [7:0] data_in;
    
    logic chip_enable;
    logic serial_in;
    logic serial_out;
    logic sclk;
    
    psram_bridge psram_bridge(          .clk(clk),
                                        .reset_n(reset_n),
                                        .start_pointer(start_pointer),
                                        .block_size(block_size),
                                        .output_enable(output_enable),
                                        .data_out(data_out),
                                        .write_enable(write_enable),
                                        .data_in(data_in),
                                        .chip_enable(chip_enable),
                                        .serial_in(serial_in),
                                        .serial_out(serial_out),
                                        .sclk(sclk),
                                        .send_me_next_byte(send_me_next_byte));
                                        
    initial begin
        clk = 0;
        reset_n = 0;
        start_pointer = 0;
        block_size = 0;     //must be greater than 0
        output_enable = 0;
        write_enable = 0;
        
        serial_in = 0;      //this must be replaced by psram simulator serial out.
        forever begin
            clk = ~clk;
            #1;
        end
    end
    
    initial begin
        #5;
        reset_n = 1;
        #5;
        start_pointer = 24'b010111001010111111111000;           //full address of where to start read/write
        block_size = 1;                                         //how many 32 byte blocks to transmit.
        #5; 
        write_enable = 1;
        #2
        write_enable = 0;
        #1000;
        $stop;
    end
    
    initial begin
        data_in = 1;
        forever @(posedge clk) begin
            if(send_me_next_byte)begin
                data_in <= data_in + 1;
                #2;
            end
        end
    end



endmodule
