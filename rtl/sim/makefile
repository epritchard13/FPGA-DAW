.PHONY: psram_bridge_tb.sv, spi_loopback_test.sv, top_tb.sv

all:
#	iverilog -g2012 -o verilog_tb.vpp *.v *.sv ..\\SD-card-controller\\rtl\\verilog\\**.*v tb/verilog_tb.sv
#	iverilog -o gpu.vpp gpu_tb.v gpu.v
#	vvp verilog_tb.vpp > out.txt

view: all
	gtkwave verilog_tb.vcd

psram_bridge_tb.sv:
	vsim -do "vlog ../psram_bridge.sv ../psram_bridge_tb.sv; vsim -voptargs="+acc=npr" psram_bridge_tb;"

spi_loopback_test.sv:
	vsim -do "vlib work; vcom ../spi/*.vhd; vlog ../tb/spi_loopback_test.sv; vsim -voptargs="+acc=npr" spi_loopback_test; do spi_loopback.do; run 1000ns;"

top_tb.sv:
	vsim -do "vlib work; do top_tb_do.do;"
