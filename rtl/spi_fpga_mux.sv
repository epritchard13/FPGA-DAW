module spi_fpga_mux(
    // switch between FPGA and pico SPI
    input fpga_mode,

    // Interface with SD controller FIFOs
    output rd_en,
    input [7:0] rd_dat,

    output wr_en,
    output [7:0] wr_dat,

    // Interface 0 (For the PICO)
    input rd_en0,
    output [7:0] rd_dat0,
    input wr_en0,
    input [7:0] wr_dat0,

    // Interface 1 (For the FPGA)
    input rd_en1,
    output [7:0] rd_dat1,
    input wr_en1,
    input [7:0] wr_dat1
);

assign rd_en = fpga_mode ? rd_en1 : rd_en0;
assign wr_en = fpga_mode ? wr_en1 : wr_en0;
assign wr_dat = fpga_mode ? wr_dat1 : wr_dat0;

assign rd_dat0 = rd_dat;
assign rd_dat1 = rd_dat;

endmodule
