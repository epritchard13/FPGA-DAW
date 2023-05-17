#include "pico/stdlib.h"
#include "hardware/spi.h"

#define SYSCLK 133000000
#define SPI_CLK (SYSCLK / 4)

#define SPI_PORT spi0
#define PIN_MISO 16
#define PIN_CS 17
#define PIN_SCK 18
#define PIN_MOSI 19

bool init_spi();