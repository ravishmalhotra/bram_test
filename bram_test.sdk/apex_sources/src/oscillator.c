/*
 * oscillator.c
 *
 *  Created on: Sep 8, 2016
 *      Author: ravishm
 */

#include "site.h"
#include "oscillator.h"

void osc_get_freq(void *this) {

	Site *site=this;

	site->osc.freq=get_freq(site->site_num);

}


void osc_set_drive (void *this, int drive) {

	return;
}


void new_oscillator(Oscillator *osc) {

	osc->get_freq=osc_get_freq;
	osc->set_drive=osc_set_drive;


}
