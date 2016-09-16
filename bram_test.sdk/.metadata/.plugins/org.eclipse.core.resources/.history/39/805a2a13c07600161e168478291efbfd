/*
 * oscillator.h
 *
 *  Created on: Sep 8, 2016
 *      Author: ravishm
 */

#ifndef OSCILLATOR_H_
#define OSCILLATOR_H_

#include "freq_counter.h"


typedef struct Oscillator {

	float freq;
	int drive;

	void (*get_freq) (void *this);
	void (*set_drive) (void *this, int drive);



} Oscillator;


void  osc_get_freq(void *this);
void  osc_set_drive (void *this, int drive);

void new_oscillator(Oscillator *osc);

#endif /* CLOSED_LOOP_H_ */
