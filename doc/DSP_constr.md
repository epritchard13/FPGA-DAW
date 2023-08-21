# DSP Core Constraints
* multiplications should have an n cycle pipeline delay
* RAMs should be multiples of 512 bytes
* Use the xilinx block ram IP. TODO: do we need to enable the RAM's output register?
    * sample and coeff mem should be dual port ram, so that the PSRAM can also access them
    * Instruction mem is also dual port
