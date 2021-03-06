
#ifndef CONSTANTS_H		/* prevent circular inclusions */
#define CONSTANTS_H		/* by using protection macros */


#ifdef __cplusplus
extern "C" {
#endif


#define MIN_MEAS_COUNTER_VALUE 0  // Expected minimum measurement counter value
#define MAX_MEAS_COUNTER_VALUE 2400000 // Expected maximum measurement counter value
#define FREQ_CHANNELS 8 //Total frequency channels available
#define MIN_FREQUENCY 20000000 //Minimum expected measured frequency
#define MAX_FREQUENCY 35000000 //Maximum expected measured frequency
#define REF_FREQ 100000000 //Reference frequency multiplied up from 10MHz


#define MAX_CHAR_ARGS 512

#define ACTIVE_SITES 1

#define BRAM_DEVICE_ID		XPAR_BRAM_0_DEVICE_ID


#ifdef __cplusplus
}
#endif



#endif
