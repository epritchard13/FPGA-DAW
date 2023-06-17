all:
	iverilog -g2012 -o verilog_tb.vpp *.v *.sv ..\\..\\..\\..\\..\\Certain-Synthesizer-FPGA-DAW\\SD-card-controller\\rtl\\verilog\\**.*v
#	iverilog -o gpu.vpp gpu_tb.v gpu.v
	vvp verilog_tb.vpp > out.txt

view: all
	gtkwave verilog_tb.vcd