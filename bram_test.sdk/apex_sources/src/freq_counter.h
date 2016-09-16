#ifndef FREQ_COUNTER_H		/* prevent circular inclusions */
#define FREQ_COUNTER_H		/* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#include "constants.h"
#include "debug.h"
#include "xbram.h"


/************************** Constant Definitions *****************************/




/**************************** Type Definitions *******************************/
void init_counter(void);
u32 get_ref_counter(int channel) ;
u32 get_meas_counter(int channel);
float get_freq(int channel);


#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */





