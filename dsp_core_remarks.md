GENERAL REMARKS:

**The DSP Processor may or may not have access to DSP48 blocks on FPGA resources. DSP48 blocks are good at multiply/accumulate, but are limited to a set width and are pipelined, so take several CC to warm up.

**In the absence of DSP blocks (Which is likely, because Xilinx chips are expensive) we will use a proprietary "DSP CORE."

---------------------------------------------------------------
-     The following assumes no DSP blocks.                    -
---------------------------------------------------------------

DSP CORE ELEMENTS IMPLEMENTED:

Abilities:
    Volume Attenuation - Scalar Multiplication used to diminish sample volume with minimal loss of sample resolution


DSP CORE ELEMENTS TO IMPLEMENT

Abilities:
    Mixing - 16b by 16b adder. Pipelined for adding many samples together. Preceded by 



Sample Structure and Definition:

Each sample will be 16bit audio resolution. "0dB" will be considered around 49152. This allows for audio level to increase beyond max while retaining no loss in resolution. Clipping will occur at 133% volume. This will be accomplished by recording at 16b and then diminishing as data is recorded. As audio is played back, it will be scaled up in order to achieve full volume, but this will result in significant clipping. THE DSP PROCESSOR WILL ATTEMPT TO MIX ALL TRACKS TO "0dB"




DESIRED AUDIO EFFECTS:

Non-Causal:
    Multiband Dynamics  - Volume Adjustment for Treble, Mid, and Low frequencies independently. Volume Adjust for entire sound
    Limiter             - Compresses Volume into user-defined range (measured in dB).
    Compressor          - User defines a range to compress audio effects into.