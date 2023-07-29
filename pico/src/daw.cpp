#include "hardware/spi.h"
#include "pico/stdlib.h"
#include "spi_link.h"
#include <cmath>
#include "player.h"
#include "stdio_mem.h"
#include "mmc/sdc_example.h"
#include <iostream>
#include <cstring>
#include <stdio.h>

Player test_player;
uint8_t buf[1024];
uint audio_size;

#include "fatfs/ff.h"
#include "fatfs/diskio.h"

int fat_example_main(void);
int fat_test_write(void);

DRESULT disk_read (
	BYTE pdrv,		/* Physical drive nmuber to identify the drive */
	BYTE *buff,		/* Data buffer to store read data */
	LBA_t sector,	/* Start sector in LBA */
	UINT count		/* Number of sectors to read */
);
void printHex(const void *lpvbits, const unsigned int n);

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
            scanf("%d %d %d %d", &track, &data, &timestamp, &size);
            //printf("track: %d, data: %d, size: %d, timestamp: %d\n", track, data, size, timestamp);
            test_player.addClip(track, data, timestamp, size);
        }
        else if (strcmp(cmd, "status") == 0) {
            printf("nominal\n");
        }
        else if (strcmp(cmd, "runsm") == 0) {
            test_player.player_sm();
        } 
        else if (strcmp(cmd, "pop") == 0) {
            test_player.queue.pop();
        } 
        else if (strcmp(cmd, "move") == 0) {
            uint new_pos;
            scanf("%d", &new_pos);
            test_player.movePlayhead(new_pos);
        } 
        else if (strcmp(cmd, "sdwrite") == 0) {
            int val[2];
            scanf("%x %x", &val[0], &val[1]);
            spisdc_writeb(val[0], val[1]);
        }
        else if (strcmp(cmd, "sd") == 0) {
            int val;
            scanf("%x", &val);
            printf("%x\n", spisdc_readb(val));
        } 
        else if (strcmp(cmd, "json") == 0) {
            std::cout << test_player.toJson() << std::endl;
        }
        else if (strcmp(cmd, "init") == 0) {
            //example_main();
            int status = fat_example_main();
            printf("fat_example_main returned %d\n", status);
        } 
        else if (strcmp(cmd, "test_write") == 0) {
            //example_main();
            int status = fat_test_write();
            printf("fat_test_write returned %d\n", status);
        }
        else if (strcmp(cmd, "bread") == 0) {
            unsigned long long val;
            scanf("%llu", &val);
            uint8_t buf[512];
            disk_read(0, buf, val, 1);
            printHex(buf, 512);
        }
        else if (strcmp(cmd, "fifo") == 0) {
            int val;
            scanf("%d", &val);
            for (int i = 0; i < val; i++) {
                uint8_t cmd[] = { 0x8A, 0x00, 0x00 };
                spi_write_read_blocking(SPI_PORT, cmd, cmd, sizeof(cmd));
                printf("%x ", cmd[2]);
            }
            printf("\n");
        }
        else if (strcmp(cmd, "clear") == 0) {
            test_player.tracks.clear();
        } else if (strcmp(cmd, "add") == 0) {
            test_player.tracks.push_back(Track());
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

    fread(NULL, 1, 1, stdin); // don't start any of the code until we get a single byte

    audio_size = 1024*2;
    while (true) {
        read_stdin();
        /*read_blocking(buf, 0, audio_size);
        write_blocking(buf, 0, audio_size);
        uint16_t val = audio_size - 1;
        uint8_t cmd[] = { 0x88, (uint8_t) (val & 0xff), (uint8_t) ((val >> 8) & 0xff)};
        spi_write_blocking(SPI_PORT, cmd, sizeof(cmd));
        spi_write_blocking(SPI_PORT, buf, audio_size); //*/
    }

    return 0;
}
