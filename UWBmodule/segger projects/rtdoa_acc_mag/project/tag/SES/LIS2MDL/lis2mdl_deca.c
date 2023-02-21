#include <string.h>
#include <stdio.h>
#include "lis2mdl_reg.h"

#include "app_util_platform.h"
#include "app_error.h"
#include "nrf_drv_gpiote.h"
#include "nrf_delay.h"
#include "bsp.h"
#include "boards.h"
#include "twi.h"

/* Macro ---------------------------------------------------------*/
#define BOOT_TIME       20 //ms
#define	BLUE_LED	BSP_BOARD_LED_1

/* Private variables ---------------------------------------------------------*/
static int16_t data_raw_magnetic[3];
static int16_t data_raw_temperature;
static float magnetic_mG[3];
static float temperature_degC;
static uint8_t whoamI, rst;
static stmdev_ctx_t dev_ctx;
static bool device_found;

/* TWI functions ---------------------------------------------------------*/
static ret_code_t platform_write(void *handle, uint8_t reg, const uint8_t *bufp, uint16_t len);
static ret_code_t platform_read(void *handle, uint8_t reg, uint8_t *bufp, uint16_t len);

/* Definition of TWI functions ------------------------------------------*/
static ret_code_t platform_write(void *handle, uint8_t reg, const uint8_t *bufp, uint16_t len){
  ret_code_t ret = vTWI_Write(handle, reg, bufp, len);
  return ret;
}

static ret_code_t platform_read(void *handle, uint8_t reg, uint8_t *bufp, uint16_t len){
  ret_code_t ret = vTWI_Read(handle, reg, bufp, len);
}


/**
@brief Initialize sensor in continuos mode
*/
void lis2mdl_init(void){

  /* Check device ID */
  lis2mdl_device_id_get(&dev_ctx, &whoamI);

  if (whoamI != LIS2MDL_ID){
    device_found = false;
    printf("LIS2MDL device not found at LIS2MDL_I2C_ADD=%d\n", LIS2MDL_I2C_ADD);  
  }
  else{
    device_found = true;
  }


}