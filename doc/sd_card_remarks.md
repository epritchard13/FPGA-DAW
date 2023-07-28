# SD Card Remarks

## HDL
We're probably going with the [Wishbone SD Card Controller](https://github.com/mczerski/SD-card-controller), because it's the only thing I found that can use a 4-wire SDIO interface for maximum data speed. It's an IP that uses an interace known as wishbone to interface with an SoC CPU. Needless to say, this thing will need to be gutted like a fish to remove all of the junk that's used to interface with the wishbone bus. It might end up being drop-in replaced with a connection to the SPI state machine, or some of the logic will be transferred to an FGPA state machine.

Things to check in the future:
* Does this fully support SDHC and SDXC?
* Does this support high-speed (50MHz) bus speed?

## FPGA Requirements
* Read or write a certain number of blocks from the SD card

## MCU Requirements
* Handle FAT filesystem
* Initialization sequence

## Optimizations
* The CMD response doesn't need to be stored in a large register. It can be fifoed and sent over SPI to the pico.
* Timeouts and watchdogs aren't really needed, right?