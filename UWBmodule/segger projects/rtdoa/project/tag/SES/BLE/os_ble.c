#include "os_ble.h"
#include "nrf_sdh.h"
#include "nrf_sdh_ble.h"
#include "ble_gap.h"
#include "nrf_ble_gatt.h"
#include "ble_advdata.h"
#include "bsp.h"
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "../common/config.h"

//#define debugOn

//Min ADV intervall in non connectable mode is 100ms from BLE specs
#define NON_CONNECTABLE_ADV_INTERVAL    MSEC_TO_UNITS(ADV_INTERVAL, UNIT_0_625_MS)  /**< The advertising interval for non-connectable advertisement (100 ms). This value can vary between 100ms to 10.24s). */

#define APP_BLE_CONN_CFG_TAG            1                                  /**< A tag identifying the SoftDevice BLE configuration. */
#define APP_BEACON_INFO_LENGTH          0x17                               
#define APP_ADV_DATA_LENGTH             0x15                               
#define APP_DEVICE_TYPE                 0x02                               
#define APP_MEASURED_RSSI               0xBF                 
#define APP_COMPANY_IDENTIFIER          0x004C                             
#define APP_MAJOR_VALUE                 0x00, 0x00                         /**< Major value used to identify Beacons. */
#define APP_MINOR_VALUE                 0x00, 0x00                         /**< Minor value used to identify Beacons. */
#define APP_BEACON_UUID                 0xC5, 0x5E, 0x40, 0x11, \
                                        0x41, 0x4A, 0x41, 0x59, \
                                        0x00, 0x00, 0x00, 0x00, \
                                        0x00, 0x00, 0x00, 0x00            /**< Proprietary UUID for Beacon. */
#define MAC_GROUP                       0x00, 0x00, 0x00, 0xCA, 0xDE
SemaphoreHandle_t bleBroadcastStart;
SemaphoreHandle_t bleBroadcastStop;
SemaphoreHandle_t bleScanStart;
SemaphoreHandle_t bleScanStop;
QueueHandle_t bleSetId;
QueueHandle_t bleScanResult;

uint8_t count = 0;

static ble_gap_adv_params_t m_adv_params;                                 /**< Parameters to be passed to the stack when starting advertising. */

NRF_BLE_GATT_DEF(m_gatt);                                                                       \


static uint8_t m_beacon_info[APP_BEACON_INFO_LENGTH] =                    /**< Information advertised by the Beacon. */
{
    APP_DEVICE_TYPE,     // Manufacturer specific information. Specifies the device type in this
                         // implementation.
    APP_ADV_DATA_LENGTH, // Manufacturer specific information. Specifies the length of the
                         // manufacturer specific data in this implementation.
    APP_BEACON_UUID,     // 128 bit UUID value.
    APP_MAJOR_VALUE,     // Major arbitrary value that can be used to distinguish between Beacons.
    APP_MINOR_VALUE,     // Minor arbitrary value that can be used to distinguish between Beacons.
    APP_MEASURED_RSSI    // Manufacturer specific information. The Beacon's measured TX power in
                         // this implementation.
};

/** @brief Parameters used when scanning. */
static ble_gap_scan_params_t const m_scan_params =
{
    .active = 0, // Passive scanning mode
    .use_whitelist = 0,		
    .adv_dir_report = 0,
    .interval = SCAN_INTERVAL, 		
    .window = SCAN_WINDOW,
    .timeout = SCAN_TIMEOUT
};

/**@brief Function for initializing the Advertising functionality.
 *
 * @details Encodes the required advertising data and passes it to the stack.
 *          Also builds a structure to be passed to the stack when starting advertising.
 */
