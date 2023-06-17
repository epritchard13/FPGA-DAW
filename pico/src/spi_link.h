#include "pico/stdlib.h"
#include "hardware/spi.h"

// SPI link opcodes
const uint8_t QUERY_STATUS = 0x01;

#define SYSCLK 133000000
#define SPI_CLK (44100*10)

#define SPI_PORT spi0
#define PIN_MISO 16
#define PIN_CS 17
#define PIN_SCK 18
#define PIN_MOSI 19

#define SPI_CMD_SD 0x89

bool spi_link_init();
bool spi_link_query_status();