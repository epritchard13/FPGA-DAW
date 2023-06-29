`timescale 1ns / 1ps
module psram_controller_tb#(
    parameter MONARCH_DATA_WIDTH = 8,
	parameter MONARCH_ADDRESS_WIDTH = 2,
	parameter SPRAM_DATA_WIDTH = 16,
	parameter SPRAM_ADDRESS_WIDTH = 8,
	parameter SD_DATA_WIDTH = 8,
	parameter SD_ADDRESS_WIDTH = 16,
	parameter PSRAM_DATA_WIDTH = 8,
	parameter PSRAM_ADDRESS_WIDTH = 22,
	parameter PSRAM_BLOCK_SIZE = 1023
    )();
    logic  clk;
	logic  resetn;
	
	//monarch axi interface used to drive settings registers
	logic  [MONARCH_DATA_WIDTH-1:0] monarch_axi_tdata;
	logic  [MONARCH_ADDRESS_WIDTH-1:0] monarch_axi_taddress;
	logic  monarch_axi_tvalid;
	logic  monarch_axi_tready;

	//spram axi interface for writing - MSB of address will freeze a block of spram in order to write.
	logic  [SPRAM_DATA_WIDTH-1:0] spram_write_axi_tdata;
	logic  [SPRAM_ADDRESS_WIDTH-1:0] spram_write_axi_taddress;
	logic  spram_write_axi_tvalid;
	logic  spram_write_axi_tready;

	//spram axi interface for reading - MSB of address will freeze a block of spram in order to read.
	logic  [SPRAM_DATA_WIDTH-1:0] spram_read_axi_tdata;
	logic  [SPRAM_ADDRESS_WIDTH-1:0] spram_read_axi_taddress;
	logic  spram_read_axi_tvalid;
	logic  spram_read_axi_tready;

	//sd axi interface for writing
	logic  [SD_DATA_WIDTH-1:0] sd_write_axi_tdata;
	logic  [SD_ADDRESS_WIDTH-1:0] sd_write_axi_taddress;
	logic  sd_write_axi_tvalid;
	logic  sd_write_axi_tready;

	//sd axi interface for reading
	logic  [SD_DATA_WIDTH-1:0] sd_read_axi_tdata;
	logic  [SD_ADDRESS_WIDTH-1:0] sd_read_axi_taddress;
	logic  sd_read_axi_tvalid;
	logic  sd_read_axi_tready;
	
	//chip interfaces
	logic  chip_enable_0;
	wire  sosio0_0;
	wire  sosio1_0;
	wire  sio2_0;
	wire  sio3_0;
	logic  sclk;
	
	
	psram_controller psram_controller_0(   .clk(clk),
	                                       .resetn(res),
	                                       .monarch_axi_tdata(monarch_axi_tdata),
	                                       .monarch_axi_taddress(monarch_axi_taddress),
	                                       .monarch_axi_tvalid(monarch_axi_tv),
	                                       .monarch_axi_tready(monarch_axi_tready),
	                                       .spram_write_axi_tdata(spram_write_axi_tdata),
	                                       .spram_write_axi_taddress(spram_write_axi_taddress),
	                                       .spram_write_axi_tvalid(spram_write_axi_tvalid),
	                                       .spram_write_axi_tready(spram_write_axi_tready),
	                                       .spram_read_axi_tdata(spram_read_axi_tdata),
	                                       .spram_read_axi_taddress(spram_read_axi_taddress),
	                                       .spram_read_axi_tvalid(spram_read_axi_tvalid),
	                                       .spram_read_axi_tready(spram_read_axi_tready),
	                                       .sd_write_axi_tdata(sd_write_axi_tdata),
	                                       .sd_write_axi_taddress(sd_write_axi_taddress),
	                                       .sd_write_axi_tvalid(sd_write_axi_tvali),
	                                       .sd_write_axi_tready(sd_write_axi_tready),
	                                       .sd_read_axi_tdata(sd_read_axi_tdata),
	                                       .sd_read_axi_taddress(sd_read_axi_taddress),
	                                       .sd_read_axi_tvalid(sd_read_axi_tvalid),
	                                       .sd_read_axi_tready(sd_read_axi_tready),
	                                       .chip_enable_0(chip_enable_0),
	                                       .sosio0_0(sosio0_0),
	                                       .sosio1_0(sosio1_0),
	                                       .sio2_0(sio2_0),
	                                       .sio3_0(sio3_0),
	                                       .sclk(sclk));
	                              
	                                       
    initial begin
        clk = 0;
        while(1)begin
            clk = ~clk;
            #1;
        end
    end
    
    initial begin
        resetn = 0;
        #20;
        resetn = 1;
        #2000;
    end

endmodule
