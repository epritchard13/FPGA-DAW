`timescale 1ns / 1ps
module FIR_Accelerator_tb();



    logic clk;
    logic reset_n;

    logic push_sample;
    logic [7:0] new_sample;
    
    logic push_coef;
    logic [7:0] new_coef;
    
    logic pop_output;
    logic [7:0] data_out;
    
    
    
    FIR_Accelerator fir(    .clk(clk),
                            .reset_n(reset_n),
                            .push_sample(push_sample),
                            .new_sample(new_sample),
                            .push_coef(push_coef),
                            .new_coef(new_coef),
                            .pop_output(pop_output),
                            .data_out(data_out));
                            
    initial begin
        clk = 0;
        forever begin
            clk = ~ clk;
            #1;
        end
    end
    
    initial begin
        reset_n = 0;
        push_sample = 0;
        new_sample = 0;
        push_coef = 0;
        new_coef = 0;
        pop_output = 0;
        #2;
        reset_n = 1;
        #10;
        
        for(int i = 0; i < 16; i++)begin
        
        push_sample = 1;
        new_sample = 5;
        #2;
        push_sample = 0;
        #2
        push_coef = 1;
        new_coef = i;
        #2;
        new_coef = i+1;
        #2;
        new_coef = i+2;
        #2;
        new_coef = i+3;
        #2;
        push_coef = 0;
        
        #2;
        
        end
        #200;

        $stop;
    end
endmodule
