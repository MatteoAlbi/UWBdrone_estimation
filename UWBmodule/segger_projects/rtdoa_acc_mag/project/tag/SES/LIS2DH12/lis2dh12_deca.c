#include <string.h>
#include <stdio.h>
#include "app_util_platform.h"
#include "app_error.h"
#include "nrf_drv_gpiote.h"
#include "nrf_delay.h"
#include "bsp.h"
#include "boards.h"
#include "lis2dh12_reg.h"
#include "twi.h"

/* Private variables ---------------------------------------------------------*/
static int16_t data_raw_acceleration[3];
static int16_t data_raw_temperature;
static float acceleration_mg[3];
static float temperature_degC;
static uint8_t whoamI;
static stmdev_ctx_t dev_ctx;
static bool device_found;

/* Definition of TWI functions ------------------------------------------*/

static int32_t platform_write(uint8_t* handle, uint8_t reg, const uint8_t *bufp, uint16_t len){
  ret_code_t ret = vTWI_Write(*handle, reg, bufp, len);
  return ret;
}

static int32_t platform_read(uint8_t* handle, uint8_t reg, uint8_t *bufp, uint16_t len){
  ret_code_t ret = vTWI_Read(*handle, reg, bufp, len);
}

/**
@brief Initialize sensor to work in bypass mode: only last 
  sensor value is memorized
*/
void lis2dh_init_bypass(void){
  // init handling communication struct 
  dev_ctx.write_reg = platform_write;
  dev_ctx.read_reg = platform_read;
  *dev_ctx.handle = LIS2DH12_I2C_ADD_L;

  // platform init
  vTWI_Init();
  // wait for boot
  nrf_delay_ms(BOOT_TIME);

  /* Check device ID */
  lis2dh12_device_id_get(&dev_ctx, &whoamI);

  if (whoamI != LIS2DH12_ID) {
    device_found = false;
    printf("LIS2DH12 device not found at LIS2DH12_I2C_ADD=%d\n", LIS2DH12_I2C_ADD_L);  
  }
  else{
    device_found = true;

    //ACC SENSOR
    /* Set FIFO mode to Bypass mode. */
    (&dev_ctx, LIS2DH12_BYPASS_MODE);
    /* Set full scale to 2g. */
    lis2dh12_full_scale_set(&dev_ctx, LIS2DH12_2g);
    /* Set device to 12 bit resol. */
    lis2dh12_operating_mode_set(&dev_ctx, LIS2DH12_HR_12bit);
    /* Set Output Data Rate to 50Hz. */
    lis2dh12_data_rate_set(&dev_ctx, LIS2DH12_ODR_50Hz);

    // TEMP SENSOR
    /* Enable temperature sensor. */
    lis2dh12_temperature_meas_set(&dev_ctx, LIS2DH12_TEMP_ENABLE);
  }

}

/**
* @brief read single value from acc buffer data,
* if no new data is available: print last value read
*/
void lis2dh_read_acc(void){
  if(! device_found){
    printf("Device not found during init\n");
    return;
  }

  uint8_t dummy;
  lis2dh12_fifo_data_level_get(&dev_ctx, &dummy);
  if(dummy > 0){
    /*Blue led on to signal starting read. */
    bsp_board_led_on(BLUE_LED);
    /* Read XL samples */
    lis2dh12_acceleration_raw_get(&dev_ctx, data_raw_acceleration);
    acceleration_mg[0] = lis2dh12_from_fs2_hr_to_mg(data_raw_acceleration[0]);
    acceleration_mg[1] = lis2dh12_from_fs2_hr_to_mg(data_raw_acceleration[1]);
    acceleration_mg[2] = lis2dh12_from_fs2_hr_to_mg(data_raw_acceleration[2]);

    bsp_board_led_off(BLUE_LED);
  }

  // Print to UART most recent data
  printf("%4.2f\t%4.2f\t%4.2f\r\n", acceleration_mg[0], 
                                    acceleration_mg[1], 
                                    acceleration_mg[2]);

}

/**
* @brief read temperature sensor,
* if no new data is available: print last value read
*/
void lis2dh_read_temp(void){
  if(! device_found){
    printf("Device not found during init\n");
    return;
  }

  uint8_t dummy;
  lis2dh12_temp_data_ready_get(&dev_ctx, &dummy);
  if (dummy) {
    /* Read temperature data */
    memset(&data_raw_temperature, 0x00, sizeof(int16_t));
    lis2dh12_temperature_raw_get(&dev_ctx, &data_raw_temperature);
    /*Convert raw data in float. */
    temperature_degC = lis2dh12_from_lsb_hr_to_celsius(data_raw_temperature);
  }

  // Print to UART most recent data
  printf("%6.2f\r\n", temperature_degC);

}