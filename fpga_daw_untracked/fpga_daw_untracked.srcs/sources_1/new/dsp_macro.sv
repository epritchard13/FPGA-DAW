`timescale 1ns / 1ps
module dsp_macro(
    input  clk,
    input  resetn,
    input  [15:0] operandA,
    input  [15:0] operandB,
    input  [31:0] operandC,
    output [31:0] productP
    );
    
    
assign productP = (operandA * operandB) + operandC;    
    
endmodule
