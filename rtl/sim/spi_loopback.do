onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /spi_loopback_test/clk
add wave -noupdate /spi_loopback_test/sclk
add wave -noupdate /spi_loopback_test/reset
add wave -noupdate -divider {SPI Wires}
add wave -noupdate /spi_loopback_test/cs
add wave -noupdate /spi_loopback_test/mosi
add wave -noupdate /spi_loopback_test/miso
add wave -noupdate /spi_loopback_test/sck
add wave -noupdate -divider {SPI Master}
add wave -noupdate /spi_loopback_test/di_req
add wave -noupdate -radix hexadecimal /spi_loopback_test/di
add wave -noupdate /spi_loopback_test/wren
add wave -noupdate /spi_loopback_test/wr_ack
add wave -noupdate /spi_loopback_test/do_valid
add wave -noupdate -radix hexadecimal /spi_loopback_test/dout
add wave -noupdate -divider {SPI Slave}
add wave -noupdate /spi_loopback_test/sl_do_valid
add wave -noupdate -radix hexadecimal /spi_loopback_test/sl_dout
add wave -noupdate /spi_loopback_test/sl_di_req
add wave -noupdate -radix hexadecimal /spi_loopback_test/sl_di
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {175 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
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
WaveRestoreZoom {0 ns} {1050 ns}
