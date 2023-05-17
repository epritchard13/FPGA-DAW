#include "hardware/clocks.h"
#include "hardware/dma.h"
#include "hardware/spi.h"
#include "hardware/i2c.h"
#include "hardware/pio.h"
#include "hardware/timer.h"
#include "pico/stdlib.h"
#include <stdio.h>

#include "spi_link.h"

int main()
{
    stdio_init_all();

    init_spi();
    puts("Hello, world!");

    uint8_t data[16] = {};
    
    while (true)
        spi_write_blocking(SPI_PORT, data, 16);

    return 0;
}
