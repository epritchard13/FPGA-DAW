/**
 * A set of methods for using a serial device as external memory.
 *
 * Transmissions use the following format:
 * 4-byte header indicating the virtual address of the data
 * 4-byte header indicating the size of the data to be transmitted
 * A byte indicating the type of transmission (read or write)
 * Data
 */

#include "stdio_mem.h"
#include <stdio.h>

const uint8_t READ = 0;
const uint8_t WRITE = 1;

/**
 * Print some test data, including:
 * The size of a long long
 * Whether the device is little-endian or big-endian
 */
void print_test_data()
{
    printf("Size of long long: %d\n", sizeof(long long));
    long long test = 0x1234567890ABCDEF;
    uint8_t* test_ptr = (uint8_t*)&test;

    if (test_ptr[0] == 0xEF) {
        printf("Little-endian\n");
    } else {
        printf("Big-endian\n");
    }
}

/**
 * Send a string of bytes to the serial device
 */
void write_blocking(uint8_t* data, uint address, uint size)
{
    // write the 4-byte address header
    fwrite(&address, 1, 4, stdout);

    // write the 4-byte size header
    fwrite(&size, 1, 4, stdout);

    fwrite(&WRITE, 1, 1, stdout);
    fflush(stdout);

    for (int i = 0; i < size; i++) {
        if (data[i] > 5 && data[i] < 13) { //known problem characters - ascii 7. There are other that are unknown
            data[i] = 13;
        }
    }//*/

    // write the data using fwrite, which is likely faster (TODO: verify)
    fwrite(data, 1, size, stdout);
    fflush(stdout);
}

/**
 * Read a string of bytes from the serial device
 */
void read_blocking(uint8_t* data, uint address, uint size)
{
    // write the 4-byte address header
    fwrite(&address, 1, 4, stdout);

    // write the 4-byte size header
    fwrite(&size, 1, 4, stdout);

    fwrite(&READ, 1, 1, stdout);
    fflush(stdout);

    // read the data using fread, which is likely faster (TODO: verify)
    fread(data, 1, size, stdin);
    fflush(stdin);
}