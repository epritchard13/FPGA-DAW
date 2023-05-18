#include "spi_link.h"

bool spi_link_init()
{
    // TODO: actually configure SPI instead of hoping that the defaults are correct

    spi_init(SPI_PORT, SPI_CLK);
    gpio_set_function(PIN_MISO, GPIO_FUNC_SPI);
    gpio_set_function(PIN_CS, GPIO_FUNC_SPI);
    gpio_set_function(PIN_SCK, GPIO_FUNC_SPI);
    gpio_set_function(PIN_MOSI, GPIO_FUNC_SPI);

    return true;
}

bool spi_link_query_status()
{
    spi_write_blocking(SPI_PORT, &QUERY_STATUS, 0);

    return true;
}