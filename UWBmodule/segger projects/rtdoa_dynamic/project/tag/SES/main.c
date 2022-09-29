/*! ----------------------------------------------------------------------------
*  @file    anch_master_TDOA_main.c
*  @brief   
*
* 
* @attention
*
*
* @authors	Luca Santoro:		luca.santoro@unitn.it
*			Matteo Nardello:	matteo.nardello@unitn.it
*/

#include "../common/config.h"
#include "FreeRTOS.h"
#include "timers.h"
#include "bsp.h"
#include "os_ble.h"
#include "port_platform.h"
#include "UART.h"
#include "TWI.h"
#include "LIS2DH12.h"
#include <string.h>

#define debugOn

// Symbolic constants
#define	GREEN_LED	BSP_BOARD_LED_0
#define	BLUE_LED	BSP_BOARD_LED_1

/* -------------- PV Methods -------------------- */
void TDoA_Blink(void);


/* -------------- PV Variables -------------------- */
uint8		timestamp1[5];
uint8		timestamp2[5];
uint8		timestamp3[5];
uint8_t		statusFlag	= 0;
uint64_t	time		= 0;

TaskHandle_t main_task_handle;

void mainTask() {

  //vTaskDelay(12000);

  while (1) {

    tag_tdoa_run();


  }

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

void acc_twi_setup(void){
  // TWI interface to accelerometer
  vTWI_Init();
  // Initialise the accelerometer
  // Note: this function blocks for 20ms.
  vLIS2_Init();
#ifdef debugOn
  // printf appears from nRF52 UART on RPi interface pins
  printf("Accel test running\n");
  // Check the TWI and acceleromter are talking
  uint8_t u8ID = u8LIS2_TestRead();
  printf("LIS2DH12 - Who am I code:%x\n", u8ID);
#endif
  // Set accelerometer to bypass mode
  vLIS2_EnableBypass();
}

int main(void){  
        
        bsp_board_leds_init();
        bsp_board_led_on(GREEN_LED);

	boUART_Init();

        //acc_twi_setup();

	uwb_recv_setup();
        //ble_setup();	

	//nrf_gpio_pin_clear(13);
 //       nrf_gpio_cfg_output(13);

	//nrf_gpio_pin_clear(23);
 //       nrf_gpio_cfg_output(23);

	xTaskCreate(mainTask, "main", 256, NULL, tskIDLE_PRIORITY + 1, &main_task_handle );

#ifdef debugOn

	printf("Board configured. Starting RTOS\r\n");

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

    printf("Hard Fault at address: 0x%08x\r\n", (unsigned int)ia);
    printf("\r\n");
    //while(1);
}