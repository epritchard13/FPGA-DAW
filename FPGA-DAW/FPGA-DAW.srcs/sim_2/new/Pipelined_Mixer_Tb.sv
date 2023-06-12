`timescale 1ns / 1ps

module Pipelined_Mixer_Tb#(
    parameter SAM_WID = 4,
    parameter NUM_TRA = 4,
    parameter CTL_WID = 4);

    logic clk;
    logic resetn;
    logic [CTL_WID-1:0] control;
    logic [SAM_WID-1:0] dsp_axi_data;
    logic dsp_axi_valid;
    logic dsp_axi_ready;
    logic [SAM_WID-1:0] mix_axi_data;
    logic mix_axi_valid;
    logic mix_axi_ready;
    
    Pipelined_Mixer plm(.clk(clk),
                        .resetn(resetn),
                        .control(control),
                        .dsp_axi_data(dsp_axi_data),
                        .dsp_axi_valid(dsp_axi_valid),
                        .dsp_axi_ready(dsp_axi_ready),
                        .mix_axi_data(mix_axi_data),
                        .mix_axi_valid(mix_axi_valid),
                        .mix_axi_ready(mix_axi_ready));
                        
    initial begin
        clk = 0;
        forever begin
            clk = ~clk;
            #2;
        end
    end
    initial begin
        resetn = 0;
        control = 5;
        dsp_axi_data = 5555;
        dsp_axi_valid = 0;
        mix_axi_ready = 0;
        #10;
        resetn = 1;
        #10;
        dsp_axi_valid = 1;
        mix_axi_ready = 1;
        #2000;
        $stop;
    end

endmodule
