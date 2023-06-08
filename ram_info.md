## PSRAM details
PSRAM is divided into blocks. For now, we'll probably use a single 8MB PSRAM, but this is probably very easy to expand.

PSRAM is divided into blocks of a certain size (not sure yet what the size will be).

For example:
```
block size = 16K
PSRAM size = 8MB

number of blocks = 8MB / 16K = 512
```

## Access Scheme
PSRAM blocks can store any audio from any part of the project. The FPGA has no concept of how the project itself is structured (storing tracks, clips, memory segments on the FPGA would be very complicated). Instead, the pico streams the blocks numbers to to read and write to the PSRAM. 

For example, the pico can tell the FPGA to read data from the SD card and store to a block in PSRAM. The pico can also tell the DSP to read from a certain block in PSRAM. Both reads and write commands from the PICO will need to be FIFOd by the FPGA to so that the FPGA doesn't need to wait for the PICO to send the next command. However, the FIFO depth probably doesn't need to be very deep.

The read and write commands will be structured something like this:

```
(read or write) | (SD card or PSRAM) | (block number) | (data length)
```

The "data length" field is necessary because some memory accesses don't use the full block length.

I mentioned that the read and write commands will need to be FIFOd. How will the pico know when more read and write commands should be sent? The FPGA will have to signal this somehow to the PICO over the SPI link.

## Reads and Writes
SD card reads and writes will be done in large blocks. For now, these reads and writes will probably be equal to the block size for simplicity. However, reads and writes to the PSRAM from the DSP will be very small (maybe 32 or 64 bytes at a time) because the DSP needs to obtain the data from many tracks. Why 32 or 64 bytes? Reads that are too big will result in large FIFOs being needed for the DSP, and reads that are too small will have poor performance due to the overhead of addressing and sending commands to the PSRAM.

## Block Diagram
![FPGA](https://github.com/epritchard13/Certain-Synthesizer-FPGA-DAW/assets/22825641/3606e0a8-83ca-43a8-b06a-f8eb1071b075)
