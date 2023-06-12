`timescale 1ns / 1ps

module Pipelined_Mixer_Tb#(
    parameter SAM_WID = 16,
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
    integer file;
    integer scan_file;
    logic [SAM_WID-1:0] data;
    
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
        file = $fopen("sin.txt","r");
    end
                        
    initial begin
        clk = 0;
        forever begin
            clk = ~clk;
            scan_file = $fscanf(data_file, "%d\n", data);
            #2;
        end
    end
    initial begin
        resetn = 0;
        control = 5;
        dsp_axi_data = data;
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
