// SPI slave module. CPOL = 0, CPHA = 0, MSBFIRST
module spi(
    input clk,
    input rst,

    input spi_clk,
    input spi_cs,
    input spi_mosi,
    output spi_miso,
	
	output [7:0] data_out, 		// SPI output data
	output valid,
    
    input [7:0] data_in, 		// shift register input data
	output data_in_ready, 		// ready to accept input
    input data_write			// write to the shift register
);

wire active = !spi_cs;
assign data_in_ready = active;
assign valid = spi_cs;

reg [7:0] shift_reg; // the SPI shift register
assign data_out = shift_reg;
reg data_tmp;

assign spi_miso = active & shift_reg[7];

//sample data on rising edge of spi clk
always @(posedge spi_clk) begin
	if (active) begin
		data_tmp <= spi_mosi;
	end
end

//output new data and store sampled data on negative edge of spi clk
always @(negedge spi_clk or posedge data_write) begin
	if (data_write) begin
		shift_reg <= data_in;
	end else if (active) begin
		shift_reg <= (shift_reg << 1) | data_tmp;
	end
end

endmodule