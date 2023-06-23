`define DEPTH 23

`define CMD_FAST_READ 8'h0B
`define CMD_WRITE 8'h02
// add more commands as needed

/**
This module essentially serves as the glue between PSRAM and FPGA. There
should be no FIFOing and as few registers as possible - that stuff will be done by other
modules. The only registers I can think of
are the MAR and data shift register.

The PSRAM should run at the system clock (probably 100MHz). Hopefully it's possible to get
this working without a clock divide by 2.

Page 12 and beyond is the important stuff:
https://www.apmemory.com/wp-content/uploads/APM_PSRAM_E3_QSPI_APS6404L-3SQN-v2.6-KGD_PKG.pdf
*/
module psram_controller(
	input clk,			// probably 100MHz
	input rst,			// active high reset

	input start_read, 		// start a read
	input start_write, 		// start a write
	input [8:0] count, // number of bytes to read/write (max 512)

	input [`DEPTH - 1:0] address_in,	// The address to start a read/write from
	output reg [`DEPTH - 1:0] address,	// The address being written to or read from

	output [7:0] dout, 	// output (read)
	output r_valid,		// no ready signal - the PSRAM just signals when data is valid

	input [7:0] din,	// input (write)
	output w_ready		// no valid signal - the PSRAM decides when data is read
);

/*
Everything below this is just some idea I had a while back.
Feel free to delete it. The final implementation
will almost certainly have some sort of state machine, though.
*/
enum reg [2:0] { IDLE, READ_CMD, READING, WRITE_CMD, WRITING } state;

always @(posedge clk) begin
	if (rst) begin
		state <= IDLE;
	end

	case (state)
	
	IDLE: begin
		if (r_ready) state <= READ_CMD;
		if (w_valid) state <= WRITE_CMD;
	end
	
	READ_CMD: begin
		state <= READING;
		address <= address_in;
	end
	
	READING: begin
		address <= address + 1;
	end

	WRITE_CMD: begin
		state <= WRITING;
		address <= address_in;
	end

	WRITING: begin
		address <= address + 1;
	end
	
	endcase
end

endmodule