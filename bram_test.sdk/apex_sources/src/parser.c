/*
 * parser.c
 *
 *  Created on: Sep 6, 2016
 *      Author: ravishm
 */

#include "parser.h"

static const char *delim="|%"; //The delimiter which will be used to parse incoming commands

static cmds_table cmds[CMDS]= {
		{"G_FREQ", cmd_get_freq,"d"} //Array entry for getting frequency. Prints frequency in float.
		//CMD(G_FREQ,get_freq,'d')
		//CMD(S_T_CUR,set_trim_cur,'df')

 }; //The array of existing commands


/*****************************************************************************/
 /**
 * Prints the frequency from a particular channel
 *
 * @param	The parsed argument containing the channel no. of type 'int'
 * The channel number can go from 1 to ACTIVE_SITES
 *
 * @return  None
 *
 * @note    None.
 *
 ******************************************************************************/

void cmd_get_freq(args_table *args) {

	extern Site site[];
	extern Serial uart;

	float freq;
	int site_num=args[0].d-1;

	site[site_num].osc.get_freq(&site[site_num]);
	freq=site[site_num].osc.freq;

	uart.tx(&freq,'f');


}


/*****************************************************************************/
 /**
 *
 *
 * @param
 *
 * @return
 *
 *
 * @note    None.
 *
 ******************************************************************************/

void interpreter(Serial uart,char *all_args) {

   int i;

	for (i=0;i<MAX_CHAR_ARGS;i++) {

		uart.rx((u8 *) &all_args[i]);
		if ((char) all_args[i]=='%') {
			command_parser(all_args);
			flush (all_args,i);
			break;

		}


	}

} //Be careful, some strings might run over, depending on when the scan is done.


void flush (char *all_args,int limit) {

	int i;

	for (i=0;i<=limit;i++) {

		all_args[i]='\0';


	}

}


void command_parser(char *all_args) {

	const char *command=strtok(all_args,delim);
	int i=0;
	int str_length;

	while (i<CMDS) {

		//printf("Comm string %s \n", command);
		//printf("Reference string %s \n", cmds[i].name);

		if (!strcmp(command,cmds[i].name)) {

			str_length=strlen(cmds[i].args);
			args_table params[str_length];

			args_parser(cmds[i].args,params);
			cmds[i].func(params);
			break;

		}

		i++;
	}
}

void args_parser( char *args,args_table *params) {

int i;
int str_length=strlen(args);

for (i=0;i<str_length;i++) {

	char *arg_str;

	switch (args[i]) {

	case 's':
		params[i].s=strtok(NULL,delim);
		break;
	case 'c':
		arg_str=strtok(NULL,delim);
		params[i].c=arg_str[0];
		break;
	case 'd':
		arg_str=strtok(NULL,delim);
		params[i].d=atoi(arg_str);
		break;
	case 'f':
		arg_str=strtok(NULL,delim);
		params[i].f=atof(arg_str);
	}

}


}


