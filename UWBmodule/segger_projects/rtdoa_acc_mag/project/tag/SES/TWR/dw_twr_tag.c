/*! ----------------------------------------------------------------------------
*	@file			ds_twr_tag.c
*	@brief   
*
*	@author			Matteo Nardello
*	@attention
*
*
*/

#ifndef DEBUG_ON
//#define DEBUG_ON
#endif

//Decawave includes
#include "FreeRTOS.h"
#include "deca_device_api.h"
#include "deca_regs.h"
#include "port_platform.h"
#include "task.h"
#include "timers.h"
#include "os_ble.h"

//C libs
#include <stdio.h>
#include <string.h>

//Private includes
#include "../common/config.h"

//Extern variables
//extern uint8_t TAG_ID;
extern TimerHandle_t rx_timer;
extern uint8_t ANCH_NUM;

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
static uint32 status_reg		= 0;

// __________________________________________________________ TS FUNCTION __________________________________________________________
static uint64 get_tx_timestamp_u64(void);
static void msg_set_ts(uint8 *ts_field, uint64 ts);
static uint64 get_rx_timestamp_u64(void);
//void TWRxTimerCallback(TimerHandle_t _Tim);

uint8_t dstwr_main(){

	int8_t status = -1;
    uint32 frame_len;
    uint8_t anch_idx = 1;

    while(status != 0) {

		dwt_setrxtimeout(0);

        if(!tim_isRunning) {

			//xTimerChangePeriod(rx_timer, (UWB_RX_TIMEOUT), 0);
			rx_done = 0;
			tim_isRunning = 1;

            // Start a timer for extended rx timeout
			xTimerStart(rx_timer, 0);
        }

		dwt_rxenable(DWT_START_RX_IMMEDIATE);				// Switch to RX mde

		while(!rx_done && !((status_reg = dwt_read32bitreg(SYS_STATUS_ID)) & (SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR))) {};
		//while(!((status_reg = dwt_read32bitreg(SYS_STATUS_ID)) & (SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR))) {};
		
        nrf_gpio_pin_set(13);

		if (status_reg & SYS_STATUS_RXFCG) {

			xTimerStop(rx_timer, 0);
			//tim_isRunning = 0;

            dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_RXFCG);
			frame_len = dwt_read32bitreg(RX_FINFO_ID) & RX_FINFO_RXFL_MASK_1023;

			if (frame_len == TWR_INIT_LEN){

				dwt_readrxdata(rx_buffer, frame_len, 0);

                if (rx_buffer[TAG_ID_IDX] == TAG_ID) {

#ifdef DEBUG_ON
					printf("2 - Got init message. Len: %d\r\n", frame_len);
#endif
					while (anch_idx <= ANCH_NUM) {

						tx_poll_msg[TWR_ANCH_IDX] = anch_idx;

#ifdef DEBUG_ON
						printf("3 - Sending first message to anchor %d\r\n",anch_idx);
#endif
						dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_TXFRS);
						dwt_writetxdata(sizeof(tx_poll_msg), tx_poll_msg, 0); /* Zero offset in TX buffer. */
						dwt_writetxfctrl(sizeof(tx_poll_msg), 0, 1);          /* Zero offset in TX buffer, ranging. */
						dwt_setrxtimeout(65535);
						dwt_starttx(DWT_START_TX_IMMEDIATE | DWT_RESPONSE_EXPECTED);

						while (!((status_reg = dwt_read32bitreg(SYS_STATUS_ID)) & (SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR))) {};

						if (status_reg & SYS_STATUS_RXFCG) {

							dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_RXFCG | SYS_STATUS_TXFRS);
							frame_len = dwt_read32bitreg(RX_FINFO_ID) & RX_FINFO_RXFL_MASK_1023;

							if (frame_len <= RX_BUF_LEN) {

								dwt_readrxdata(rx_buffer, frame_len, 0);
							}

#ifdef DEBUG_ON
							printf("4 - Got second message from anchr %d. Len: %d\r\n", anch_idx, frame_len);
#endif
							rx_buffer[ALL_MSG_SN_IDX] = 0;

							if(memcmp(rx_buffer, rx_resp_msg, ALL_MSG_COMMON_LEN) == 0) {

								uint32 final_tx_time;
								int ret;
                                uint64_t poll_tx_ts, resp_rx_ts, final_tx_ts;

                                poll_tx_ts = get_tx_timestamp_u64();
                                resp_rx_ts = get_rx_timestamp_u64();
                                final_tx_time = (resp_rx_ts + (RESP_RX_TO_FINAL_TX_DLY_UUS * UUS_TO_DWT_TIME)) >> 8;
                                final_tx_ts = (((uint64)(final_tx_time & 0xFFFFFFFEUL)) << 8) + TX_ANT_DLY;

                                msg_set_ts(&tx_final_msg[FINAL_MSG_POLL_TX_TS_IDX], poll_tx_ts);
								msg_set_ts(&tx_final_msg[FINAL_MSG_RESP_RX_TS_IDX], resp_rx_ts);
								msg_set_ts(&tx_final_msg[FINAL_MSG_FINAL_TX_TS_IDX], final_tx_ts);

								dwt_setdelayedtrxtime(final_tx_time);
                                dwt_writetxdata(sizeof(tx_final_msg), tx_final_msg, 0); /* Zero offset in TX buffer. */
								dwt_writetxfctrl(sizeof(tx_final_msg), 0, 1);           /* Zero offset in TX buffer, ranging. */

								ret = dwt_starttx(DWT_START_TX_DELAYED);

                                if (ret == DWT_SUCCESS) {
								
									while (!(dwt_read32bitreg(SYS_STATUS_ID) & SYS_STATUS_TXFRS)) {};
                                    dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_TXFRS);

									//printf("5 - TWR finished\r\n");
								}
								

                            } else { // Bad answer from anchor

								dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
								dwt_rxreset();

								status = 0;
#ifdef DEBUG_ON
								printf("05 - Bad RX. Aborting TWR.\r\n");
#endif
                            }

                        }  else { // Bad answer from first TWR message

							dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
							dwt_rxreset();

                            status = 0;
#ifdef DEBUG_ON
							printf("04 - Bad RX. Aborting TWR.\r\n");
#endif
						}

                        if(!status) 
							break;
						else{
						
							if (++anch_idx > ANCH_NUM) {
#ifdef DEBUG_ON
								printf("6 - TWR with Anchor %d finished.\r\n", anch_idx - 1);
								printf("06 - This was the last anchor\r\n\r\n");
#endif
								dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
								dwt_rxreset();

                                status = 0;
                                nrf_gpio_pin_clear(13);
                                break;
						
                            } else {
#ifdef DEBUG_ON
								printf("7 - TWR with Anchor %d finished. Moving to next anchor\r\n\r\n", anch_idx - 1);
#endif
								dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
                                dwt_rxreset();
                            }
                        }
                    }// While anchors
                } else { // Init MEX for different tag

#ifdef DEBUG_ON       
					printf("03 - Got INIT mex for different tag. Discarding! \r\n");
#endif
				} 
            } else {  // init length check
			
				dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
				dwt_rxreset();

#ifdef DEBUG_ON       
				printf("02 - Not any INIT mex. Discarding! \r\n");
#endif
				vTaskDelay(1);
			}
		} else {// if fram len

			dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
			dwt_rxreset();

            if(rx_done)
				status = 0;
					
#ifdef DEBUG_ON
		printf("01 - RX failed\r\n");
#endif
		}

    }
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



static uint64 get_tx_timestamp_u64(void) {

	uint8 ts_tab[5];
	uint64 ts = 0;
	int i;

	dwt_readtxtimestamp(ts_tab);

	for (i = 4; i >= 0; i--) {

		ts <<= 8;
		ts |= ts_tab[i];
	}

	return ts;
}

static uint64 get_rx_timestamp_u64(void) {

	uint8 ts_tab[5];
	uint64 ts = 0;
	int i;

	dwt_readrxtimestamp(ts_tab);

	for (i = 4; i >= 0; i--) {

		ts <<= 8;
		ts |= ts_tab[i];
	}

	return ts;
}

static void msg_set_ts(uint8 *ts_field, uint64 ts) {

	int i;

	for (i = 0; i < FINAL_MSG_TS_LEN; i++) {

		ts_field[i] = (uint8)ts;
		ts >>= 8;
	}
}

//void TWRxTimerCallback(TimerHandle_t _Tim){
//
//	rx_done = 1;
//    tim_isRunning = 0;
//}