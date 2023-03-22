/*! ----------------------------------------------------------------------------
*	@file			ds_twr_tag.c
*	@brief   
*
*	@author			Matteo Nardello
*	@attention
*
*
*/

#define debugOn

//Decawave includes
#include "FreeRTOS.h"
#include "deca_device_api.h"
#include "deca_regs.h"
#include "port_platform.h"
#include "task.h"
#include "timers.h"

//C libs
#include <stdio.h>
#include <string.h>

//Private includes
#include "../../common/config.h"

//Extern variables
extern uint8_t TAG_ID;
extern TimerHandle_t rx_timer;

/* Frames used in the ranging process. See NOTE 1,2 below. */
//TX Buffers
static uint8_t tx_poll_msg[]	= {0x41, 0x88, 0, 0xCA, 0xDE, 'W', 'A', 'V', 'E', 0x21, 0, 0};
static uint8_t tx_final_msg[]	= {0x41, 0x88, 0, 0xCA, 0xDE, 'W', 'A', 'V', 'E', 0x23, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
static uint8_t tx_init_resp[]	= {0xC5, 0, 0, 'I', 'N', 'I', 'T', 0, 0};

//RX Buffers
static uint8_t rx_resp_msg[]	= {0x41, 0x88, 0, 0xCA, 0xDE, 'V', 'E', 'W', 'A', 0x10, 0x02, 0, 0, 0, 0};
static uint8_t rx_buffer[RX_BUF_LEN]; // Buffer to store received response message. 

//Global variables
static uint8_t rx_done			= 0;
static uint8_t tim_isRunning	= 0;
static uint8_t ANCH_NUM			= 1;

//Function Prototypes
static uint64_t get_tx_timestamp_u64(void);
static void msg_set_ts(uint8_t *ts_field, uint64_t ts);
static uint64_t get_rx_timestamp_u64(void);
static uint32_t set_rx(uint32_t _timeout, bool _timeout_enb, bool isTWR);
static int8_t rx_error();
static int8_t twr_run();
void TWRxTimerCallback(TimerHandle_t _Tim);


/*__________________________________________TAG_MAIN_ROUTINE__________________________________________*/

int8_t dstwr_main(void) {

	uint8_t anch_idx = 1, status = 1;
    uint32_t ret = 0, frame_len = 0;

    while(status != 0){

#ifdef debugOn

		printf("1 - Go to RX mode\r\n");

#endif
	
		frame_len = set_rx(1000 * 1000, 1, 0);	// Put UWB radio in RX mode. Extra timer. TAG_UWB_WINDOW seconds as us.

		switch(frame_len){

			default:										// Default condition on RX problems
            case(0):										// Frame_len = 0 on RX timeout

				ret = rx_error();							// On RX error method

                if(ret == 1)								// RX problems but rx windows still open. 
					status = 1;								// Going back to RX mode
				else										// RX timeout. 
					status = 0;								// Exit while loop.

			break;

			case (TWR_INIT_LEN):
				// TODO Decide what happens if the TWR fails with an anchor
				// As of now, we dp completely discard the TWR routine and go back to BLE
				// Do we want partial distances?

				ret = twr_run();

				if(ret == 1)								// TWR init for other tags
					status = 1;								// Going back to RX mode
				else if(ret == 2)							// TWR failed
					status = 0;								// Going back to BLE
				else if(ret == 0)							// TWR Success
					status = 0;								// Going back to BLE

			break;
		}
	}

	vTaskDelay(15);
    return 0;
}

static int8_t twr_run(){

    uint8_t anch_idx = 1, status = 0, frame_len = 0;
    int32_t ret = 0;
    uint32_t final_tx_time = 0;
    uint64_t poll_tx_ts = 0, resp_rx_ts = 0, final_tx_ts = 0;

#ifdef debugOn

	printf("2 - Got TWR init from master anchor\r\n");

#endif

	if (rx_buffer[TAG_ID_IDX] == TAG_ID) {

		while ((anch_idx <= ANCH_NUM) && (status != 2)) {

			tx_poll_msg[TWR_ANCH_IDX] = anch_idx;

#ifdef debugOn
			printf("3 - Send Blink to anchor %d\r\n", anch_idx);
#endif
			dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_TXFRS);		// Clear status register 
			dwt_writetxdata(sizeof(tx_poll_msg), tx_poll_msg, 0);	// Zero offset in TX buffer. 
			dwt_writetxfctrl(sizeof(tx_poll_msg), 0, 1);			// Zero offset in TX buffer, ranging.
		
			dwt_starttx(DWT_START_TX_IMMEDIATE | DWT_RESPONSE_EXPECTED);	// Start TX

			ret = set_rx(65530, 0, 1);								// Switch to RX mode

            if (ret & SYS_STATUS_RXFCG) {

				/* Clear good RX frame event and TX frame sent in the DW1000 status register. */
				dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_RXFCG | SYS_STATUS_TXFRS);

				frame_len = dwt_read32bitreg(RX_FINFO_ID) & RX_FINFO_RXFL_MASK_1023;

				if (frame_len <= RX_BUF_LEN) {

					dwt_readrxdata(rx_buffer, frame_len, 0);

				}

#ifdef debugOn
				printf("6 - Got second TWR message from anchor ln: %d\r\n", frame_len);
#endif
				rx_buffer[ALL_MSG_SN_IDX] = 0;

				if(memcmp(rx_buffer, rx_resp_msg, ALL_MSG_COMMON_LEN) == 0) {				

					poll_tx_ts = get_tx_timestamp_u64();
					resp_rx_ts = get_rx_timestamp_u64();

					final_tx_time = (resp_rx_ts + (RESP_RX_TO_FINAL_TX_DLY_UUS * UUS_TO_DWT_TIME)) >> 8;

					dwt_setdelayedtrxtime(final_tx_time);

					final_tx_ts = (((uint64)(final_tx_time & 0xFFFFFFFEUL)) << 8) + TX_ANT_DLY;

					msg_set_ts(&tx_final_msg[FINAL_MSG_POLL_TX_TS_IDX], poll_tx_ts);
					msg_set_ts(&tx_final_msg[FINAL_MSG_RESP_RX_TS_IDX], resp_rx_ts);
					msg_set_ts(&tx_final_msg[FINAL_MSG_FINAL_TX_TS_IDX], final_tx_ts);

					dwt_writetxdata(sizeof(tx_final_msg), tx_final_msg, 0);
					dwt_writetxfctrl(sizeof(tx_final_msg), 0, 1);

					ret = dwt_starttx(DWT_START_TX_DELAYED);

					if (ret == DWT_SUCCESS) {

						while (!(dwt_read32bitreg(SYS_STATUS_ID) & SYS_STATUS_TXFRS)) {};

						dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_TXFRS);

						printf("7 - Final mex sent\r\n");

					} else { // LAST TWR MEX TX FAILED 

						/* Clear RX error/timeout events in the DW1000 status register. */
						dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
#ifdef debugOn
						printf("07 - TWR Failed. Going Back to BLE\r\n");
#endif
						/* Reset RX to properly reinitialise LDE operation. */
						dwt_rxreset();

                        status = 2;

					} // TX SUCCESS LAST TWR MEX 

				} else { // RX BAD BLINK ANSWER

				/* Clear RX error/timeout events in the DW1000 status register. */
					dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
#ifdef debugOn
					printf("05 - Message not recognized. Going Back to BLE\r\n");
#endif
					/* Reset RX to properly reinitialise LDE operation. */
					dwt_rxreset();

                    status = 2;

				}// RX GOOD BLINK ANSWER 
							  
            } else {  // RXBAD FIRST BLINK

				/* Clear RX error/timeout events in the DW1000 status register. */
				dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
#ifdef debugOn
				printf("04 - Bad answer from blink. Going Back to BLE\r\n");
#endif
				/* Reset RX to properly reinitialise LDE operation. */
				dwt_rxreset();

                status = 2;

			} // RX GOOD FIRST BLINK

            if (status != 2){	// Check if TWR went smoothly
				
				if (++anch_idx > ANCH_NUM) {
#ifdef debugOn
					printf("8 - TWR with Anchor %d finished.\r\n", anch_idx-1);
					printf("08 - This was the last anchor\r\n\r\n\r\n");
#endif

				} else { // MOVE TO NEXT ANCHOR
#ifdef debugOn
					printf("7 - TWR with Anchor %d finished. Moving to next anchor\r\n\r\n", anch_idx-1);
#endif
					//vTaskDelay(TAG_DELAY);

					/* Clear RX error/timeout events in the DW1000 status register. */
					dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);

					/* Reset RX to properly reinitialise LDE operation. */
					dwt_rxreset();

				} // TWR ENDS
            } 
		}// WHILE END
	} else { // RX for other tags

#ifdef debugOn       
		printf("03 - Got INIT mex for different tag. Discarding! \r\n");
#endif
		/* Clear RX error/timeout events in the DW1000 status register. */
		dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);

		/* Reset RX to properly reinitialise LDE operation. */
		dwt_rxreset();

		status = 1;
	}

    return status;
}

