/*! ----------------------------------------------------------------------------
 *  @file    anch_master_TDOA_main.c
 *  @brief
 *
 *
 * @attention
 *
 *
 * @authors	Luca Santoro:
 *luca.santoro@unitn.it Matteo Nardello:	matteo.nardello@unitn.it
 */

#include "../common/config.h"
#include "FreeRTOS.h"
#include "deca_device_api.h"
#include "deca_regs.h"
#include "os_ble.h"
#include "port_platform.h"
#include "timers.h"
#include <stdio.h>
#include <string.h>
#include "rTDoA_est.h"
#include "LIS2DH12.h"

//#define debugOn

/* -------------- Extern variables --------------------- */

/* -------------- Private Functions --------------------- */
int tag_tdoa_run(void);
static uint64 get_rx_timestamp_u64(void);
static uint64 get_tx_timestamp_u64(void);
static uint64 get_sys_timestamp_u64(void);
void printBits(size_t const size, void const *const ptr);

/* -------------- Global variables --------------------- */
static uint8_t RX_buffer[BROADCAST2_BLINK_LEN] = {0x00};
static uint8_t		broadcast_blink1[BROADCAST1_BLINK_LEN]	= {0xC5, 0x88, 0x00, 0x00, 0x00, 0x00};															//{'FIXED', 'FIXED','ANCHOR ID','SEQ_NUM','CKESUM1','CKESUM2'}
static uint8_t seq_num = 0;
static uint32_t frame_len = 0;
static uint32_t status_reg = 0;
static uint64_t RX_TS[NUM_ANCH][4] = {0x00};
static uint64_t idx = 0;
static double x_t[3];

/*int tag_tdoa_run(void) {

	dwt_rxreset();
	
	dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_TXFRS);
	dwt_writetxdata(sizeof(broadcast_blink1), broadcast_blink1, 0);
	dwt_writetxfctrl(sizeof(broadcast_blink1), 0, 1);

	static uint64_t tx_init_ts = 0, tx_init_ts2 = 0;

	if (dwt_starttx(DWT_START_TX_IMMEDIATE) == DWT_ERROR) {

		printf("ret1\r\n");

	}

	while (!(dwt_read32bitreg(SYS_STATUS_ID) & SYS_STATUS_TXFRS)) {};
	
	tx_init_ts = get_tx_timestamp_u64();

	/* Clear TX frame sent event.
    dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_TXFRS);

	dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_TXFRS);
	dwt_writetxdata(sizeof(broadcast_blink1), broadcast_blink1, 0);
	dwt_writetxfctrl(sizeof(broadcast_blink1), 0, 1);

	if (dwt_starttx(DWT_START_TX_IMMEDIATE) == DWT_ERROR) {

		printf("ret2\r\n");
	}

	while (!(dwt_read32bitreg(SYS_STATUS_ID) & SYS_STATUS_TXFRS)) {};
	
	tx_init_ts2 = get_tx_timestamp_u64();

	printf("\r\n");

	/*Clear TX frame sent event.
    dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_TXFRS);

}*/

