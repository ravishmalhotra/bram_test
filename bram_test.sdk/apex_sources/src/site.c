/*
 * site.c

 *
 *  Created on: Sep 8, 2016
 *      Author: ravishm
 */
#include "site.h"

void new_site(Site *site, u8 site_number) {


	site->site_num=site_number;
	new_oscillator(&(site->osc));

}
