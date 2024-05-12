#include "pico/stdlib.h"
#include "hardware/spi.h"
#include "config.h"

// SPI link opcodes
const uint8_t QUERY_STATUS = 0x01;

#define SYSCLK 133000000
#define SPI_CLK (5*1000*1000)

#ifdef LATTICE_FPGA
    #define SPI_PORT spi0
    #define PIN_MISO 4
    #define PIN_CS 5
    #define PIN_SCK 6
    #define PIN_MOSI 7
#else // Xilinx FPGA
    #define SPI_PORT spi0
    #define PIN_MISO 16
    #define PIN_CS 17
    #define PIN_SCK 18
    #define PIN_MOSI 19
#endif

#define SPI_CMD_SD 0x89

bool spi_link_init();
bool spi_link_query_status();