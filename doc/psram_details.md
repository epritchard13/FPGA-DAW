
This is the interface you get with the SD card controller. It's two fifos:
```verilog
// Interface 1 (For the FPGA)
input rd_en1,
output [7:0] rd_dat1,
input wr_en1,
input [7:0] wr_dat1
```
There are also "almost full" and "almost empty" wires that I haven't added yet.

The write enable can be asserted at the same time as write data is given, but read data won't be ready until a clock cycle after read enable is asserted. This might change depending on what is needed.
