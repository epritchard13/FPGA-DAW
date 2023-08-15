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
add wave -noupdate /top_tb/top_dut/spi_sm/state
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/sd_controller_wb0/command_reg
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/sd_controller_wb0/argument_reg
add wave -noupdate -divider {DUT SPI Data}
add wave -noupdate /top_tb/top_dut/spi_valid
add wave -noupdate -radix hexadecimal /top_tb/top_dut/spi_data
add wave -noupdate /top_tb/top_dut/spi_slave0/di_req_o
add wave -noupdate -radix hexadecimal /top_tb/top_dut/spi_slave0/di_i
add wave -noupdate /top_tb/top_dut/spi_slave0/wren_i
add wave -noupdate -divider {SD Wires}
add wave -noupdate /top_tb/sd_clk
add wave -noupdate /top_tb/sd_cmd
add wave -noupdate /top_tb/sd_dat
add wave -noupdate -divider {SD Interrupt Status}
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_controller_wb0/cmd_int_status_reg
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_controller_wb0/data_int_status_reg
add wave -noupdate -divider {SD Controller}
add wave -noupdate -radix binary /top_tb/top_dut/sdc_controller0/sd_data_master0/state
add wave -noupdate -radix binary /top_tb/top_dut/sdc_controller0/sd_cmd_master0/state
add wave -noupdate -radix unsigned /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/blkcnt
add wave -noupdate -radix unsigned /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/blkcnt_reg
add wave -noupdate -divider {SD CMD controller}
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/sd_clk
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/rst
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/data_in
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/rd
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/data_out
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/we
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/DAT_oe_o
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/DAT_dat_o
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/DAT_dat_i
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/blksize
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/bus_4bit
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/blkcnt
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/start
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/sd_data_busy
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/busy
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/crc_ok
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/debug_out
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/DAT_dat_reg
add wave -noupdate -radix unsigned /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/data_cycles
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/crc_in
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/crc_en
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/crc_rst
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/crc_out
add wave -noupdate -radix unsigned /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/transf_cnt
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/state
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/next_state
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/crc_status
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/busy_int
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/blkcnt_reg
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/next_block
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/start_bit
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/crc_c
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/last_din
add wave -noupdate /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/crc_s
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/data_index
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {15358692 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 367
configure wave -valuecolwidth 40
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
WaveRestoreZoom {2114321 ps} {97452771 ps}
