module verilog_tb;
	reg clk = 0;
	reg reset = 0;
	reg [7:0] spi_data = 0;
	reg valid = 0;
	initial begin
		repeat(512) begin
			#1 clk = !clk;
		end
	end

	initial begin
		#10 reset = 1;
		#6 reset = 0;
		#10;
		/*
		#10 spi_data = 8'h88;
		#2 valid = 1;
		#2 valid = 0;
		
		spi_data = 8'h30;
		#2 valid = 1;
		#2 valid = 0;
		
		spi_data = 8'h88;
		#2 valid = 1;
		#2 valid = 0;
		
		spi_data = 8'h5;
		#2 valid = 1;
		#2 valid = 0;

		spi_data = 8'h0;
		#2 valid = 1;
		#2 valid = 0;
		
		repeat(30) begin
		#2 valid = 1;
		#2 valid = 0;
		end*/
		spi_data = 8'h89;
		#2 valid = 1;
		#2 valid = 0;

		spi_data = 8'b1010_1100;
		#2 valid = 1;
		#2 valid = 0;

		spi_data = 8'h36;
		#2 valid = 1;
		#2 valid = 0;

		spi_data = 8'h89;
		#2 valid = 1;
		#2 valid = 0;

		spi_data = 8'b0010_1100;
		#2 valid = 1;
		#2 valid = 0;

		spi_data = 8'h0;
		#2 valid = 1;
		#2 valid = 0;

		#2 valid = 1;
		#2 valid = 0;

	end
	
	initial begin
		$dumpfile("verilog_tb.vcd");
		$dumpvars;
	end

	spi_link_sm uut(
		.clk(clk),
		.rst(reset),
		.spi_data(spi_data),
		.valid(valid)
	);
	
endmodule