static void advertising_init(void)
{
    uint32_t      err_code;
    ble_advdata_t advdata;
    uint8_t       flags = BLE_GAP_ADV_FLAG_BR_EDR_NOT_SUPPORTED;

    ble_advdata_manuf_data_t manuf_specific_data;

    manuf_specific_data.company_identifier = APP_COMPANY_IDENTIFIER;
    manuf_specific_data.data.p_data = (uint8_t *) m_beacon_info;
    manuf_specific_data.data.size   = APP_BEACON_INFO_LENGTH;

    // Build and set advertising data.
    memset(&advdata, 0, sizeof(advdata));

    advdata.name_type             = BLE_ADVDATA_NO_NAME;
    advdata.flags                 = flags;
    advdata.p_manuf_specific_data = &manuf_specific_data;

    err_code = ble_advdata_set(&advdata, NULL);
    APP_ERROR_CHECK(err_code);

    // Initialize advertising parameters (used when starting advertising).
    memset(&m_adv_params, 0, sizeof(m_adv_params));

    m_adv_params.type        = BLE_GAP_ADV_TYPE_ADV_SCAN_IND;
    m_adv_params.p_peer_addr = NULL;    // Undirected advertisement.
    m_adv_params.fp          = BLE_GAP_ADV_FP_ANY;
    m_adv_params.interval    = NON_CONNECTABLE_ADV_INTERVAL;
    m_adv_params.timeout     = 0;       // Never time out.

    sd_ble_gap_adv_stop();
    sd_ble_gap_scan_stop();
    sd_ble_gap_tx_power_set(-8);
    ble_gap_addr_t     node_address       = {0, BLE_GAP_ADDR_TYPE_RANDOM_STATIC,{TAG_ID, MAC_GROUP}};
    err_code = sd_ble_gap_addr_set(&node_address);
    APP_ERROR_CHECK(err_code);
}

/**@brief Function for handling BLE events.
 *
 * @param[in]   p_ble_evt   Bluetooth stack event.
 * @param[in]   p_context   Unused.
 */
static void ble_evt_handler(ble_evt_t const * p_ble_evt, void * p_context)
{
    ret_code_t            err_code;
    ble_gap_evt_t const * p_gap_evt = &p_ble_evt->evt.gap_evt;
    bool match = true;
    uint8_t*        data;
    uint16_t ping;
    uint8_t rssi;
    uint8_t i = 0;
	
#ifdef debugOn

    printf("EVENT ID: %d\r\n", p_ble_evt->header.evt_id);

#endif	

    switch(p_ble_evt->header.evt_id){

		case(BLE_GAP_EVT_ADV_REPORT): 
			
            count++;

			ble_gap_evt_adv_report_t const *p_adv_report = &p_gap_evt->params.adv_report;

			data = p_adv_report->data;
			rssi = p_adv_report->rssi;

			match = p_adv_report->peer_addr.addr[5] == 0xDE &&  // Check that we are receiving
					p_adv_report->peer_addr.addr[4] == 0xCA &&	// Only beacons coming from master
					p_adv_report->peer_addr.addr[3] == 0x01;	// anchor

			if(match){

				ping = (p_adv_report->peer_addr.addr[0]<<8) | rssi;

				xQueueSendFromISR(bleScanResult, &ping, 0);
#ifdef debugOn

				printf("DATA: ");

				for(i = 0; i < p_adv_report->dlen; i++){
				
					printf("%#02x ", *(data));
					data++;

				}

				printf("\r\n");
#endif	
            }
            break;

		case(BLE_GAP_EVT_SCAN_REQ_REPORT):
		
#ifdef debugOn		

			printf("BLE_GAP_EVT_SCAN_REQ_REPORT\r\n");

#endif	
			
			break;
    }

    

    /*if (p_ble_evt->header.evt_id == BLE_GAP_EVT_ADV_REPORT){
       
        ble_gap_evt_adv_report_t const * p_adv_report = &p_gap_evt->params.adv_report;
        count++;
        data =  p_adv_report->data;
        rssi = p_adv_report->rssi;

        match = p_adv_report->peer_addr.addr[5] == 0xDE &&  // Check that we are receiving
				p_adv_report->peer_addr.addr[4] == 0xCA &&	// Only beacons coming from master
				p_adv_report->peer_addr.addr[3] == 0x01;	// anchor

         if(match){

          ping = (p_adv_report->peer_addr.addr[0]<<8) | rssi;

          xQueueSendFromISR(bleScanResult, &ping, 0);
          
         /* printf("%d: Received target %02x:%02x:%02x:%02x:%02x:%02x, RSSI: %d\r\n",
             count,
             p_adv_report->peer_addr.addr[0], p_adv_report->peer_addr.addr[1],
             p_adv_report->peer_addr.addr[2], p_adv_report->peer_addr.addr[3],
             p_adv_report->peer_addr.addr[4], p_adv_report->peer_addr.addr[5],
             p_adv_report->rssi
             );
             
       }
    }*/
}

