all:
	iverilog -g2012 -o verilog_tb.vpp *.v *.sv
#	iverilog -o gpu.vpp gpu_tb.v gpu.v
	vvp verilog_tb.vpp > out.txt

view: all
	gtkwave verilog_tb.vcd