static uint32_t set_rx(uint32_t _timeout, bool _timeout_enb, bool isTWR){
	
	//TODO keep track of the error, if timeout or other rx errors

    uint32_t status_reg, frame_len = 0;

	if(_timeout_enb){

		xTimerChangePeriod(rx_timer, (_timeout/1000), 0);

		dwt_setrxtimeout(0);								// Set RX timeout

        if(!tim_isRunning) {

			rx_done = 0;
			tim_isRunning = 1;

            // Start a timer for extended rx timeout
			xTimerStart(rx_timer, 0);

        }
		
		dwt_rxenable(DWT_START_RX_IMMEDIATE);				// Switch to RX mde

		while(!rx_done && !((status_reg = dwt_read32bitreg(SYS_STATUS_ID)) & (SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR))) {};

    } else {

		if(_timeout > 65535)
			_timeout = 65535;								//Check TO period
		
		dwt_setrxtimeout(_timeout);							// Set RX timeout
		dwt_rxenable(DWT_START_RX_IMMEDIATE);				// Switch to RX mde

        while (!((status_reg = dwt_read32bitreg(SYS_STATUS_ID)) & (SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR))) {};
    }

	if(isTWR)
		return status_reg;

	if (status_reg & SYS_STATUS_RXFCG) {

		frame_len = dwt_read32bitreg(RX_FINFO_ID) & RX_FINFO_RXFL_MASK_1023;

		dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_RXFCG);

		dwt_readrxdata(rx_buffer, frame_len, 0);

        rx_done = 1;
		tim_isRunning = 0;

        xTimerStop(rx_timer, 0);

	} 

	return frame_len;

}

