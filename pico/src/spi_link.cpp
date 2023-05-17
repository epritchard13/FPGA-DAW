#include "spi_link.h"

bool spi_link_init()
{
    spi_init(SPI_PORT, SYSCLK / 4);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_CS, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK, GPIO_FUNC_SPI);
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);

    return true;
}

bool spi_link_query_status() {
    spi_write_blocking(SPI_PORT, &QUERY_STATUS, 0);
}