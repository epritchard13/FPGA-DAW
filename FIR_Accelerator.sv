`timescale 1ns / 1ps

module FIR_Accelerator#(
    parameter FIFO_DEPTH = 64,
    parameter FIR_LENGTH = 4,
    parameter NUMBER_OF_DSP_BLOCKS = 4,
    parameter DSP_COOLDOWN_COUNTER_BITS = 2, //this indicates that the dsp blocks' internal pipeline requires 2^DSP_COOLDOWN clock cycles until result is available. (this should be 1 in practice)
    parameter COOLDOWN_MAX_VAL = 3      //number of cc for cooldown.
    )(
    input clk,
    input reset_n,

    input push_sample,
    input [7:0] new_sample,
    
    input push_coef,
    input [7:0] new_coef,
    
    input pop_output,
    output logic [7:0] data_out
    
    
    );
    
typedef enum {idle, push_ops, compute, pop_out} states;
states state;

  
logic [7:0] temp_result; 

const int FIR_BLOCK_LOOP_ITERS = FIR_LENGTH / NUMBER_OF_DSP_BLOCKS;
    
logic [7:0] sample_fifo[FIFO_DEPTH]; 
logic [7:0] coef_fifo[FIFO_DEPTH]; 
logic [7:0] output_fifo[FIFO_DEPTH]; 

logic [5:0] sample_pointer;
logic [5:0] coef_pointer;
logic [5:0] output_pointer;

logic pop_dispose_sample_fifo;
logic pop_dispose_coef_fifo;
logic push_output_fifo;


//A note about the input and output fifos:
//no size protection is built in as this is a testbench module. This will need to be added later.
always @(posedge clk)begin
    if(reset_n == 0)begin
        data_out <= 0;
        for(int i = 0; i < FIFO_DEPTH; i++)begin
            sample_fifo[i]  <= 0;
            coef_fifo[i]    <= 0;
            output_fifo[i]  <= 0;
        end
        output_pointer <= 0;
        sample_pointer <= 0;
        coef_pointer <= 0;
    end else begin
        if(push_sample)begin
            sample_fifo[sample_pointer] = new_sample;
            sample_pointer <= sample_pointer + 1;
        end else if(pop_dispose_sample_fifo)begin
            sample_pointer <= sample_pointer - 1;
        end
        
        if(push_coef)begin
            coef_fifo[coef_pointer] <= new_coef;
            coef_pointer = coef_pointer + 1;
        end else if(pop_dispose_coef_fifo)begin
            coef_pointer <= coef_pointer - NUMBER_OF_DSP_BLOCKS;
        end
        
        if(push_output_fifo)begin
            output_fifo[output_pointer] <= temp_result;
            output_pointer <= output_pointer + 1;
        end else if(pop_output)begin 
            data_out <= output_fifo[output_pointer];
            output_pointer <= output_pointer - 1;
        end
        

    end
end

//this manages the DSP cooldown counter. will decrement regardless of FIFO statemachine.
//logic [DSP_COOLDOWN_COUNTER_BITS-1:0] dsp_cooldown;
//logic cooldown_active;
//assign cooldown_active = dsp_cooldown == 0;
//logic start_cooldown;
//logic prev_start_cooldown;
//always @(posedge clk)begin
//    if(reset_n == 0)begin
//        dsp_cooldown <= 0;
//        prev_start_cooldown <= 0;
//    end else begin
//        if(start_cooldown != prev_start_cooldown)begin  //change in cooldown trigger occurs then reset it.
//            dsp_cooldown <= COOLDOWN_MAX_VAL;
//        end else if(cooldown_active)begin
//            dsp_cooldown <= dsp_cooldown -1;
//        end
//        prev_start_cooldown <= start_cooldown;
//    end
//end


//The following is the fifo reader. It will wait until the minimum values are available to begin to compute the FIR and then start.
int fir_loop_index;
always @(posedge clk)begin
    if(reset_n == 0)begin
        fir_loop_index <= FIR_BLOCK_LOOP_ITERS; //in this case it is 1
        push_output_fifo <= 0;
        pop_dispose_sample_fifo <= 0;
        pop_dispose_coef_fifo <= 0;
        state <= idle;
    end else begin
        if(fir_loop_index > 0)begin //loop iterations remain
            if(sample_pointer > 0)begin //at least one sample
                if(coef_pointer > NUMBER_OF_DSP_BLOCKS-1)begin       //at least 4 coefficients (we are using 4 dps blocks)
                    //on the next cc assume all computation complete.
                    state <= pop_out;
                    push_output_fifo <= 1;
                    pop_dispose_sample_fifo <= 1;
                    pop_dispose_coef_fifo <= 1;
                    fir_loop_index <= fir_loop_index -1;
                end
            end
        end
        if(state == pop_out)begin
            //return to 0 state
            push_output_fifo <= 1;
            pop_dispose_sample_fifo <= 0;
            pop_dispose_coef_fifo <= 0;
            state<=idle;
            fir_loop_index <= FIR_BLOCK_LOOP_ITERS;
        end else begin
            push_output_fifo <= 0;
        end
    end
end



/*always @(posedge clk)begin
    if(reset_n == 0)begin
        data_out <= 0;
        for(int i = 0; i < REGISTER_QUANT-1; i++)begin
            register_file[i] <= 0;
        end
    end else begin
        if(register_write_enable)begin
            register_file[register_select] <= data_in;
        end else if(register_output_enable)begin
            data_out <= register_file[register_select];
        end
    end
end*/
   
logic [31:0] product_of_one;
logic [31:0] product_of_two;
logic [31:0] product_of_thr;
logic [31:0] product_of_fou;
logic [31:0] sum_one_two;
logic [31:0] sum_thr_fou;
logic [31:0] sum;
assign temp_result = sum[7:0];
    
dsp_macro mac_one(  .clk(clk),
                    .resetn(reset_n),
                    .operandA({0'b00000000, sample_fifo[sample_pointer]}),
                    .operandB({0'b00000000, coef_fifo[coef_pointer]}),
                    .operandC(0'b0000000000000000),
                    .productP(product_of_one));
    
dsp_macro mac_two(  .clk(clk),
                    .resetn(reset_n),
                    .operandA({0'b00000000, sample_fifo[sample_pointer]}),
                    .operandB({0'b00000000, coef_fifo[coef_pointer+1]}),
                    .operandC(0'b0000000000000000),
                    .productP(product_of_two));  
                    
dsp_macro mac_thr(  .clk(clk),
                    .resetn(reset_n),
                    .operandA({0'b00000000, sample_fifo[sample_pointer]}),
                    .operandB({0'b00000000, coef_fifo[coef_pointer+2]}),
                    .operandC(0'b0000000000000000),
                    .productP(product_of_thr));
    
dsp_macro mac_fou(  .clk(clk),
                    .resetn(reset_n),
                    .operandA({0'b00000000, sample_fifo[sample_pointer]}),
                    .operandB({0'b00000000, coef_fifo[coef_pointer+3]}),
                    .operandC(0'b0000000000000000),
                    .productP(product_of_fou));  
                    
dsp_macro pipeline_adder_one_two(  .clk(clk),
                    .resetn(reset_n),
                    .operandA(product_of_one[15:0]),
                    .operandB(0'b0000000000000001),
                    .operandC(product_of_two),
                    .productP(sum_one_two));  
                    
dsp_macro pipeline_adder_thr_fou(  .clk(clk),
                    .resetn(reset_n),
                    .operandA(product_of_thr[15:0]),
                    .operandB(0'b0000000000000001),
                    .operandC(product_of_fou),
                    .productP(sum_thr_fou));
                    
dsp_macro pipeline_adder_final(  .clk(clk),
                    .resetn(reset_n),
                    .operandA(sum_one_two),
                    .operandB(0'b0000000000000001),
                    .operandC(sum_thr_fou),
                    .productP(sum));
    
    
endmodule
