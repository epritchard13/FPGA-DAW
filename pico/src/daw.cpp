#include "hardware/clocks.h"
#include "hardware/dma.h"
#include "hardware/i2c.h"
#include "hardware/pio.h"
#include "hardware/spi.h"
#include "hardware/timer.h"
#include "pico/stdlib.h"
#include "spi_link.h"
#include <cmath>
#include "player.h"
#include "stdio_mem.h"
#include <iostream>
#include <cstring>
#include <stdio.h>

Player test_player;
uint8_t buf[1024 * 16];
uint audio_size;

void read_stdin()
{
    uint8_t c;
    fread(&c, 1, 1, stdin);
    if (c == '/') { // we have a command
        char cmd[10];
        uint val;

        scanf("%s", cmd);
        if (strcmp(cmd, "set") == 0) {
            uint track, data, size, timestamp;
            scanf("%d %d %d %d", &track, &data, &size, &timestamp);
            printf("track: %d, data: %d, size: %d, timestamp: %d\n", track, data, size, timestamp);
            test_player.add_clip(track, data, size, timestamp);
        } else if (strcmp(cmd, "audio") == 0) {

        } else if (strcmp(cmd, "get") == 0) {
            std::cout << test_player << std::endl;
        } else if (strcmp(cmd, "status") == 0) {
            printf("nominal\n");
        } else {
            printf("unknown command: %s\n", cmd);
        }
    }
    else if (c == 0x53) {
        fread(&audio_size, 1, 4, stdin);
        if (audio_size <= sizeof(buf)) {
            fread(buf, 1, audio_size, stdin);
            uint16_t val = audio_size - 1;
            uint8_t cmd[] = { 0x88, (uint8_t) (val & 0xff), (uint8_t) ((val >> 8) & 0xff)};
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

    //add 8 tracks to the player
    for (int i = 0; i < 8; i++) {
        test_player.tracks.push_back(Track());
    }

    fread(NULL, 1, 1, stdin); // don't start any of the code until we get a single byte

    audio_size = 1024*2;
    while (true) {
        //read_stdin();
        read_blocking(buf, 0, audio_size);
        write_blocking(buf, 0, audio_size);
        uint16_t val = audio_size - 1;
        uint8_t cmd[] = { 0x88, (uint8_t) (val & 0xff), (uint8_t) ((val >> 8) & 0xff)};
        spi_write_blocking(SPI_PORT, cmd, sizeof(cmd));
        spi_write_blocking(SPI_PORT, buf, audio_size); //*/
    }

    return 0;
}
