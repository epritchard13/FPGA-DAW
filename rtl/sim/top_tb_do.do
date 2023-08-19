vcom ../spi/*.vhd
vlog ../*.sv ../*.v ../tb/top_tb.sv ../../SD-card-controller/rtl/verilog/*.v +incdir+../../SD-card-controller/rtl/verilog/
vsim -voptargs="+acc=npr" top_tb
do top_tb.do
run 500us