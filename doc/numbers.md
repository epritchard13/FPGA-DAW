# The Book of Numbers

## Audio
Currently, we have:
* 32 audio out channels
    * 2 channels can be used as a single stereo channel
* 44100Hz, 16-bit audio

Recording details have not been fleshed out yet, but it will likely be 2 channels in for a single stereo input, adding 2 additional channels to account for. This should be negligible for most calculations when compared to the sheer number of audio output channels.

$32\times 44100\times16=22.58$ Mbit/s, or $2.822$ MB/s worst case

## System
FPGA sysclk is 100MHz
* SD Card can run at up to 50MHz (sysclk/2)
* PSRAM runs at 100MHz

### PSRAM
The worst case accesses for PSRAM are two reads to the DSP and one write from the SD card per channel.
**This doesn't factor in DSP coeffecients, instructions, or anything else**. 
This gives us a required raw bitrate of $22.58\times 3 = 67.75$ MBit/s.

PSRAM uses SPI or QPI to give a raw bitrate of 100MBit/s or 400MBits/s respectively.

### SD Card
The SD card can run at 50MHz with 4 data lanes, giving a raw bitrate of 200MBit/s.