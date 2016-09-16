/*
 * SPI.h
 *
 *  Created on: Sep 12, 2016
 *      Author: ravishm
 */

#ifndef SPI_H_
#define SPI_H_

#include "serial.h"
#include "xspips.h"

int init_spi_ps(void *this);
void tx_spi (void *data, char type);
void rx_spi (u8 *data);

void new_spi(Serial *spi);




#endif /* SPI_H_ */
