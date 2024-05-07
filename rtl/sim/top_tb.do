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
add wave -noupdate -radix unsigned /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/blksize
add wave -noupdate -radix unsigned /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/transf_cnt
add wave -noupdate -radix unsigned /top_tb/top_dut/sdc_controller0/sd_data_serial_host0/data_cycles
add wave -noupdate -divider {DUT SPI Data}
add wave -noupdate /top_tb/top_dut/rst
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
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/sd_clk
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/rst
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/setting_i
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/cmd_i
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/start_i
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/cmd_dat_i
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/cmd_serial_host0/response_o
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/finish_o
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/crc_ok_o
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/index_ok_o
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/cmd_oe_o
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/cmd_out_o
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/cmd_dat_reg
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/resp_len
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/with_response
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/cmd_serial_host0/cmd_buff
add wave -noupdate -radix hexadecimal /top_tb/top_dut/sdc_controller0/cmd_serial_host0/resp_buff
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/crc_rst
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/crc_in
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/crc_val
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/crc_enable
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/crc_bit
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/crc_ok
add wave -noupdate -radix unsigned /top_tb/top_dut/sdc_controller0/cmd_serial_host0/counter
add wave -noupdate /top_tb/top_dut/sdc_controller0/cmd_serial_host0/state
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {34042 ps} 0}
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
WaveRestoreZoom {0 ps} {233428 ps}
