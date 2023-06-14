`timescale 1ns / 1ps

//SPI command opcodes
`define WRITE_8BIT_REG 8'h87 		//write a value to the test dac
`define RX_DATA 8'h88 				//receive a packet
`define RX_SD_DATA 8'h89 			//SD card operation

module spi_link_sm(
	input clk,
	input rst,
	
	input [7:0] spi_data,
	input valid,
	
	output [7:0] spi_data_out,
	output reg spi_tx_valid,

	output reg [7:0] dac_state,
	output reg [6:0] sd_addr,
	output reg sd_we,
	output reg [7:0] sd_data_o,
	input [7:0] sd_data_i
);

enum logic [2:0] {
	WAITING,
	WRITING_8BIT_REG,
	RECEIVING_RX_HEADER,
	RECEIVING_RX_BODY,
	RX_SD_DATA,
	READ_SD_REG,
	WRITE_SD_REG
} state = WAITING;

`define HEADER_SIZE 2 //size of header in bytes
reg [7:0] header [(`HEADER_SIZE - 1):0]; //rx header
reg [15:0] ctr0; //right now just used for rx headers, but could be used for other stuff

assign spi_data_out = sd_data_i;

always @(posedge clk) begin
	if (rst) begin
		state <= WAITING;
		spi_tx_valid <= 1'b0;
		sd_we <= 1'b0;
	end

	if (spi_tx_valid == 1'b1) spi_tx_valid <= 1'b0;

	if (valid) begin
		//run the state machine
		case (state)
		//waiting state
		WAITING: begin
			sd_we <= 1'b0;
			//see if the opcode is a command
			if (spi_data == `WRITE_8BIT_REG)
				state <= WRITING_8BIT_REG;
			else if (spi_data == `RX_DATA) begin
				state <= RECEIVING_RX_HEADER;
				ctr0 <= 0;
			end else if (spi_data == `RX_SD_DATA) begin
				state <= RX_SD_DATA;
			end
		end
		
		//writing to dac state
		WRITING_8BIT_REG: begin
			state <= WAITING; //go back to waiting
			dac_state <= spi_data;
		end
		
		//receiving data rx header
		RECEIVING_RX_HEADER: begin
			ctr0 <= ctr0 + 1;
			header[ctr0] <= spi_data;
			if (ctr0 == `HEADER_SIZE - 1) begin
				state <= RECEIVING_RX_BODY;
				ctr0 <= 0;
			end
		end
		
		//receiving the data itself
		RECEIVING_RX_BODY: begin
			ctr0 <= ctr0 + 1;
			dac_state <= spi_data;
			if (ctr0 == {header[1], header[0]}) begin //the header should be one less than the actual data size
				state <= WAITING;
			end
		end

		RX_SD_DATA: begin
			if (spi_data[7] == 1'b1) begin // write
				state <= WRITE_SD_REG;
			end else begin // read
				state <= READ_SD_REG;
				spi_tx_valid <= 1'b1; // This will write until the next spi valid is received. TODO: is this ok?
			end
			sd_addr <= spi_data[6:0];
		end

		WRITE_SD_REG: begin
			state <= WAITING;
			sd_data_o <= spi_data[7:0];
			sd_we <= 1'b1;
		end

		READ_SD_REG: begin
			state <= WAITING;
		end

		//end of state machine
		endcase
	end
end

endmodule
