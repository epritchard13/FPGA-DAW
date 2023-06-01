`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////////
//                                                                                  //
//                       Digital Signal Processor                                   //
//                                                                                  //
//          - prog_axi interface used to fill program memory.                       //  
//                                                                                  //
//          - ram_axi_n interface used to source audio samples.                     //
//                                                                                  //
//   Henry E Pritchard   /////////////////////////////////   Certain Synthesizers   //


module digital_signal_processor(
    input logic axis_aclk,
    input logic axis_aresetn,
    
    //PICO SPI INTERFACE: (replace with a spi interface, for now it is axi for testing purposes)
    input prog_axi_valid,
    input [15:0] prog_axi_data,
    input execute,
    
    //PSRAM SPI INTERFACE: (will need one per psram chip, currently axi used to simulate psram)
    input ram_axi_0_valid,
    input [15:0] ram_axi_0_data,
    
    //SPI DAC INTERFACE     (axi rn for simulation, switch to spi)
    output dac_axi_valid,
    output [15:0] dac_axi_data
    );
    
    

 logic audio_ready_0 ; 

 
        logic [1:0] warning_0;
        
        ring_fifo audio_fifo_0(.axis_aclk(axis_aclk),
                            .axis_aresetn(axis_aresetn),
                            .write_val(ram_axi_0_data),
                            .valid(ram_axi_0_valid),
                            .read_val(audio_sample_0),
                            .ready(audio_ready_0),
                            .warning(warning_0));     

    
    
    
    
//////////INSTRUCTION MEMORY//////////////////////
logic [1:0] warning;
logic ready; 
logic [15:0] read_val; 
ring_fifo instr_fifo(.axis_aclk(axis_aclk),
                     .axis_aresetn(axis_aresetn),
                     //Programming Interface:
                     .write_val(prog_axi_data),
                     .valid(prog_axi_valid),
                     //Reading Interface:
                     .read_val(read_val),
                     .ready(ready),
                     .warning(warning));

//////////INSTRUCTION MEMORY CONTOL FLOW//////////
logic hold_command_until_fifo_empty;

always @(posedge axis_aclk) begin
    if(axis_aresetn)begin
        ready = 0;
        hold_command_until_fifo_empty = 0;
    end else begin
        if(execute)begin
            if(warning != 2'b10)begin   //if not empty
                if(hold_command_until_fifo_empty != 1'b1)begin
                    ready = 1;
                    hold_command_until_fifo_empty = 1'b1;
                end
            end
            if(warning_0 == 2'b10)begin //audio FIFO is empty
                ready = 0;
                hold_command_until_fifo_empty = 1'b0;//get next instruction
            end
        end else begin
            ready = 0;
        end
    end
end       

//////////INSTRUCTION DECODER/////////////////////
//          0,1,2: OE   3,4,5: WE               //
//////////////////////////////////////////////////
parameter CONTROL_REG_WIDTH = 8;
parameter BUS_WIDTH = 16;
reg [BUS_WIDTH-1:0] sample_bus;

//SOURCES:
logic [15:0] audio_sample_0; 

//DESTINATIONS:
reg [BUS_WIDTH-1:0] from_fx_0;
reg [BUS_WIDTH-1:0] from_fx_1;
reg [BUS_WIDTH-1:0] from_fx_2;
reg [BUS_WIDTH-1:0] from_fx_3;
reg [BUS_WIDTH-1:0] complete;

//CONTROL REGISTERS FOR FX, MIXER
reg [CONTROL_REG_WIDTH-1:0] track_one_volume;        //in order to automate diminishing in the mixer, the pico will have to compile the instructions used to change audio levels as audio passes through the mixer.

always_comb begin
    if(axis_aresetn)begin
        track_one_volume = 0;
        sample_bus = 0;
    end else begin
    case(read_val[2:0])
        3'b000: sample_bus = audio_sample_0;
        //3'b001: sample_bus = audio_sample_1;
        //3'b010: sample_bus = audio_sample_2;
        //3'b011: sample_bus = audio_sample_3;
        3'b100: sample_bus = from_fx_0;
        3'b101: sample_bus = from_fx_1;
        3'b110: sample_bus = from_fx_2;
        3'b111: sample_bus = from_fx_3;
        default:sample_bus = 16'h0000;
    endcase
    case(read_val[5:3])
        3'b000: complete = sample_bus;
        //3'b001: from_fx_1 = sample_bus;
        //3'b010: from_fx_2 = sample_bus;
        //3'b011: from_fx_3 = sample_bus;
        3'b100: from_fx_0 = sample_bus;
        3'b101: from_fx_1 = sample_bus;
        3'b110: from_fx_2 = sample_bus;
        3'b111: from_fx_3 = sample_bus;
        default:sample_bus = 16'h0000;
    endcase       
    if(read_val[6] == 1)begin
        track_one_volume = read_val[15:8];
    end
    end
end                        
               
               //////////AUDIO SAMPLE MEMORY/////////////////////
//            - currently single track          //
//////////////////////////////////////////////////

     
                                             
                         
//////////ACCUMULATOR MIXER///////////////////////
//            - currently single track (lol)    //
//////////////////////////////////////////////////
logic[23:0] scaled_sample;
assign scaled_sample = (complete * track_one_volume );
assign dac_axi_valid = 1;
assign dac_axi_data = scaled_sample[23:8]+ 16'h0100;                           
                            





                           
endmodule

