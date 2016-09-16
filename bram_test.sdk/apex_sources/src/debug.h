#ifndef DEBUG_H		/* prevent circular inclusions */
#define DEBUG_H		/* by using protection macros */

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/

#include "constants.h"
#include "stdarg.h"
#include "xil_printf.h"


/************************** Constant Definitions *****************************/

typedef enum  {FREQ_COUNTER,NET_ANA,FREQ_TRIM,LEAKAGE,POWER_SUPPLY} logsubsystem;
typedef enum  {ALL_INFO,WARN_AND_ERROR_ONLY,ERROR_ONLY} loglevel;


/**************************** Type Definitions *******************************/

char *log_str(logsubsystem sys);


void check_info (int condition,logsubsystem sys, char *info_msg,...) ;
void check_warning(int condition,logsubsystem sys, char *warn_msg,...);
void check_error(int condition, logsubsystem sys,char *error_msg,...);

#ifdef __cplusplus
}
#endif

#endif /* end of protection macro */










