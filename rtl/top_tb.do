onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /top_tb/clk
add wave -noupdate /top_tb/sclk
add wave -noupdate /top_tb/reset
add wave -noupdate /top_tb/cs
add wave -noupdate /top_tb/mosi
add wave -noupdate /top_tb/miso
add wave -noupdate /top_tb/sck
add wave -noupdate /top_tb/di_req
add wave -noupdate -radix hexadecimal /top_tb/di
add wave -noupdate /top_tb/wren
add wave -noupdate /top_tb/wr_ack
add wave -noupdate /top_tb/do_valid
add wave -noupdate -radix hexadecimal /top_tb/dout
add wave -noupdate -divider {DUT SPI Data}
add wave -noupdate /top_tb/top_dut/spi_valid
add wave -noupdate -radix hexadecimal /top_tb/top_dut/spi_data
add wave -noupdate -divider {SD Wires}
add wave -noupdate /top_tb/sd_clk
add wave -noupdate /top_tb/sd_cmd
add wave -noupdate /top_tb/sd_dat
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1377517 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {16170315 ps}
