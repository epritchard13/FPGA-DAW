`timescale 1ns / 1ps

//SPI command opcodes
`define WRITE_8BIT_REG 8'h87 		//write a value to the test dac
`define RX_SD_DATA 8'h89 			//SD card operation
`define READ_SD_FIFO 8'h8A 			//read from the SD card FIFO
`define WRITE_SD_FIFO 8'h8B 		//write to the SD card FIFO
`define FPGA_MODE_ON 8'h8C 			//turn on SD card FPGA mode
`define FPGA_MODE_OFF 8'h8D 		//turn off SD card FPGA mode

module spi_link_sm(
	input clk,
	input rst,
	
	input [7:0] spi_data,
	input valid,
	
	output logic [7:0] spi_data_out,
	output logic spi_tx_valid,

	output logic [7:0] dac_state,
	output logic [6:0] sd_addr,
	output logic sd_we,
	output logic [7:0] sd_data_o,
	input [7:0] sd_data_i,

	output logic sd_fifo_rd,
	input [7:0] sd_fifo_data_i,

	output logic sd_fifo_we,
	output logic [7:0] sd_fifo_data_o,

	output logic fpga_mode
);

enum logic [2:0] {
	WAITING,
	WRITE_8BIT_REG,
	RX_SD_DATA,
	READ_SD_REG,
	WRITE_SD_REG,
	WRITE_SD_FIFO
} state = WAITING;

logic prev_valid;

assign spi_data_out = state == READ_SD_REG ? sd_data_i : sd_fifo_data_i;
assign sd_data_o = spi_data;
assign sd_fifo_data_o = spi_data;

always @(posedge clk) begin
	sd_we <= 1'b0;
	sd_fifo_we <= 1'b0;
	spi_tx_valid <= 1'b0;

	if (rst) begin
		state <= WAITING;
		sd_fifo_rd <= 1'b0;
		fpga_mode <= 1'b0;
		prev_valid <= 1'b0;
	end else begin
		if (sd_fifo_rd == 1'b1) begin
			sd_fifo_rd <= 1'b0;
			spi_tx_valid <= 1'b1;
		end

		prev_valid <= valid;
		if (valid && !prev_valid) begin
			//run the state machine
			case (state)
			//waiting state
			WAITING: begin
				//see if the opcode is a command
				case (spi_data)
					`WRITE_8BIT_REG: state <= WRITE_8BIT_REG;
					`RX_SD_DATA: state <= RX_SD_DATA;
					`READ_SD_FIFO: sd_fifo_rd <= 1'b1;
					`WRITE_SD_FIFO: state <= WRITE_SD_FIFO;
					`FPGA_MODE_ON: fpga_mode <= 1'b1;
					`FPGA_MODE_OFF: fpga_mode <= 1'b0;
				endcase
			end
			
			//writing to dac state
			WRITE_8BIT_REG: begin
				state <= WAITING; //go back to waiting
				dac_state <= spi_data;
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
				sd_we <= 1'b1;
			end

			READ_SD_REG: state <= WAITING;

			WRITE_SD_FIFO: begin
				state <= WAITING;
				sd_fifo_we <= 1'b1;
			end

			//end of state machine
			endcase
		end
	end
end

endmodule