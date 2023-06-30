`timescale 1ns / 1ps

module psram_simulator_tb#(
    parameter BLOCK_SIZE = 1024,       // a block usually contains 1024 bytes
    parameter ADDR_WIDTH = 24,       //2^24 bytes in this psram simulation
    parameter DATA_WIDTH = 8,
    parameter COMMAND_LEN = 8,
    parameter QUICK_READ_DELAY = 9
    )(
    input sclk,
    input chip_enable_n,
    input serial_in,
    output serial_out
    );
    

//small psram memory simulated (only 8 bytes. writing/reading will duplicate)
logic [DATA_WIDTH-1:0] memory_a; 
logic [DATA_WIDTH-1:0] memory_b;
logic [DATA_WIDTH-1:0] memory_c;
logic [DATA_WIDTH-1:0] memory_d;
logic [DATA_WIDTH-1:0] memory_e;
logic [DATA_WIDTH-1:0] memory_f;
logic [DATA_WIDTH-1:0] memory_g;
logic [DATA_WIDTH-1:0] memory_h;
logic [ADDR_WIDTH-1:0] internal_address;
logic [DATA_WIDTH-1:0] selected_memory;
always @(internal_address)begin
    case(internal_address[2:0])
        3'b000  : selected_memory = memory_a;
        3'b001  : selected_memory = memory_b;
        3'b010  : selected_memory = memory_c;
        3'b011  : selected_memory = memory_d;
        3'b100  : selected_memory = memory_e;
        3'b101  : selected_memory = memory_f;
        3'b110  : selected_memory = memory_g;
        3'b111  : selected_memory = memory_h;
        default : selected_memory = 0;
    endcase
end




logic [COMMAND_LEN-1:0] command_input_buffer;
logic [ADDR_WIDTH-1:0] address_input_buffer;
logic [DATA_WIDTH-1:0] data_input_buffer;


logic serial_out_internal;
logic [DATA_WIDTH-1:0]data_internal;
assign serial_out = serial_out_internal;

int internal_address_index;
int internal_data_index;
int internal_block_index;
int quick_read_delay;

typedef enum {idle, read_address,wait_for_quick_read, read_data, write_address, write_data,blocked_because_terminate} internal_state;
internal_state state;

always @(posedge sclk)begin
    if(chip_enable_n)begin
        memory_a <= 0;
        memory_b <= 0;
        memory_c <= 0;
        memory_d <= 0;
        memory_e <= 0;
        memory_f <= 0;
        memory_g <= 0;
        memory_h <= 0;
    
        state <= idle;
        command_input_buffer <= 0;
        address_input_buffer <= 0;
        data_input_buffer <= 0;
        internal_address_index <= 0;
        internal_data_index <= 0;
        internal_block_index <= 0;
        internal_address <= 0;
        quick_read_delay <= 0;
        serial_out_internal <= 0;
        data_internal <= 0;
    end else begin
        command_input_buffer <= {command_input_buffer[COMMAND_LEN-2:0],serial_in};
        address_input_buffer <= {address_input_buffer[ADDR_WIDTH-2:0],serial_in};
        data_input_buffer <= {data_input_buffer[DATA_WIDTH-2:0],serial_in};
        
        if(state == idle)begin
            if(command_input_buffer == 8'b00001011)begin        //enter idle condition
                state <= read_address;  //wait for read from address
            end else if(command_input_buffer == 8'b00000010)begin
                state <= write_address; //wait for write to address
            end
        end else if(state == read_address)begin
            if(internal_address_index == ADDR_WIDTH-1)begin
                internal_address_index <= 0;
                internal_address <= address_input_buffer;
                state = wait_for_quick_read;
            end else begin
                internal_address_index <= internal_address_index + 1;
            end    
        end else if(state == wait_for_quick_read)begin
            if(quick_read_delay == QUICK_READ_DELAY)begin
                state <= read_data;
                data_internal <= selected_memory;       //fetch data from memory at internal address
                internal_address <= internal_address + 1;   //increment internal address
            end else begin
                quick_read_delay <= quick_read_delay + 1;
            end
        end else if(state == read_data)begin    //does not use read buffer
            serial_out_internal <= data_internal[internal_data_index];
            if(internal_data_index == DATA_WIDTH-1)begin
                data_internal <= selected_memory;       //fetch data from memory at internal address
                internal_address <= internal_address + 1;   //increment internal address
                if(internal_block_index == BLOCK_SIZE-1)begin       //read complete!
                    state <= idle;
                end else begin
                    internal_block_index <= internal_block_index + 1;
                end
                internal_data_index <= 0;
            end else begin
                internal_data_index <= internal_data_index + 1;
            end
        end else if(state == write_address)begin
            if(internal_address_index == ADDR_WIDTH-1)begin
                internal_address_index <= 0;
                internal_address <= address_input_buffer;
                state = write_data;
            end else begin
                internal_address_index <= internal_address_index + 1;
            end
        end else if(state == write_data)begin
            data_internal[internal_data_index] <= serial_in;
            if(internal_data_index == DATA_WIDTH-1)begin
                case(internal_address[2:0])                         //write data at internal address
                        3'b000  : memory_a <= selected_memory;
                        3'b001  : memory_b <= selected_memory;
                        3'b010  : memory_c <= selected_memory;
                        3'b011  : memory_d <= selected_memory;
                        3'b100  : memory_e <= selected_memory;
                        3'b101  : memory_f <= selected_memory;
                        3'b110  : memory_g <= selected_memory;
                        3'b111  : memory_h <= selected_memory;
                endcase
                internal_address <= internal_address + 1;
                if(internal_block_index == BLOCK_SIZE-1)begin       //write complete!
                    internal_block_index<= 0;
                    state <= idle;
                end else begin
                    internal_block_index <= internal_block_index + 1;
                end
                internal_data_index <= 0;
            end else begin
                internal_data_index <= internal_data_index + 1;
            end
        end
    end    
    
end

endmodule
