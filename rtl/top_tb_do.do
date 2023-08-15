vcom spi/*.vhd
vlog *.sv *.v ../SD-card-controller/rtl/verilog/*.*v tb/top_tb.sv
vsim -voptargs="+acc=npr" top_tb
do top_tb.do
run 500us