int tag_tdoa_run(void) {

    while (seq_num < 6) {

        dwt_setrxtimeout(0);
        dwt_rxenable(DWT_START_RX_IMMEDIATE);

        while (!((status_reg = dwt_read32bitreg(SYS_STATUS_ID)) &
            (SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR))) {};

        if (status_reg & SYS_STATUS_RXFCG) {

            dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_RXFCG);

            frame_len = dwt_read32bitreg(RX_FINFO_ID) & RX_FINFO_RXFL_MASK_1023;

            if (frame_len == BROADCAST1_BLINK_LEN) {

                dwt_readrxdata(RX_buffer, frame_len, 0);

                if (RX_buffer[ANC_ID_IDX] == seq_num) {

                    nrf_gpio_pin_set(13);
                    //nrf_gpio_pin_set(23);

                    // Get RX1
                    RX_TS[seq_num][0] = get_rx_timestamp_u64();

                    dwt_setrxtimeout(0);
                    dwt_rxenable(DWT_START_RX_IMMEDIATE);

                    while (!((status_reg = dwt_read32bitreg(SYS_STATUS_ID)) &
                        (SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR))) {};

                    if (status_reg & SYS_STATUS_RXFCG) {

                        dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_RXFCG);
                        //UP2
                        //nrf_gpio_pin_set(23);
                        frame_len = dwt_read32bitreg(RX_FINFO_ID) & RX_FINFO_RXFL_MASK_1023;

                        if (frame_len == BROADCAST2_BLINK_LEN) {

                            dwt_readrxdata(RX_buffer, frame_len, 0);

                            if (RX_buffer[ANC_ID_IDX] == seq_num) {
                            //UP1
                            //nrf_gpio_pin_set(13);

                                //nrf_gpio_pin_clear(13);

                                // Get RX2
                                RX_TS[seq_num][1] = get_rx_timestamp_u64();

                                // Get TX1
                                RX_TS[seq_num][2] = ((uint64_t)RX_buffer[TS_IDX + 4] << 32) |
                                                    ((uint64_t)RX_buffer[TS_IDX + 3] << 24) |
                                                    ((uint64_t)RX_buffer[TS_IDX + 2] << 16) |
                                                    ((uint64_t)RX_buffer[TS_IDX + 1] << 8)	|
                                                    ((uint64_t)RX_buffer[TS_IDX]);
                                //DOWN2
                                dwt_setrxtimeout(0);
                                dwt_rxenable(DWT_START_RX_IMMEDIATE);

                                while (!((status_reg = dwt_read32bitreg(SYS_STATUS_ID)) &
                                    (SYS_STATUS_RXFCG | SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR))) {};

                                if (status_reg & SYS_STATUS_RXFCG) {

                                    dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_RXFCG);
                                    frame_len = dwt_read32bitreg(RX_FINFO_ID) & RX_FINFO_RXFL_MASK_1023;

                                    if (frame_len == BROADCAST2_BLINK_LEN) {

                                        dwt_readrxdata(RX_buffer, frame_len, 0);

                                        if (RX_buffer[ANC_ID_IDX] == seq_num) {

                                            // Get TX2
                                            RX_TS[seq_num][3] = ((uint64_t)RX_buffer[TS_IDX + 4] << 32) |
                                                                ((uint64_t)RX_buffer[TS_IDX + 3] << 24) |
                                                                ((uint64_t)RX_buffer[TS_IDX + 2] << 16) |
                                                                ((uint64_t)RX_buffer[TS_IDX + 1] << 8)	|
                                                                ((uint64_t)RX_buffer[TS_IDX]);

                                            seq_num++;

                                        } else
                                            break;
                                    } else
                                        break;
                                } else {
                                    dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
                                    dwt_rxreset();
                                    break;
                                }
                            } else
                                break;
                        } else
                            break;
                    } else {
                        dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
                        dwt_rxreset();
                        break;
                    }

                } else {
                    dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
                    dwt_rxreset();
                    break;
                }
            } else	{
                dwt_write32bitreg(SYS_STATUS_ID, SYS_STATUS_ALL_RX_TO | SYS_STATUS_ALL_RX_ERR);
                dwt_rxreset();
                break;
            }
        }
    }
    //DOWN1
    //nrf_gpio_pin_clear(13);

    if (seq_num == 6){

        nrf_gpio_pin_clear(13);
        seq_num = 0;
        dwt_rxreset();
        idx++;

        
        // Print RX
        printBits(sizeof(uint8_t) * 5, &RX_TS[0][0]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[1][0]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[2][0]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[3][0]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[4][0]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[5][0]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[0][1]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[1][1]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[2][1]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[3][1]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[4][1]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[5][1]);

        // Print TX
        printBits(sizeof(uint8_t) * 5, &RX_TS[0][2]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[1][2]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[2][2]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[3][2]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[4][2]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[5][2]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[0][3]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[1][3]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[2][3]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[3][3]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[4][3]);
        printBits(sizeof(uint8_t) * 5, &RX_TS[5][3]);
        
        printf("\r\n");
        
        // Blue LED blinks when reading new data.
        vLIS2_TaskBypass();
        
        if(rTDoA(RX_TS,x_t)){
            printf("%f %f %f\r\n", x_t[0], x_t[1], x_t[2]);
        }

        memset(RX_TS, 0, sizeof(RX_TS[0][0]) * NUM_ANCH * 4);

        if(idx >= 5000)
          while(1);

		//vTaskDelay(18);

    }
    else{
        //printf(":(\r\n");
    }
}

// printf("%d %d ",RX_buffer[ANC_ID_IDX]);

/*! ------------------------------------------------------------------------------------------------------------------
 * @fn get_rx_timestamp_u64()
 *
 * @brief Get the RX time-stamp in a 64-bit variable.
 *        /!\ This function assumes that length of time-stamps is 40 bits, for both TX and RX!
 *
 * @param  none
 *
 * @return  64-bit value of the read time-stamp.
 */
static uint64 get_rx_timestamp_u64(void) {
  uint8 ts[5];
  uint64_t time = 0;
  dwt_readrxtimestamp(ts);

  time = ((uint64_t)ts[4] << 32) | ((uint64_t)ts[3] << 24) | ((uint64_t)ts[2] << 16) | ((uint64_t)ts[1] << 8) |
         ((uint64_t)ts[0]);

  return time;
}

// static uint64 get_sys_timestamp_u64(void) {

//  uint8 ts_tab[5];
//  uint64 ts = 0;
//  int i;

//  dwt_readsystime(ts_tab);

//  for (i = 4; i >= 0; i--) {

//    ts <<= 8;
//    ts |= ts_tab[i];
//  }

//  return ts;
//}

// void printBits(size_t const size, void const * const ptr)
//{
//    unsigned char *b = (unsigned char*) ptr;
//    unsigned char byte;
//    int i, j;

//    for (i = size-1; i >= 0; i--) {
//        for (j = 7; j >= 0; j--) {
//            byte = (b[i] >> j) & 1;
//            printf("%u", byte);
//        }
//    }
//}

void printBits(size_t const size, void const *const ptr) {
  unsigned char *b = (unsigned char *)ptr;
  unsigned char byte;
  int i, j;

  for (i = size - 1; i >= 0; i--) {
    for (j = 7; j >= 0; j--) {
      byte = (b[i] >> j) & 1;
      printf("%u", byte);
    }
  }
  printf(" ");
}

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
