all:
	iverilog -g2012 -o verilog_tb.vpp *.v *.sv ..\\SD-card-controller\\rtl\\verilog\\**.*v ..\\SD-card-controller\\bench\\verilog\\sdModel.v
#	iverilog -o gpu.vpp gpu_tb.v gpu.v
	vvp verilog_tb.vpp > out.txt

view: all
	gtkwave verilog_tb.vcd