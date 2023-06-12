all:
	iverilog -o verilog_tb.vpp *.v
	vvp verilog_tb.vpp > out.txt

view: all
	gtkwave verilog_tb.vcd