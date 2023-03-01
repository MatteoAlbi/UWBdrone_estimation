/*! ----------------------------------------------------------------------------
*  @file    anch_master_TDOA_main.c
*  @brief   
*
* 
* @attention
*
*
* @authors	Luca Santoro:		luca.santoro@unitn.it
*		Matteo Nardello:	matteo.nardello@unitn.it
*               Matteo Albi:            matteo.albi@studenti.unitn.it
*/

#include <string.h>

#include "../common/config.h"
#include "FreeRTOS.h"
#include "timers.h"
#include "bsp.h"
#include "os_ble.h"
#include "port_platform.h"
#include "UART.h"
#include "twi.h"
#include "lis2dh12_reg.h"
#include "lis2mdl_reg.h"
#include "communication_python.h"
#include "fds_manager.h"
#include "TDOA.h"
#include "ekf.h"


#ifndef DEBUG_ON
  #define DEBUG_ON
#endif

// Symbolic constants
#ifndef GREEN_LED
  #define	GREEN_LED	BSP_BOARD_LED_0
#endif
#ifndef BLUE_LED
  #define	BLUE_LED	BSP_BOARD_LED_1
#endif
#ifndef BOOT_TIME
  #define BOOT_TIME       20 //ms
#endif  

/* -------------- PV Methods -------------------- */
void TDoA_Blink(void);


/* -------------- PV Variables -------------------- */
uint8		timestamp1[5];
uint8		timestamp2[5];
uint8		timestamp3[5];
uint8_t		statusFlag	= 0;
uint64_t	time		= 0;
uint32_t        err;
//TickType_t      dt, prev, now;

float           eul[3], ret[16], uwb_data[3], acc[3];
TickType_t      pos_tick[2], cycle_tick;

TaskHandle_t main_task_handle;

void mainTask() {

  //vTaskDelay(12000);
  //pycom_start(10, 10000, 30000);
  
  //ekf_init(ret);
  ////prev = xTaskGetTickCount();
  //while (1) {
  //  ekf_step(ret);
  //  //printf("\tq:\t%1.4f\t%1.4f\t%1.4f\t%1.4f\t", ret[0], ret[1], ret[2], ret[3]);
  //  ekf_quat2eul(ret, eul);
  //  printf("\teul:\t%3.2f\t%3.2f\t%3.2f\t", eul[0], eul[1], eul[2]);
  //  //printf("\taccG:\t%1.3f\t%1.3f\t%1.3f", ret[5], ret[6], ret[7]);
  //  //printf("\text_acc_det: %d", (int)ret[8]);
  //  //printf("\tdt: %f", ret[4]);
  //  printf("\r\n");

  //  //now = xTaskGetTickCount();
  //  //printf("\tdt: %d\r\n", now-prev);
  //  //prev = now;
  //  //nrf_delay_ms(10);
    
  //}

  while(1){
    err = tag_tdoa_run(uwb_data, &pos_tick[0]);
    //tag_tdoa_run(NULL,NULL);
    while(err) err = tag_tdoa_run(uwb_data, &pos_tick[0]);
    printf("%3.3f\t%3.3f\t%3.3f\t%d\r\n", 
            uwb_data[0], uwb_data[1], uwb_data[2], pos_tick[0]);
    //lis2dh_get_acc(acc);
    //cycle_tick = xTaskGetTickCount();
    //printf("%3.3f\t%3.3f\t%3.3f\t%d\t%4.1f\t%4.1f\t%4.1f\t%d\r\n", 
    //        uwb_data[0], uwb_data[1], uwb_data[2], pos_tick[0], acc[0], acc[1], acc[2], cycle_tick);
  }
  
  //while(1){
  //  lis2dh_get_acc(eul);
  //  printf("acc:\t%3.4f\t%3.4f\t%3.4f\r\n", eul[0], eul[1], eul[2]);
  //  nrf_delay_ms(10);
  //}

}

void uwb_recv_setup(void) {

  /* Setup DW1000 IRQ pin */
  nrf_gpio_cfg_input(DW1000_IRQ, NRF_GPIO_PIN_NOPULL); //irq

  /* Reset DW1000 */
  reset_DW1000();

  /* Set SPI clock to 2MHz */
  port_set_dw1000_slowrate();

  /* Init the DW1000 */
  if (dwt_initialise(DWT_LOADUCODE) == DWT_ERROR) {
    //Init of DW1000 Failed
    while (1) {
    };
  }

  // Set SPI to 8MHz clock
  port_set_dw1000_fastrate();

  /* Configure DW1000. */
  dwt_configure(&config);

  /* Apply default antenna delay value. Defined in port platform.h */
  dwt_setrxantennadelay(RX_ANT_DLY);
  dwt_settxantennadelay(TX_ANT_DLY);

  /* Set preamble timeout for expected frames.  */
  //dwt_setpreambledetecttimeout(PRE_TIMEOUT);
}

int main(void){  
        
    bsp_board_leds_init();
    bsp_board_led_on(GREEN_LED);
    
    // init UART interface
    boUART_Init();
    // init I2C interface
    vTWI_Init();
    // wait for boot
    nrf_delay_ms(BOOT_TIME);

    // init acc sensor
    lis2dh_init_bypass();
    nrf_delay_ms(BOOT_TIME);
    
    // init mag sensor
    //lis2mdl_init();
    //nrf_delay_ms(BOOT_TIME);

    // init flash data storage
    uint32_t err_code = man_fds_init();
    // laod data from flash storage
    err = man_fds_load_config_all();

    // test flash storage
    //const man_fds_mag_t * mag_conf = man_fds_get_mag_config();
    //printf("man_fds_mag.hard_iron:\t");
    //for(uint8_t i=0;i<3;i++){
    //  printf("%f\t", mag_conf->hard_iron[i]);
    //}
    //printf("\r\nman_fds_mag.soft_iron:\t");
    //for(uint8_t i=0;i<9;i++){
    //  printf("%f\t", mag_conf->soft_iron[i]);
    //}
    //printf("\r\n");

    uwb_recv_setup();
    //ble_setup();	

    //nrf_gpio_pin_clear(13);
//       nrf_gpio_cfg_output(13);

    //nrf_gpio_pin_clear(23);
//       nrf_gpio_cfg_output(23);

    xTaskCreate(mainTask, "main", 512, NULL, tskIDLE_PRIORITY + 1, &main_task_handle );

#ifdef DEBUG_ON
#ifdef PY_COM
    //pycom_write_pck_cmd(PYCOM_SEND_STRING);
#endif
    printf("\r\nBoard configured. Starting RTOS\r\n");

#endif
    bsp_board_led_off(GREEN_LED);

    vTaskStartScheduler();

    while(1){
        APP_ERROR_HANDLER(NRF_ERROR_FORBIDDEN);
    }
}

void assert_nrf_callback(uint16_t line_num, const uint8_t * p_file_name){

    app_error_handler(DEAD_BEEF, line_num, p_file_name);
}

void HardFault_Handler(void)
{
    uint32_t *sp = (uint32_t *) __get_MSP(); // Get stack pointer
    uint32_t ia = sp[12]; // Get instruction address from stack
#ifdef PY_COM
    //pycom_write_pck_cmd(PYCOM_SEND_STRING);
#endif
    printf("Hard Fault at address: 0x%08x\r\n", (unsigned int)ia);
    printf("\r\n");
    //while(1);
}