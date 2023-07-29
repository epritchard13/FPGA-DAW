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
