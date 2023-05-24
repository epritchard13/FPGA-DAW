`timescale 1ns / 1ps


//NOT GUNNA WORRY ABOUT compiling until we get the rest of this shit working
//this is a general idea, will def need to revise

//accepts a current magnitude of an input signal and a synchronization clock.
//calculates the average signal's energy during each pre-selected frequency.
//returns an array of the average energies at each frequency.
//each "average energy" is the magnitude that composite frequency


parameter FFT_RESOLUTION = 16;
parameter MIN_FREQ_DET = 100;
parameter MAX_FREQ_DET = 1000;
parameter FREQ_INCREMENT = (MAX_FREQ_DET - MIN_FREQ_DET) / FFT_RESOLUTION;

module fuckitfft(
    input reset,
    input clk,      //assume 50MHz CLK
    input current_magnitude,
    output reg [14:0] fft[FFT_RESOLUTION-1:0]
    );
    
    
logic rolling_average[FFT_RESOLUTION-1:0];
assign fft = rolling_average;
// the following generates the logic to calculate FFT_RES number of ffts. each fft can detect the presence of a frequency
genvar specific_freq;
generate
    for(specific_freq=1; specific_freq<=FFT_RESOLUTION;specific_freq++)begin
    
        //setup initial conditions
        parameter reset_to_value = MIN_FREQ_DET + (specific_freq * FREQ_INCREMENT);
        logic frequency_divider;
        
        
        
        
        //convert the angle to a y value
        logic angle;
        logic y_val;
        look_up_sin LUT_SIN(.angle(angle),.y_val(y_val));
        
        
        //calculate average y_value over duration of fft
        logic y_val_accumulator;
        
        
        always_ff @(posedge clk) begin
            if(reset) begin
                frequency_divider <= reset_to_value;  //reset to max ctr value
                angle <= 0;
                rolling_average[specific_freq] <= 0;
            end else begin
                if(frequency_divider == 0)begin
                    frequency_divider <= reset_to_value;   //reset to max ctr value
                    angle <= angle + 1;//when freq_res is 16, this ranges from 0 to 15 as there is a conversion resolution of 16 steps
                    y_val_accumulator <= y_val_accumulator + (y_val * current_magnitude); //accumulate to calculate average
                    rolling_average[FFT_RESOLUTION] <= y_val_accumulator / FFT_RESOLUTION;
                end else begin
                    frequency_divider <= frequency_divider - 1 ;    //decrement counter
                end
            end
        end
    end
endgenerate






   
    
    
    
endmodule
