/*
 * WISHBONE SD Card Controller IP Core
 *
 * sd_example.c
 *
 * This file is part of the WISHBONE SD Card
 * Controller IP Core project
 * http://opencores.org/project,sd_card_controller
 *
 * Description
 * Example application using WISHBONE SD Card Controller
 * IP Core. The app perform core initialisation,
 * mmc/sd card initialisation and then reads one block
 * of data from the card.
 * This app is using some of code from u-boot project
 * (mmc.c and mmc.h)
 *
 * Author(s):
 *     - Marek Czerski, ma.czerski@gmail.com
 */
/*
 *
 * Copyright (C) 2013 Authors
 *
 * This source file may be used and distributed without
 * restriction provided that this copyright statement is not
 * removed from the file and that any derivative work contains
 * the original copyright notice and the associated disclaimer.
 *
 * This source file is free software; you can redistribute it
 * and/or modify it under the terms of the GNU Lesser General
 * Public License as published by the Free Software Foundation;
 * either version 2.1 of the License, or (at your option) any
 * later version.
 *
 * This source is distributed in the hope that it will be
 * useful, but WITHOUT ANY WARRANTY; without even the implied
 * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR
 * PURPOSE. See the GNU Lesser General Public License for more
 * details.
 *
 * You should have received a copy of the GNU Lesser General
 * Public License along with this source; if not, download it
 * from http://www.opencores.org/lgpl.shtml
 */

#include "mmc.h"
#include <stdio.h>
#include <stdlib.h>

#include "pico/time.h"

struct mmc * ocsdc_mmc_init(int clk_freq);
void spisdc_fpga_mode(struct mmc* mmc, bool val);

#define BLKSIZE 512

void printHex(const void *lpvbits, const unsigned int n) {
    char* data = (char*) lpvbits;
    unsigned int i = 0;
    char line[17] = {};
    printf("%.8X | ", (unsigned int)data);
    while ( i < n ) {
        line[i%16] = *(data+i);
        if ((line[i%16] < 32) || (line[i%16] > 126)) {
            line[i%16] = '.';
        }
        printf("%.2X", (unsigned char)*(data+i));
        i++;
        if (i%4 == 0) {
            if (i%16 == 0) {
                if (i < n-1)
                    printf(" | %s\n\r%.8X | ", line, (unsigned int)data+i);
            } else {
                printf(" ");
            }
        }
    }
    while (i%16 > 0) {
        (i%4 == 0)?printf("   "):printf("  ");
        line[i%16] = ' ';
        i++;
    }
    printf(" | %s\n\r", line);
}

void benchmark(struct mmc* drv) {
    int num_blocks = 1024*2*10;

    printf("starting... ");
    spisdc_fpga_mode(drv, true);

    uint64_t time = to_us_since_boot(get_absolute_time());
    mmc_bread(drv, 225055990, num_blocks, NULL);

    time = to_us_since_boot(get_absolute_time()) - time;
    printf("benchmark took %d ms\n\r", (int)(time / 1000));
    uint num_bytes = num_blocks * BLKSIZE;
    
    // print data rate MByte/s
    printf("data rate: %d.%d MBytes/s\n\r", (int)(num_bytes / time), (int)((num_bytes * 10 / time) % 10));

    spisdc_fpga_mode(drv, false);
    printf("done.\n\r");
}

int test_find_file(const char* name, uint* start_sector, uint* num_sectors);
int test_audio(struct mmc* drv) {
    uint start_sector, num_sectors;
    uint sect = test_find_file("recipe.raw", &start_sector, &num_sectors);
    
    spisdc_fpga_mode(drv, true);
    mmc_bread(drv, start_sector, num_sectors, NULL);
    spisdc_fpga_mode(drv, false);
    printf("done.\n\r");
    return 0;
}

int example_main() {
	printf("Hello World !!!\n\r");

	//init ocsdc driver
	struct mmc * drv = ocsdc_mmc_init(100000000);
	if (!drv) {
		printf("ocsdc_mmc_init failed\n\r");
		return -1;
	}

	drv->has_init = 0;
	int err = mmc_init(drv);
	if (err != 0 || drv->has_init == 0) {
		printf("mmc_init failed\n\r");
		return -1;
	}

	print_mmcinfo(drv);
    benchmark(drv);
    //test_audio(drv);

	return EXIT_SUCCESS;
}
