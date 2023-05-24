`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/23/2023 08:57:41 PM
// Design Name: 
// Module Name: LUT_SIN
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


//THIS IS ACCOMPANIED BY A PYTHON SCRIPT WHICH GENERATES A CASE STATEMENT OF 2^N SIZE!!

module LUT_SIN(
    input [3:0] angle,
    output reg y_val
    );
    
    
    always @(angle) begin
    case(angle)
        4'd0: y_val = 16384;
        4'd1: y_val = 22653;
        4'd2: y_val = 27968;
        4'd3: y_val = 31519;
        4'd4: y_val = 32767;
        4'd5: y_val = 31519;
        4'd6: y_val = 27968;
        4'd7: y_val = 22653;
        4'd8: y_val = 16384;
        4'd9: y_val = 10115;
        4'd10: y_val = 4800;
        4'd11: y_val = 1249;
        4'd12: y_val = 1;
        4'd13: y_val = 1249;
        4'd14: y_val = 4800;
        4'd15: y_val = 10115;
    endcase
    end
    
endmodule
