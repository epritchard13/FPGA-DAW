## Members
Ethan James, Eddie Pritchard

## Photo
![](hero.png)

## Mentor
Eddie Pritchard

## Current Status
In Progress

## Project Overview

This is a digital audio workstation - a tool that allows musicians or audio engineers to record, process, and mix audio digitally. It uses a very low cost microcontroller to handle basic IO and a low-cost FPGA to handle digital signal processing and read/write from storage and RAM. Data storage is provided by an SD card. Memory is provided by an 8MB Psuedo-static RAM (PSRAM), which is a DRAM IC with a memory controller attached to eliminate the need to constantly refresh the memory. This gives us a decent amount of capacity without requring a complex memory interface.

## Educational Value Added

This project focuses on two engineering topics - digital design and digital signal processing. Creating the interface between storage (SD card), RAM, microcontroller, and digital signal processing requires us to make careful decisions when writing Verilog/SystemVerilog HDL. Designing audio effects for the digital signal processor requires fairly deep knowledge of DSP theory and the ability to implement DSP algorithms in physical hardware (possibly including FFT/IFFT).

## Design Constraints

[Important Numbers](doc/numbers.md)

## Tasks

List of IPs currently in development:
* [SD card controller](https://github.com/ethanjamesauto/SD-card-controller/)
* Audio DSP core
* SPI/QPI PSRAM Controller

List of micocontroller software modules currently in development:
* [SD card driver](pico/src/mmc)
* [Memory allocator](pico/src/memory)
* [FAT filesystem (using FatFs as a starting point)](pico/src/fatfs)

## Useful Links

[Documentation (WIP)](doc/)

## Log

[Version History](https://github.com/epritchard13/FPGA-DAW/commits/main)