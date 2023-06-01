`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2023 03:53:54 PM
// Design Name: 
// Module Name: digital_signal_processor_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module digital_signal_processor_tb();
    logic axis_aclk;
    logic axis_aresetn;
    
    logic prog_axi_valid;
    logic [15:0] prog_axi_data;
    logic execute;
    
    logic ram_axi_0_valid;
    logic [15:0] ram_axi_0_data;
    
    logic dac_axi_valid;
    logic [15:0] dac_axi_data;
    
    digital_signal_processor dsp_0 (.axis_aclk(axis_aclk),
                                    .axis_aresetn(axis_aresetn),
                                    .prog_axi_valid(prog_axi_valid),
                                    .prog_axi_data(prog_axi_data),
                                    .execute(execute),
                                    .ram_axi_0_valid(ram_axi_0_valid),
                                    .ram_axi_0_data(ram_axi_0_data),
                                    .dac_axi_valid(dac_axi_valid),
                                    .dac_axi_data(dac_axi_data));
                                    
    initial begin
        axis_aclk = 0;
        while (1) begin
            axis_aclk = ~axis_aclk;
            #1;
        end
    end
    
    initial begin
        axis_aresetn = 1;
        prog_axi_valid = 0;
        prog_axi_data = 0;
        execute = 0;
        ram_axi_0_valid = 0;
        ram_axi_0_data = 0;
        #2;
        axis_aresetn = 0;
        ram_axi_0_valid = 1;
        for(int i = 0; i < 255; i ++)begin
            ram_axi_0_data = ram_axi_0_data + 1;
            #2;
        end
        ram_axi_0_valid = 0;
        #2;
        prog_axi_valid = 1;
        #2;
        prog_axi_data = 16'hcf40;
        #2;
        prog_axi_valid = 0;
        #2;
        execute = 1;
        
    end
                                       
endmodule

