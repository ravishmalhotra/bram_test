/*
 * uart.h
 *
 *  Created on: Aug 30, 2016
 *      Author: ravishm
 */

#ifndef UART_H_
#define UART_H_


#include "xuartps.h"
#include "serial.h"
#include "stdlib.h"

#ifdef __cplusplus
extern "C" {
#endif

int init_uart_ps(void *this);
void tx_uart (void *data, char type);
void rx_uart (u8 *data);
void new_uart(Serial *uart);

#ifdef __cplusplus
}
#endif

#endif /* UART_H_ */
