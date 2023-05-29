#include "pico/stdlib.h"

void print_test_data();

void write_blocking(uint8_t* data, uint address, uint size);
void read_blocking(uint8_t* data, uint address, uint size);
