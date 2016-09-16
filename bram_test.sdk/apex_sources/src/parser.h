/*
 * parser.h
 *
 *  Created on: Sep 9, 2016
 *      Author: ravishm
 */

/**
 * This file implements a parser that parses string commands
 * from the controller ex. Matlab host and executes the relevant
 * function.
 * The expected input to the parser is the string command defined
 * in the "cmds" table in parser.c. If the received string matches
 * with one of the strings defined in "cmds" table, it then parses
 * the arguments. It then calls the appropriate function along with
 * the appropriate arguments and prints out the result of the parsed
 * argument
 *
 *
 *
 */




#ifndef PARSER_H_
#define PARSER_H_


/***************************** Include Files *********************************/
#include "stdlib.h"
#include "string.h"
#include "site.h"
#include "serial.h"


/************************** Constant Definitions *****************************/

#define CMDS 1
#define CMD(string, func, params) {#string, cmd_##func, params} // Template for generating the CMD table.
#define MK_CMD(x) void cmd_##x(args_table*) //Template for generating the function that is executed upon string match.




/**************************** Type Definitions *******************************/

//Each argument of the callback function will be one of char*, char, int or float
typedef union args_table {

	char *s;
	char c;
	int d;
	float f;

} args_table;

/*
 *  The struct defines the command table. Each "name" entry of the struct
 *  is compared with the received string. If its a match, arguments are parsed
 *  and typecasted based on definition in "args". Lastly the appropriate
 *  function pointer is called along with the arguments. The received string
 *  will be matched against "name" string
 */

typedef struct cmds_table {

	char *name;
	void (*func) (args_table *);
	char *args;


} cmds_table;



/**************************** Function Definitions *******************************/



//MK_CMD(get_freq);


void cmd_get_freq(args_table *args);
void flush (char *all_args,int limit);
void interpreter(Serial uart,char *all_args);
void command_parser(char *all_args);
void args_parser( char *args,args_table *params) ;

#endif /* PARSER_H_ */
