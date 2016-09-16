#include "debug.h"

static loglevel LOG_LEVEL=ALL_INFO; // Set the debug level.


/*****************************************************************************/
/**
* Return the subsystem string from the subsystem enum code where the INFO, WARN or ERROR took place
*
*
* @param	The enum code of the subsystem
*
* @return   The subsystem string
*
*
* @note		None.
*
******************************************************************************/

char *log_str(logsubsystem sys) {

	switch (sys)
	{
	   case FREQ_COUNTER: return "Frequency Counter";
	   case NET_ANA: return "Network Analyzer";
	   case FREQ_TRIM: return "Frequency trim";
	   case LEAKAGE: return "Leakage";
	   case POWER_SUPPLY: return "Power Supply";

	}

	return "";

}



/*****************************************************************************/
/**
* Checks a stated condition and if true prints INFO message. The INFO message
* can contain extra arguments for printing conversion specifications
*
*
* @param	Int condition to be checked
*           Enum code of the subsystem
*           String Info message with extra arguments for conversion specification
*
* @return   None
*
*
* @note		None.
*
* example:
* check_info(meas_counter>MIN_MEAS_COUNTER_VALUE,FREQ_COUNTER, "Measurement Channel %d Counter value:%d \n",channel,meas_counter);
*
******************************************************************************/


void check_info (int condition,logsubsystem sys, char *info_msg,...) {


	va_list args;
	char* subsys_str;

	if (LOG_LEVEL==ALL_INFO) {

	if (condition) {

		subsys_str=log_str(sys);
		xil_printf("Subsystem: %s INFO: ", subsys_str);
		va_start(args, info_msg);
		vprintf(info_msg, args);
		va_end(args);

		}
		else return;
	}

	else return;

}


/*****************************************************************************/
/**
* Checks a stated condition and if true prints WARN message. The WARN message
* can contain extra arguments for printing conversion specifications
*
*
* @param	Int condition to be checked
*           Enum code of the subsystem
*           String WARN message with extra arguments for conversion specification
*
* @return   None
*
*
* @note		None.
*
* example:
* check_warning((meas_counter<=MIN_MEAS_COUNTER_VALUE),FREQ_COUNTER,"Measurement Channel %d did not find a working oscillator\n",channel);
*
******************************************************************************/
void check_warning(int condition,logsubsystem sys, char *warn_msg,...) {

	va_list args;
	char* subsys_str;

	if (LOG_LEVEL==ALL_INFO || LOG_LEVEL==WARN_AND_ERROR_ONLY) {

		if (condition) {

			 subsys_str=log_str(sys);
			 xil_printf("Subsystem: %s WARNING: ", subsys_str);
			 va_start(args, warn_msg);
			 vprintf(warn_msg, args);
			 va_end(args);


		}

		else return;
	}

	else return;
}

/*****************************************************************************/
/**
* Checks a stated condition and if true prints ERROR message. The ERROR message
* can contain extra arguments for printing conversion specifications
*
*
* @param	Int condition to be checked
*           Enum code of the subsystem
*           String ERROR message with extra arguments for conversion specification
*
* @return   None
*
*
* @note		None.
*
* example:
* check_error((ref_counter==0), FREQ_COUNTER, "No 10MHz reference frequency found. \n");
*
******************************************************************************/

void check_error(int condition, logsubsystem sys, char *error_msg,...) {

	va_list args;
	char* subsys_str;

	if (LOG_LEVEL==ALL_INFO || LOG_LEVEL==WARN_AND_ERROR_ONLY|| LOG_LEVEL==ERROR_ONLY) {

		if (condition) {



		    xil_printf("Subsystem: %s ERROR: ", subsys_str);
			va_start(args, error_msg);
			vprintf(error_msg, args);
			va_end(args);


			//goto error;
		}

		else return;

	}

	else return;
}