/**@brief Function for initializing the BLE stack.
 *
 * @details Initializes the SoftDevice and the BLE event interrupt.
 */
 void ble_setup()
{
    ret_code_t err_code;

    err_code = nrf_sdh_enable_request();
    APP_ERROR_CHECK(err_code);

    uint32_t ram_start = 0;
    err_code = nrf_sdh_ble_default_cfg_set(APP_BLE_CONN_CFG_TAG, &ram_start);
    APP_ERROR_CHECK(err_code);

    err_code = nrf_sdh_ble_enable(&ram_start);
    APP_ERROR_CHECK(err_code);
    NRF_SDH_BLE_OBSERVER(m_ble_observer, 2, ble_evt_handler, NULL);

    bleBroadcastStart = xSemaphoreCreateBinary();
    bleBroadcastStop = xSemaphoreCreateBinary();
    bleScanStart = xSemaphoreCreateBinary();
    bleScanStop = xSemaphoreCreateBinary();
    bleSetId = xQueueCreate(1, sizeof(uint8_t));
    bleScanResult = xQueueCreate(QUEUE_MAX_LEN, sizeof(uint16_t));
}


void scan_start(void) {
    ret_code_t err_code; 	 	
    //ble_gap_whitelist_t  whitelist;

    const ble_gap_addr_t     whitelist_mobile 	= {0, BLE_GAP_ADDR_TYPE_RANDOM_STATIC,{0x00,MAC_GROUP}};
    const ble_gap_addr_t     whitelist_static_1 	= {0, BLE_GAP_ADDR_TYPE_RANDOM_STATIC,{0x01,MAC_GROUP}}; 	
    const ble_gap_addr_t     whitelist_static_2 	= {0, BLE_GAP_ADDR_TYPE_RANDOM_STATIC,{0x02,MAC_GROUP}}; 	
    const ble_gap_addr_t     whitelist_static_3       = {0, BLE_GAP_ADDR_TYPE_RANDOM_STATIC,{0x03,MAC_GROUP}};
    const ble_gap_addr_t     whitelist_static_4       = {0, BLE_GAP_ADDR_TYPE_RANDOM_STATIC,{0x04,MAC_GROUP}};
    const ble_gap_addr_t     whitelist_static_5       = {0, BLE_GAP_ADDR_TYPE_RANDOM_STATIC,{0x05,MAC_GROUP}};


    const ble_gap_addr_t*    p_whitelist_addr[6] = {&whitelist_mobile, &whitelist_static_1, &whitelist_static_2, &whitelist_static_3,&whitelist_static_4,&whitelist_static_5};
    err_code = sd_ble_gap_whitelist_set(p_whitelist_addr, 6);
    APP_ERROR_CHECK(err_code); 	 

    sd_ble_gap_scan_stop();
    err_code = sd_ble_gap_scan_start(&m_scan_params);
    APP_ERROR_CHECK(err_code);
}

//uint16_t j = 0;

/*void bleTask(){
  bool scanning = false;
  bool broadcasting = false;
  
  advertising_init();
  for(;;){
	//j++;
    //printf("J: %d\r\n",j);
    if(xSemaphoreTake(bleBroadcastStart, 0) == pdPASS){
      if(broadcasting == false){
        sd_ble_gap_adv_start(&m_adv_params, APP_BLE_CONN_CFG_TAG);
        //printf("Start adv %d\r\n",j);
      }
      broadcasting = true;
    }else if(xSemaphoreTake(bleBroadcastStop, 0) == pdPASS){
      if(broadcasting == true){
        sd_ble_gap_adv_stop();
        //printf("Stop adv %d\r\n",j);
      }
      broadcasting = false;
    }else if(xSemaphoreTake(bleScanStart, 0) == pdPASS){
      if(scanning == false){
        scan_start();
        //printf("Start Scan %d\r\n",j);
      }
      scanning = true;
    }else if(xSemaphoreTake(bleScanStop, 0) == pdPASS){
      if(scanning == true){
        sd_ble_gap_scan_stop();
		//printf("Stop Scan %d\r\n",j);
      }
      scanning = false;
    }else if(xQueueReceive(bleSetId, &TAG_ID, 0) == pdPASS){
      m_beacon_info[19] = TAG_ID;
      advertising_init();
      if(broadcasting){
        sd_ble_gap_adv_start(&m_adv_params, APP_BLE_CONN_CFG_TAG);
		//printf("Start adv new ID %d\r\n",j);
      }
      if(scanning){
        scan_start();
        //printf("Start Scan new ID %d\r\n",j);
      }
    }
    vTaskDelay(50);
  }
}*/

void bleStart(){

	advertising_init();

    sd_ble_gap_adv_start(&m_adv_params, APP_BLE_CONN_CFG_TAG);
	scan_start();
}

void bleStop(){
	
    sd_ble_gap_adv_stop();
	sd_ble_gap_scan_stop();

    vTaskDelay(5);
}
