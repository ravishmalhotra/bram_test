/*
 * site.h
 *
 *  Created on: Sep 8, 2016
 *      Author: ravishm
 */

#ifndef SITE_H_
#define SITE_H_

#include "oscillator.h"

typedef struct Site {

	u8 site_num;
	Oscillator osc;


} Site;


void new_site(Site *site, u8 site_number);

#endif /* SITE_H_ */
