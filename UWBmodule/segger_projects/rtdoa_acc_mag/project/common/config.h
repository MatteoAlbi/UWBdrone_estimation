#ifndef CONFIG_H
#define CONFIG_H

#include "deca_device_api.h"

// ----------------- NETWORK PARAMETERS----------------- // 
#define NUM_ANCH						6
#define MASTER_ID						0	
	

/**< Value used as error code on stack dump, can be used to identify stack location on stack unwind. */
#define DEAD_BEEF                       0xDEADBEEF 


// ----------------- UWB ----------------- // 
static dwt_config_t config = {
    5,                  /* Channel number. */
    DWT_PRF_64M,        /* Pulse repetition frequency. */
    DWT_PLEN_256,       /* Preamble length. Used in TX only. */
    DWT_PAC16,           /* Preamble acquisition chunk size. Used in RX only. */
    10,                 /* TX preamble code. Used in TX only. */
    10,                 /* RX preamble code. Used in RX only. */
    0,                  /* 0 to use standard SFD, 1 to use non-standard SFD. */
    DWT_BR_6M8,         /* Data rate. */
    DWT_PHRMODE_STD,    /* PHY header mode. */
    (257 + 8 - 16)       /* SFD timeout (preamble length + 1 + SFD length - PAC size). Used in RX only. */
};



//Define the max number of tags and anchors of the system
#define MAX_TAGS						5
#define MAX_ANCHORS						6

/* Speed of light in air, in metres per second. */
#define SPEED_OF_LIGHT					299702547

/* UWB microsecond (uus) to device time unit (dtu, around 15.65 ps) conversion factor.
* 1 uus = 512 / 499.2 �s and 1 �s = 499.2 * 128 dtu. */
#define UUS_TO_DWT_TIME					65536

/*Should be accurately calculated during calibration*/
#define TX_ANT_DLY						16456
#define RX_ANT_DLY						16456
/* Default antenna delay values for 64 MHz PRF.*/
//#define TX_ANT_DLY					16456
//#define RX_ANT_DLY					16456	

// Not enough time to write the data so TX timeout extended for nRF operation.
// Might be able to get away with 800 uSec but would have to test
// See note 6 at the end of this file
// generic anchor delay, beware of timing !
#define POLL_RX_TO_RESP_TX_DLY_UUS		(1100)


// master anchor delay
#define RESP_RX_TO_FINAL_TX_DLY_UUS		1100

/* This is the delay from the end of the frame transmission 
to the enable of the receiver, as programmed for the DW1000's 
wait for response feature. */
#define RESP_TX_TO_FINAL_RX_DLY_UUS		500

/* Receive final timeout. See NOTE 5 below. */
#define FINAL_RX_TIMEOUT_UUS			3300


/* Length of the common part of the message 
(up to and including the function code, see NOTE below). */
#define ALL_MSG_COMMON_LEN				5 // Before 10

// ----------------- DS-TWR ----------------- //
// BUFFERS LENGTH 
#define TEST_LEN						4
#define TWR_BUF_LEN						12
#define DATA_BUF_LEN                    13
#define RX_BUF_LEN						24
#define TWR_INIT_LEN                    7


#define TWR_SYNC_START_LEN              4
#define TWR_SYNC_BUF_LEN                12


//Buffer Data Indexes
#define ANCH_NUM_IDX                    1
#define TAG_ID_IDX						2
#define TWR_ANCH_IDX                    2
#define ALL_MSG_SN_IDX                  2
#define DIST_IDX						7
#define FINAL_MSG_POLL_TX_TS_IDX        10
#define FINAL_MSG_RESP_RX_TS_IDX        14
#define FINAL_MSG_FINAL_TX_TS_IDX       18
#define TS_INT_IDX						10
#define FINAL_MSG_TS_LEN                4
#define ANCH_IDX						1	
#define CODE_IDX						9
#define SYNC_CYCLE_IDX                  2

// ------------ CONTROL CODES ------------- //
#define START_BLINK						0x19	
#define FINAL_BLINK						0x06	
#define FINAL_MSG						0x23


// ----------------- TDOA ----------------- //

#define SFRAME_LEN						0.015
//#define SFRAME_LEN						0.065

#ifdef MASTER_ID 
  #define TDOA_BLINK_INTERVALL			(((anchor_id+1) * SFRAME_LEN - SFRAME_LEN) / (NUM_ANCH - 1))
#else
   #define TDOA_BLINK_INTERVALL			((anchor_id * SFRAME_LEN - SFRAME_LEN) / (NUM_ANCH - 1))
#endif

//#define TDOA_BLINK_INTERVALL_UUS		(TDOA_BLINK_INTERVALL/(1.0/499.2e6/128.0))
//#define DWT_TIME_MSG_DELAYED			0.002/(1.0/499.2e6/128.0) //!< = 15.65e-12 s
//#define DWT_TIME_TX_DELAYED				(512/499.2e6/128.0) //!< = 15.65e-12 s

//TWR SYNC
#define TDOA_MAX_CYCLE                  10000
#define NUM_TWR_CYCLE                   10
#define SYNC_CYCLE						10
#define DELAY_UUS						100000      
#define RESP_DLY						800

// ------------ CONTROL CODES ------------- //
#define INIT_TDOA_MSG                   0xFF


//Buffer Data Indexes
#define SS_STATUS_IDX					3
#define ANC_ID_IDX						2
#define SEQ_NUM_IDX						3
#define ANC_XX_IDX						4
#define ANC_YY_IDX						5
#define ANC_ZZ_IDX						6
#define ANC_ROOM_IDX                    7
#define TS_IDX							8
#define NUM_TAG_IDX						2

#define CODE_INIT						3


// BUFFERS LENGTH 
#define START_BLINK_LEN                 5
#define BROADCAST1_BLINK_LEN            6
#define BROADCAST2_BLINK_LEN            15	
#define RX_INIT_LEN						10			


// ----------------- BLE ----------------- // 
#define ADV_INTERVAL					50				// BLE advertising period			[ms]
#define QUEUE_MAX_LEN					100				// BLE devices queue max length		[#]
#define ANCHOR_DISCOVERY_WINDOW         600				// Anchor BLE disocvery windows		[ms]
#define TAG_DISCOVERY_WINDOW            350				// Determines scan interval in units of 0.625 millisecond.
#define SCAN_WINDOW						0x0045          // Determines scan window in units of 0.625 millisecond. 
#define SCAN_INTERVAL					0x0050                          // Determines scan interval in units of 0.625 millisecond.
#define SCAN_TIMEOUT					0x0000          // Timout when scanning. 0x0000 disables timeout.		
#define UWB_RX_TIMEOUT					500				// Define the UWB rx time windows for tags after BLE discovery
#define BLE_SLEEP_TIME					250
#define dummyBufLen						600



#endif