static int8_t rx_error(){

	//TODO switch case for error type

#ifdef debugOn
	printf("01 - Bad RX. "); 
#endif
	
	/* Clear RX error/timeout events in the DW1000 status register. */
	dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);

	/* Reset RX to properly reinitialise LDE operation. */
	dwt_rxreset();

	if(rx_done){

#ifdef debugOn
		printf("RX timeout. Going Back to BLE\r\n"); 
#endif
		return 0;

	} else {

#ifdef debugOn
		printf("Going Back to RX mode\r\n"); 
#endif

		return 1;

	}
}


static uint64_t get_tx_timestamp_u64(void) {

	uint8_t ts_tab[5];
	uint64_t ts = 0;
	int i;

	dwt_readtxtimestamp(ts_tab);

	for (i = 4; i >= 0; i--) {

		ts <<= 8;
		ts |= ts_tab[i];
	}

	return ts;
}

static uint64_t get_rx_timestamp_u64(void) {

	uint8_t ts_tab[5];
	uint64_t ts = 0;
	int i;

	dwt_readrxtimestamp(ts_tab);

	for (i = 4; i >= 0; i--) {

		ts <<= 8;
		ts |= ts_tab[i];
	}

	return ts;
}

/*! ------------------------------------------------------------------------------------------------------------------
* @fn msg_set_ts()
*
* @brief Fill a given timestamp field in the final message with the given value. In the timestamp fields of the final
*        message, the least significant byte is at the lower address.
*
* @param  ts_field  pointer on the first byte of the timestamp field to fill
*         ts  timestamp value
*
* @return none
*/
static void msg_set_ts(uint8_t *ts_field, uint64_t ts) {

	int i;

	for (i = 0; i < FINAL_MSG_TS_LEN; i++) {

		ts_field[i] = (uint8)ts;
		ts >>= 8;

	}
}

void TWRxTimerCallback(TimerHandle_t _Tim){

	rx_done = 1;
    tim_isRunning = 0;
}

/**@brief SS TWR Initiator task entry function.
*
* @param[in] pvParameter   Pointer that will be used as the parameter for the task.
*/
/*void anch_master_task_function(void *pvParameter) {

	UNUSED_PARAMETER(pvParameter);

	dwt_setleds(DWT_LEDS_ENABLE);

	while (true) {

		dstwr_main();
	}
}*/