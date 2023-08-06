#include "hardware/spi.h"
#include "pico/stdlib.h"
#include "spi_link.h"
#include <cmath>
#include "daw/player.h"
#include "stdio_mem.h"
#include "mmc/sdc_example.h"
#include <iostream>
#include <cstring>
#include <stdio.h>

#include "fatfs/ff.h"
#include "fatfs/diskio.h"

Player test_player;

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
        else if (strcmp(cmd, "benchmark") == 0) {
            example_main();
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
}

int main()
{
    stdio_init_all();

    spi_link_init();
    puts("Hello, world!");

    fread(NULL, 1, 1, stdin); // don't start any of the code until we get a single byte

    while (true) {
        read_stdin();
    }

    return 0;
}
