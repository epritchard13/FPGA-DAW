`timescale 1ns / 1ps
module processor_core_tb#(
	parameter SAMPLE_BLOCK_ADDRESS_BIT_WIDTH = 8,
	parameter SAMPLE_BIT_WIDTH = 16,
	parameter COEFFI_BLOCK_ADDRESS_BIT_WIDTH = 4,
	parameter COEFFI_BIT_WIDTH = 16,
	parameter OUTPUT_BLOCK_ADDRESS_BIT_WIDTH = 8,
	parameter OUTPUT_BIT_WIDTH = 16,
	parameter PROGRAM_COUNTER_BIT_WIDTH = 16,
	parameter MONARCH_DATA_BIT_WIDTH = 8,
	parameter MONARCH_ADDRESS_BIT_WIDTH = 8,
	parameter INSTRUCTION_BIT_WIDTH = 8,
	parameter ACCUMULATOR_BIT_WIDTH = 32)();

logic clk;
logic resetn;
logic [MONARCH_DATA_BIT_WIDTH-1:0] monarch_axi_tdata;
logic [MONARCH_ADDRESS_BIT_WIDTH-1:0] monarch_axi_taddress;
logic monarch_axi_tvalid;
logic monarch_axi_tready;
logic [SAMPLE_BIT_WIDTH-1:0] sample_axi_tdata;
logic [SAMPLE_BLOCK_ADDRESS_BIT_WIDTH-1:0] sample_axi_taddress;
logic sample_axi_tbusy;
logic sample_axi_tread;
logic [COEFFI_BIT_WIDTH-1:0] coeffi_axi_tdata;
logic [COEFFI_BLOCK_ADDRESS_BIT_WIDTH-1:0] coeffi_axi_taddress;
logic coeffi_axi_tbusy;
logic coeffi_axi_tread;
logic [OUTPUT_BIT_WIDTH-1:0] output_axi_tdata;
logic [OUTPUT_BLOCK_ADDRESS_BIT_WIDTH-1:0] output_axi_taddress;
logic output_axi_tbusy;
logic output_axi_twrite;


processor_core processor_core_0(    .clk(clk),
                                    .resetn(resetn),
                                    .monarch_axi_tdata(monarch_axi_tdata),
                                    .monarch_axi_taddress(monarch_axi_taddress),
                                    .monarch_axi_tvalid(monarch_axi_tvalid),
                                    .monarch_axi_tready(monarch_axi_tready),
                                    .sample_axi_tdata(sample_axi_tdata),
                                    .sample_axi_taddress(sample_axi_taddress),
                                    .sample_axi_tbusy(sample_axi_tbusy),
                                    .sample_axi_tread(sample_axi_tread),
                                    .coeffi_axi_tdata(coeffi_axi_tdata),
                                    .coeffi_axi_taddress(coeffi_axi_taddress),
                                    .coeffi_axi_tbusy(coeffi_axi_tbusy),
                                    .coeffi_axi_tread(coeffi_axi_tread),
                                    .output_axi_tdata(output_axi_tdata),
                                    .output_axi_taddress(output_axi_taddress),
                                    .output_axi_tbusy(output_axi_tbusy),
                                    .output_axi_twrite(output_axi_twrite));


initial begin
    clk = 0;
    while(1)begin
        clk = ~clk;
        #1;
    end
end

initial begin
    resetn = 0;
    
    monarch_axi_tdata = 0;
    monarch_axi_taddress = 0;
    monarch_axi_tvalid = 0;
    
    sample_axi_tdata = 0;
    sample_axi_tbusy = 0;
    
    coeffi_axi_tdata = 0;
    coeffi_axi_tbusy = 0;
    
    output_axi_tdata = 0;
    output_axi_tbusy = 0;
    #20;
    resetn=1;
    #2000;
end


endmodule