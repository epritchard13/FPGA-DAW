vlib work 
vcom *.vhd
vlog *.v *.sv ../SD-card-controller/rtl/verilog/**.*v tb/verilog_tb.sv
vsim verilog_tb -voptargs="+acc=npr"
do wave.do 
run -all