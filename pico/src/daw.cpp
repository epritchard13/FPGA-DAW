#include "hardware/clocks.h"
#include "hardware/dma.h"
#include "hardware/i2c.h"
#include "hardware/pio.h"
#include "hardware/spi.h"
#include "hardware/timer.h"
#include "pico/stdlib.h"
#include "spi_link.h"
#include <cmath>
#include <cstring>
#include <stdio.h>

uint8_t num = 10;

void read_stdin()
{
    int c;
    while (true) {
        c = getchar_timeout_us(0);
        if (c == PICO_ERROR_TIMEOUT)
            break;
        else if (c == '/') { // we have a command
            char cmd[10];
            uint val;

            scanf("%s", cmd);
            if (strcmp(cmd, "set") == 0) {
                scanf("%d", &val);
                num = val;
            } else if (strcmp(cmd, "get") == 0) {
                printf("num: %d\n", num);
            } else if (strcmp(cmd, "status") == 0) {
                printf("nominal\n");
            } else {
                printf("unknown command: %s\n", cmd);
            }
        }
    }
}

int main()
{
    stdio_init_all();

    spi_link_init();
    puts("Hello, world!");

    while (true) {

        for (float i = 0; i < 1.0; i += 1. / num) {
            uint8_t val = (sin(2 * 3.14159 * i) + 1) * 127.5;
            const uint8_t code = 0x87;
            spi_write_blocking(SPI_PORT, &code, 1);
            spi_write_blocking(SPI_PORT, &val, 1);
        }

        // puts("poop");
        read_stdin();
    }

    return 0;
}
