`timescale 1ns / 1ps

//in progress but this will be a dsp alg

parameter select_dsp = 10;

module spi_slave_dsp(
    input reset,
	input sysclk,

	output reg valid,
	output reg [7:0] spi_data,
	input data_valid,
	input [7:0] input_byte,

	output [7:0] MISO,
	input SS,
	input SCLK,
	input MOSI
    );
    
    
//below is simple warping/interpolation algorithm 
    
logic [31:0] begin_timestamp;
logic [31:0] end_timestamp;
logic [7:0] repitch_factor;
enum {parse,action1, action2, action3} control_state;
logic next_state;
bool satisfied;

   
always @(posedge sysclk) begin
    if (reset) begin
        control_state <= parse;
    end else begin
        if(satisfied) begin
            case (control_state)
                parse: next_state <= action1;
                action1: next_state <= action2;
                action2: next_state <= action3;
                action3: next_state <= parse;
            endcase
        end
    end
end    

logic duration;
assign duration = end_timestamp - begin_timestamp;//will synth an adder

always @(posedge sysclk) begin
    if (reset) begin
        begin_timestamp <= 0;
        end_timestamp <= 0;
        satisfied = 0;
    end else begin
        if(control_state == parse)begin
            if(input_byte == select_dsp)begin
                satisfied <= 1;
            end else begin
                satisfied <= 0;
            end
        end 
    end
end

    
    

endmodule
