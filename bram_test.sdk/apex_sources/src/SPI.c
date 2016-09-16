/*
 * SPI.c
 *
 *  Created on: Sep 12, 2016
 *      Author: ravishm
 */

static XSpiPs_Config *spi_config_ptr;
static XSpiPs spi_inst;



int init_spi_ps(void *this) {
	u8 status;
	spi_config_ptr= SpiPs_LookupConfig(XPAR_PS7_SPI_1_BASEADDR);
	status=XSpiPs_CfgInitialize(&spi_inst, spi_config_ptr,spi_config_ptr->BaseAddress);
	status=XSpiPs_SetOptions(&spi_inst, XSPIPS_MASTER_OPTION|XSPIPS_FORCE_SSELECT_OPTION);
	XSpiPs_SetClkPrescaler(&spi_inst, XSPIPS_CLK_PRESCALE_128);

}

void tx_spi (void *data, char type);
void rx_spi (u8 *data);
