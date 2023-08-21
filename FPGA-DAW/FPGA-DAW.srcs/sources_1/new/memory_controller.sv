`timescale 1ns / 1ps
//A note about this interface:
//This is massively overcomplicated as I am thinking about which interfaces are necessary.
//I will chose which ports I need as I am building and remove the unused later.
//-Eddie EST 6:12 PM 8-10-23

module memory_controller#(
    parameter DATA_WIDTH = 8,
    parameter ADDR_WIDTH = 24,
    parameter NUM_BLOCKS_WIDTH = 5,
    
    
    parameter COMPOSITE_COMMAND_SIZE = 12
    )(
    input clk,
    input resetn,
    
    
    //SD CARD INTERFACE
    input logic [DATA_WIDTH-1:0] data_inhale_from_sd,       //psram write
    output logic [DATA_WIDTH-1:0] data_exhale_into_sd,      //psram read
    input logic [ADDR_WIDTH-1:0] sd_address,
    input logic [NUM_BLOCKS_WIDTH-1:0] sd_num_blocks,       //how many blocks of 32 bytes will be moved in the transaction
    input logic sd_inhale_fifo_almost_empty,                //the read source is nearly empty. data may soon be invalid.
    input logic sd_inhale_fifo_almost_full,                 //this source's fifo is nearly full. data overflow may occur soon.
    input_logic sd_exhale_fifo_almost_empty,                //this destination fifo is nearly empty. the destination may need data soon.
    input logic sd_exhale_fifo_almost_full,                 //this destination's fifo is nearly full. any data sent may soon overflow.
    input logic sd_card_requests_a_read,                    //a read has been requested. read from psram and deliver the data to the sd card.
    input logic sd_card_requests_a_write,                   //a write has been requested. write new data into psram starting at the sd card's address.
    output logic psram_requests_next_byte_from_sd,          //psram needs a new byte within the next clock cycle.
    output logic sd_other_transaction_in_progress,          //psram is busy. no new reads or writes can be processed until the current one has finished.
    
    
    //DSP - INNERLOGIC INTERFACE
    input logic [DATA_WIDTH-1:0] data_inhale_from_dsp,      //psram write
    output logic [DATA_WIDTH-1:0] data_exhale_into_dsp,     //psram read
    input logic [ADDR_WIDTH-1:0] dsp_address,    
    input logic [NUM_BLOCKS_WIDTH-1:0] dsp_num_blocks,      //how many blocks of 32 bytes will be moved in the transaction
    input logic dsp_inhale_fifo_almost_empty,               //the dsp read source fifo is nearly empty. data may soon not be ready.
    input logic dsp_inhale_fifo_almost_full,                //the dsp source fifo is nearly full. data may soon overflow.
    input logic dsp_exhale_almost_empty,                    //the destination fifo is nearly empty. any processing element dependent on this may run dry.
    input logic dsp_exhale_almost_full,                     //the dest fifo is almost full. any data sent may overflow.
    input logic dsp_requests_a_read,                        //dsp needs more data.
    input logic dsp_requests_a_write,                       //dsp wants to write to psram.
    output logic psram_requests_next_byte_from_dsp,         //psram needs the next byte within one cc
    output logic dsp_other_transaction_in_progress,         //another interface is accessing psram at this moment.
    
    
    //MICROPHONE INTERFACE. UNDERESTABLISHED
    input logic [DATA_WIDTH-1:0] data_inhale_from_line_in,  //psram write
    output logic [DATA_WIDTH-1:0] data_exhale_into_line_out,//psram read
    input logic [ADDR_WIDTH-1:0] line_address,
    
    
    //PSRAM INTERFACE 
    input logic [DATA_WIDTH-1:0] data_inhale_from_psram,    //psram read
    output logic [DATA_WIDTH-1:0] data_exhale_into_psram,   //psram write
    output logic [ADDR_WIDTH-1:0] psram_address,
    output logic [NUM_BLOCKS_WIDTH-1:0] psram_num_blocks,
    output logic psram_begin_a_read,
    output logic psram_begin_a_write,
    input logic next_byte_requested,                        //must be muxed to the transaction correspondant
    input logic psram_is_busy                               //this is a general tx inprog. will be muxed to sources not currently part of transaction
    );
    
    //Logic for deciding which transaction to establish next.
    logic [COMPOSITE_COMMAND_SIZE-1:0] composite_command;
    assign composite_command = {sd_inhale_fifo_almost_empty,
                                sd_inhale_fifo_almost_full,
                                sd_exhale_fifo_almost_empty,
                                sd_exhale_fifo_almost_full,
                                sd_card_requests_a_read,
                                sd_card_requests_a_write,
                                dsp_inhale_fifo_almost_empty,
                                dsp_inhale_fifo_almost_full,
                                dsp_exhale_almost_empty,
                                dsp_exhale_almost_full,
                                dsp_requests_a_read,
                                dsp_requests_a_write};
            
    always_comb begin
        case(composite_command)
            
        endcase
    end        
            
            
                                
                                
    typedef enum {idle,transaction_in_progress,blocked} state_enum;
    state_enum state;
    state_enum next_state;
    

    always @(posedge clk)begin
        if(resetn == 0)begin
            next_state <= idle;
        end else begin
            case(state)
                idle:                               next_state <= transaction_in_progress;
                transaction_in_progress:            next_state <= blocked;
                blocked:                            next_state <= idle;
                default:                            next_state <= idle;
            endcase
        end
    end
    
    always @(posedge clk)begin
        if(resetn == 0)begin
            state <= idle;
        end else begin
            if(state == idle)begin
                
                state <= next_state;
            end else if(state == transaction_in_progress)begin
                state <= next_state;
            end else if(state == blocked)begin
                state <= next_state;
            end
        end
    end
    
endmodule
