# Some things that need to be done

## SD Card
* Do a long hard think about whether or not this will actually work before doing the below.
    * Are separate RX/TX FIFOs needed? A combined FIFO can be used, but the IO will need to be muxxed with 2 8-wide 2x1 muxes.
* Get rid of all the clock domain crossing shit and run the card at a
mulitple of the system clock
* Modify the SD IP to use SPI to program the registers.
* Add SD initialization sequence to the pico.
* Add the ability for the FPGA to send data commands. 
* I'm just now realizing it's probably easier to FIFO all SD commands
and send them from the pico, including data commands. Maybe don't do the above.
* Run an audio test by reading the same thing from a fake SD card and outputting the waveform.

## PSRAM
* Write the PSRAM state machine. Probably best to take inspiration from someone else's code.

