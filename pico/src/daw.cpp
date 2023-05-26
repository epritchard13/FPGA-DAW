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

uint8_t num = 20;
uint8_t buf[1024*16];
uint audio_size;

void read_stdin()
{
    int c;
    c = getchar_timeout_us(0);
    if (c == PICO_ERROR_TIMEOUT)
        return;
    else if (c == '/') { // we have a command
        char cmd[10];
        uint val;

        scanf("%s", cmd);
        if (strcmp(cmd, "set") == 0) {
            scanf("%d", &val);
            num = val;
        } else if (strcmp(cmd, "audio") == 0) {

        } else if (strcmp(cmd, "get") == 0) {
            printf("num: %d\n", num);
        } else if (strcmp(cmd, "status") == 0) {
            printf("nominal\n");
        } else {
            printf("unknown command: %s\n", cmd);
        }
    }
    else if (c == 0x53) {
        fread(&audio_size, 1, 4, stdin);
        if (audio_size < sizeof(buf)) {
            fread(buf, 1, audio_size, stdin);
            uint16_t val = audio_size - 1;
            uint8_t cmd[] = { 0x88, val & 0xff, (val >> 8) & 0xff};
            spi_write_blocking(SPI_PORT, cmd, sizeof(cmd));
            spi_write_blocking(SPI_PORT, buf, audio_size); //*/
        }
    }
}

int main()
{
    stdio_init_all();

    spi_link_init();
    puts("Hello, world!");

    while (true) {
        /*
        uint8_t stuff[] = { 0x88, 249, 0 };
        spi_write_blocking(SPI_PORT, stuff, sizeof(stuff));
        for (int i = 0; i < 250; i++) {
            uint8_t val = i;
            spi_write_blocking(SPI_PORT, &val, 1);
        }//*/

        // puts("poop");
        read_stdin();
    }

    return 0;
}
