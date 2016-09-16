/*
 * serial.h
 *
 *  Created on: Sep 2, 2016
 *      Author: ravishm
 */

#ifndef SERIAL_H_
#define SERIAL_H_


typedef struct Serial {

int status;
int (*init) (void* this);
void (*tx) (void *data, char type);
void (*rx) (u8 *data);

} Serial;


#endif /* SERIAL_H_ */
