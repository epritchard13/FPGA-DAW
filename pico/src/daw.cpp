#include "hardware/clocks.h"
#include "hardware/dma.h"
#include "hardware/i2c.h"
#include "hardware/pio.h"
#include "hardware/spi.h"
#include "hardware/timer.h"
#include "pico/stdlib.h"
#include <stdio.h>
#include <cmath>
#include "spi_link.h"

uint8_t data[1] = { 0x05 };

void print_status()
{
    printf("nominal\n");
}

void read_stdin()
{
    int c;
    while (true) {
        c = getchar_timeout_us(0);
        if (c == PICO_ERROR_TIMEOUT)
            break;
        else if (c == '?')
            print_status();
        
        data[0] = c;
    }
}

int main()
{
    stdio_init_all();

    spi_link_init();
    puts("Hello, world!");

    while (true) {
        
        for (float i = 0; i < 1.0; i += .1) {
            uint8_t val = (sin(2*3.14159*i) + 1) * 127.5;
            spi_write_blocking(SPI_PORT, &val, 1);
        }

        //puts("poop");
        //read_stdin();
    }

    return 0;
}
