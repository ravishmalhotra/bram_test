/*
 * uart.c
 *
 *  Created on: Aug 30, 2016
 *      Author: ravishm
 */

#include "uart.h"

 static XUartPs_Config volatile *uart_config_ptr;
 static XUartPs volatile uart_inst_ptr;

int init_uart_ps(void *this) {

    int status;
    Serial *uart=this;

    //Initialize UART
	uart_config_ptr= XUartPs_LookupConfig(XPAR_PS7_UART_1_DEVICE_ID);
	status=XUartPs_CfgInitialize(&uart_inst_ptr, uart_config_ptr, XPAR_PS7_UART_1_BASEADDR);
	//printf("Status %d", status);

	return status;


}



void tx_uart( void *data, char type) {


	switch (type) {
	case 'd':
	    printf("%d\n",*((int *)data));
		break;
	case 'f':
		printf("%f\n",*((float *) data));
		break;
	case 'c':
		printf("%c\n",*((char *) data)) ;
		break;
	case 's':
		printf("%s\n", (char *)data);
	default:
		printf("Invalid data type \n" );
		break;

	}

}


void rx_uart (u8 *data) {

	 XUartPs_Recv(&uart_inst_ptr, data,1);
}



new_uart(Serial *uart) {


	uart->init=init_uart_ps;
	uart->rx=rx_uart;
	uart->tx=tx_uart;


	uart->status=uart->init(uart);

}
