`timescale 1ns / 1ps


module Pipelined_Mixer#(
    parameter SAM_WID = 16,
    parameter NUM_TRA = 32,
    parameter CTL_WID = 4
    )(
    //controls
    input clk,
    input resetn,
    input [CTL_WID-1:0] control,
    
    //axi interface from DSP CORE
    input [SAM_WID-1:0] dsp_axi_data,
    input dsp_axi_valid,
    output dsp_axi_ready,
    
    //axi interface out of mixer
    output [SAM_WID-1:0] mix_axi_data,
    output mix_axi_valid,
    input mix_axi_ready
    );
    
reg [2*(SAM_WID-1)-1:0] atten_sam;      //The attenuated sample does not lose precision.
logic select;
assign select = control[3:0];       //subject to change    
always @(posedge clk)begin          //The following case is an approximate decimator. 
    case(select)
        4'h0    : atten_sam <= dsp_axi_data;
        4'h1    : atten_sam <= dsp_axi_data >> 1;
        4'h2    : atten_sam <= dsp_axi_data >> 2;
        4'h3    : atten_sam <= dsp_axi_data >> 3;
        4'h4    : atten_sam <= dsp_axi_data >> 4;
        4'h5    : atten_sam <= dsp_axi_data >> 5;
        4'h6    : atten_sam <= dsp_axi_data >> 6;
        4'h7    : atten_sam <= dsp_axi_data >> 7;
        4'h8    : atten_sam <= dsp_axi_data >> 8;
        4'h9    : atten_sam <= dsp_axi_data >> 9;
        4'ha    : atten_sam <= dsp_axi_data >> 10;
        4'hb    : atten_sam <= dsp_axi_data >> 11;
        4'hc    : atten_sam <= dsp_axi_data >> 12;
        4'hd    : atten_sam <= dsp_axi_data >> 13;
        4'he    : atten_sam <= dsp_axi_data >> 14;
        4'hf    : atten_sam <= 0;
        default : atten_sam <= 0;
    endcase
end


reg [NUM_TRA-1:0] acc_buff [2*(SAM_WID-1)-1:0];
logic read_ptr;
logic write_ptr;
reg [2*(SAM_WID-1)-1:0] delay;

always @(posedge clk) begin
    if(resetn == 0)begin
        read_ptr <= 0;
        write_ptr <= 0;
        for(int i=0; i<NUM_TRA; i=i+1)begin
            acc_buff[i] <= 0;
        end
    end else begin
        if(dsp_axi_valid)begin
            //read value to be accumulated to
            delay <= acc_buff[read_ptr] + atten_sam;
            read_ptr <= read_ptr + 1;
        
            //write sum back to buffer
            acc_buff[write_ptr] <= delay;
            write_ptr <= write_ptr + 1;
        end
    end
end

endmodule
