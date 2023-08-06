#include "ff.h"
#include <stdio.h>

FRESULT open_append (
    FIL* fp,            /* [OUT] File object to create */
    const char* path    /* [IN]  File name to be opened */
)
{
    FRESULT fr;

    /* Opens an existing file. If not exist, creates a new file. */
    fr = f_open(fp, path, FA_WRITE | FA_OPEN_ALWAYS);
    if (fr == FR_OK) {
        /* Seek to end of the file to append data */
        fr = f_lseek(fp, f_size(fp));
        if (fr != FR_OK)
            f_close(fp);
    }
    return fr;
}


int fat_example_main(void)
{
    FRESULT fr;
    FATFS fs;
    FIL fil;

    //printf("running fat_example_main\n");

    //fs.pdrv = 1; // use mmc
    /* Open or create a log file and ready to append */
    f_mount(&fs, "", 0);

    fr = f_open(&fil, "poop.txt", FA_READ | FA_OPEN_EXISTING);
    if (fr) return (int)fr;

    char line[256];
    while (f_gets(line, sizeof(line), &fil)) {
        printf(line);
    }


    /* Append a line */
    //f_printf(&fil, "hello from fpga");
    UINT bw;
    //f_write(&fil, "hello from fpga", 15, &bw);
    //printf("wrote %d bytes\n", bw);

    /* Close the file */
    f_close(&fil);

    return 0;
}

void printHex(const void *lpvbits, const unsigned int n);
int test_find_file(const char* name, uint* start_sector, uint* num_sectors)
{
    FRESULT fr;
    FATFS fs;
    FIL fil;
    UINT br;

    f_mount(&fs, "", 0);
    
    fr = f_open(&fil, name, FA_READ | FA_OPEN_EXISTING);
    if (fr) return (int)fr;

    f_lseek(&fil, 2000*1024);

    char tmp;
    f_read(&fil, &tmp, 1, &br);
    printf("sector: %d\n", fil.sect);

    printf("file size: %lld\n", f_size(&fil));

    *start_sector = fil.sect;
    *num_sectors = f_size(&fil) / 512;
    printf("file size (blocks): %u\n", *num_sectors);


    f_close(&fil);
    return 0;
}

int fat_test_write(void)
{
    FRESULT fr;
    FATFS fs;
    FIL fil;

    //printf("running fat_example_main\n");

    //fs.pdrv = 1; // use mmc
    /* Open or create a log file and ready to append */
    f_mount(&fs, "", 0);

    fr = f_open(&fil, "testwrite.txt", FA_WRITE | FA_OPEN_ALWAYS);
    if (fr) return (int)fr;

    /* Append a line */
    //f_printf(&fil, "hello from fpga");
    UINT bw;
    f_write(&fil, "hello from fpga", 15, &bw);

    if (bw != 15) {
        f_close(&fil);
        return -1;
    }
    f_close(&fil);

    return 0;
}
