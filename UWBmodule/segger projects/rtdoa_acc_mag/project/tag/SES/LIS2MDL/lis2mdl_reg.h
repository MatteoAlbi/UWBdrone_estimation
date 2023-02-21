/**
  ******************************************************************************
  * @file    lis2mdl_reg.c
  * @author  Matteo Nardello
  * @brief   LIS2MDL generic driver file
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2022 Matteo Nardello.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at: 
  * opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */

/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef LIS2MDL_REGS_H
#define LIS2MDL_REGS_H

/* Includes ------------------------------------------------------------------*/
#include <stdint.h>
#include <stddef.h>
#include <math.h>
#include "twi.h"

/** @addtogroup LIS2MDL
  * @{
  *
  */

/** @defgroup LIS2MDL_Registers
  * @{
  *
  */

/** I2C Device Address 8 bit format **/
#define LIS2MDL_I2C_ADD                 0x1EU

/** Device Identification (Who am I) **/
#define LIS2MDL_ID                      0x40U

#define LIS2MDL_OFFSET_X_REG_L          0x45U
#define LIS2MDL_OFFSET_X_REG_H          0x46U
#define LIS2MDL_OFFSET_Y_REG_L          0x47U
#define LIS2MDL_OFFSET_Y_REG_H          0x48U
#define LIS2MDL_OFFSET_Z_REG_L          0x49U
#define LIS2MDL_OFFSET_Z_REG_H          0x4AU
#define LIS2MDL_WHO_AM_I                0x4FU
#define LIS2MDL_CFG_REG_A               0x60U
#define LIS2MDL_CFG_REG_B               0x61U
#define LIS2MDL_CFG_REG_C               0x62U
#define LIS2MDL_INT_CRTL_REG            0x63U
#define LIS2MDL_INT_SOURCE_REG          0x64U
#define LIS2MDL_INT_THS_L_REG           0x65U
#define LIS2MDL_INT_THS_H_REG           0x66U
#define LIS2MDL_STATUS_REG              0x67U
#define LIS2MDL_OUTX_L_REG              0x68U
#define LIS2MDL_OUTX_H_REG              0x69U
#define LIS2MDL_OUTY_L_REG              0x6AU
#define LIS2MDL_OUTY_H_REG              0x6BU
#define LIS2MDL_OUTZ_L_REG              0x6CU
#define LIS2MDL_OUTZ_H_REG              0x6DU
#define LIS2MDL_TEMP_OUT_L_REG          0x6EU
#define LIS2MDL_TEMP_OUT_H_REG          0x6FU

/**
  * @}
  *
  */

/** @defgroup LIS2MDL_Types_Definition
  * @{
  *
  */

typedef struct{
  uint8_t md                     : 2;
  uint8_t odr                    : 2;
  uint8_t lp                     : 1;
  uint8_t soft_rst               : 1;
  uint8_t reboot                 : 1;
  uint8_t comp_temp_en           : 1;
} lis2mdl_cfg_reg_a_t;

typedef struct{
  uint8_t lpf                    : 1;
  uint8_t set_rst                : 2; /* OFF_CANC + Set_FREQ */
  uint8_t int_on_dataoff         : 1;
  uint8_t off_canc_one_shot      : 1;
  uint8_t not_used_01            : 3;
} lis2mdl_cfg_reg_b_t;

typedef struct{
  uint8_t drdy_on_pin            : 1;
  uint8_t self_test              : 1;
  uint8_t _4wspi                 : 1;
  uint8_t ble                    : 1;
  uint8_t bdu                    : 1;
  uint8_t i2c_dis                : 1;
  uint8_t int_on_pin             : 1;
  uint8_t not_used_02            : 1;
} lis2mdl_cfg_reg_c_t;


typedef struct{
  uint8_t ien                    : 1;
  uint8_t iel                    : 1;
  uint8_t iea                    : 1;
  uint8_t not_used_01            : 2;
  uint8_t zien                   : 1;
  uint8_t yien                   : 1;
  uint8_t xien                   : 1;
} lis2mdl_int_crtl_reg_t;

typedef struct {
  uint8_t _int                   : 1;
  uint8_t mroi                   : 1;
  uint8_t n_th_s_z               : 1;
  uint8_t n_th_s_y               : 1;
  uint8_t n_th_s_x               : 1;
  uint8_t p_th_s_z               : 1;
  uint8_t p_th_s_y               : 1;
  uint8_t p_th_s_x               : 1;
} lis2mdl_int_source_reg_t;

typedef struct{
  uint8_t xda                    : 1;
  uint8_t yda                    : 1;
  uint8_t zda                    : 1;
  uint8_t zyxda                  : 1;
  uint8_t _xor                   : 1;
  uint8_t yor                    : 1;
  uint8_t zor                    : 1;
  uint8_t zyxor                  : 1;
} lis2mdl_status_reg_t;

/**
  * @}
  *
  */

/** @defgroup LIS2MDL_Enumerators_Definition
  * @{
  *
  */

typedef enum{
  LIS2MDL_CONTINUOUS_MODE  = 0,
  LIS2MDL_SINGLE_TRIGGER   = 1,
  LIS2MDL_POWER_DOWN       = 2,
} lis2mdl_md_t;

typedef enum{
  LIS2MDL_ODR_10Hz   = 0,
  LIS2MDL_ODR_20Hz   = 1,
  LIS2MDL_ODR_50Hz   = 2,
  LIS2MDL_ODR_100Hz  = 3,
} lis2mdl_odr_t;

typedef enum{
  LIS2MDL_HIGH_RESOLUTION  = 0,
  LIS2MDL_LOW_POWER        = 1,
} lis2mdl_lp_t;

typedef enum{
  LIS2MDL_ODR_DIV_2  = 0,
  LIS2MDL_ODR_DIV_4  = 1,
} lis2mdl_lpf_t;

typedef enum{
  LIS2MDL_SET_SENS_ODR_DIV_63        = 0,
  LIS2MDL_SENS_OFF_CANC_EVERY_ODR    = 1,
  LIS2MDL_SET_SENS_ONLY_AT_POWER_ON  = 2,
} lis2mdl_set_rst_t;

typedef enum{

  LIS2MDL_LSB_AT_LOW_ADD  = 0,
  LIS2MDL_MSB_AT_LOW_ADD  = 1,

} lis2mdl_ble_t;

typedef enum{

  LIS2MDL_CHECK_BEFORE  = 0,
  LIS2MDL_CHECK_AFTER   = 1,

} lis2mdl_int_on_dataoff_t;

typedef enum{

  LIS2MDL_SPI_4_WIRE   = 1,
  LIS2MDL_SPI_3_WIRE   = 0,

} lis2mdl_sim_t;

typedef enum{

  LIS2MDL_I2C_ENABLE   = 0,
  LIS2MDL_I2C_DISABLE  = 1,

} lis2mdl_i2c_dis_t;


/**
  * @defgroup LIS2MDL_Register_Union
  * @brief    This union group all the registers that has a bit-field
  *           description.
  *           This union is useful but not need by the driver.
  *
  *           REMOVING this union you are compliant with:
  *           MISRA-C 2012 [Rule 19.2] -> " Union are not allowed "
  *
  * @{
  *
  */
typedef union{ 
  lis2mdl_cfg_reg_a_t            cfg_reg_a;
  lis2mdl_cfg_reg_b_t            cfg_reg_b;
  lis2mdl_cfg_reg_c_t            cfg_reg_c;
  lis2mdl_int_crtl_reg_t         int_crtl_reg;
  lis2mdl_int_source_reg_t       int_source_reg;
  lis2mdl_status_reg_t           status_reg;
  uint8_t                        byte;
} lis2mdl_reg_t;

/**
  * @}
  *
  */

/** @defgroup LIS2MDL_Methods_Definition
  * @{
  *
  */

int32_t lis2mdl_read_reg(uint8_t reg, uint8_t *data, uint8_t len);
int32_t lis2mdl_write_reg(uint8_t reg, uint8_t *data, uint8_t len);

float_t lis2mdl_from_lsb_to_mgauss(int16_t lsb);
float_t lis2mdl_from_lsb_to_celsius(int16_t lsb);
int32_t lis2mdl_mag_user_offset_set(int16_t *val);
int32_t lis2mdl_mag_user_offset_get(int16_t *val);
int32_t lis2mdl_operating_mode_set(lis2mdl_md_t val);
int32_t lis2mdl_operating_mode_get(lis2mdl_md_t *val);
int32_t lis2mdl_data_rate_set(lis2mdl_odr_t val);
int32_t lis2mdl_data_rate_get(lis2mdl_odr_t *val);
int32_t lis2mdl_power_mode_set(lis2mdl_lp_t val);
int32_t lis2mdl_power_mode_get(lis2mdl_lp_t *val);
int32_t lis2mdl_offset_temp_comp_set(uint8_t val);
int32_t lis2mdl_offset_temp_comp_get(uint8_t *val);
int32_t lis2mdl_low_pass_bandwidth_set(lis2mdl_lpf_t val);
int32_t lis2mdl_low_pass_bandwidth_get(lis2mdl_lpf_t *val);
int32_t lis2mdl_set_rst_mode_set(lis2mdl_set_rst_t val);
int32_t lis2mdl_set_rst_mode_get(lis2mdl_set_rst_t *val);
int32_t lis2mdl_set_rst_sensor_single_set(uint8_t val);
int32_t lis2mdl_set_rst_sensor_single_get(uint8_t *val);
int32_t lis2mdl_block_data_update_set(uint8_t val);
int32_t lis2mdl_block_data_update_get(int8_t *val);
int32_t lis2mdl_mag_data_ready_get(uint8_t *val);
int32_t lis2mdl_mag_data_ovr_get(uint8_t *val);
int32_t lis2mdl_magnetic_raw_get(int16_t *val);
int32_t lis2mdl_temperature_raw_get(int16_t *val);
int32_t lis2mdl_device_id_get(uint8_t *buff);
int32_t lis2mdl_reset_set(uint8_t val);
int32_t lis2mdl_reset_get(uint8_t *val);
int32_t lis2mdl_boot_set(uint8_t val);
int32_t lis2mdl_boot_get(uint8_t *val);
int32_t lis2mdl_self_test_set(uint8_t val);
int32_t lis2mdl_self_test_get(uint8_t *val);
int32_t lis2mdl_data_format_set(lis2mdl_ble_t val);
int32_t lis2mdl_data_format_get(lis2mdl_ble_t *val);
int32_t lis2mdl_status_get(lis2mdl_status_reg_t *val);
int32_t lis2mdl_offset_int_conf_set(lis2mdl_int_on_dataoff_t val);
int32_t lis2mdl_offset_int_conf_get(lis2mdl_int_on_dataoff_t *val);
int32_t lis2mdl_drdy_on_pin_set(uint8_t val);
int32_t lis2mdl_drdy_on_pin_get(uint8_t *val);
int32_t lis2mdl_int_on_pin_set(uint8_t val);
int32_t lis2mdl_int_on_pin_get(uint8_t *val);
int32_t lis2mdl_int_gen_conf_set(lis2mdl_int_crtl_reg_t *val);
int32_t lis2mdl_int_gen_conf_get(lis2mdl_int_crtl_reg_t *val);
int32_t lis2mdl_int_gen_source_get(lis2mdl_int_source_reg_t *val);
int32_t lis2mdl_int_gen_treshold_set(uint16_t val);
int32_t lis2mdl_int_gen_treshold_get(uint16_t *val);
int32_t lis2mdl_spi_mode_set(lis2mdl_sim_t val);
int32_t lis2mdl_spi_mode_get(lis2mdl_sim_t *val);
int32_t lis2mdl_i2c_interface_set(lis2mdl_i2c_dis_t val);
int32_t lis2mdl_i2c_interface_get(lis2mdl_i2c_dis_t *val);

/**
  * @}
  *
  */

/**
  *@}
  *
  */

#endif /* LIS2MDL_REGS_H */

/****END OF FILE****/

// ADD by Matteo Albi
/* Includes ---------------------------------------------------------*/
#include <string.h>
#include <stdio.h>
#include "app_util_platform.h"
#include "app_error.h"
#include "nrf_drv_gpiote.h"
#include "nrf_delay.h"
#include "bsp.h"
#include "boards.h"
#include "fds_manager.h"

/* Macro ---------------------------------------------------------*/

#ifndef GREEN_LED
  #define	GREEN_LED	BSP_BOARD_LED_0
#endif
#ifndef BLUE_LED
  #define	BLUE_LED	BSP_BOARD_LED_1
#endif
#ifndef BOOT_TIME
  #define BOOT_TIME       20 //ms
#endif 

/* Functions to read/set registers ------------------------------------------*/

/**
  * @brief print value of selected register
  *
  * @param  ctx      read / write interface definitions
  * @param  reg_add  address of the register to display
  *
  */
void lis2mdl_print_reg(uint8_t reg_add);


/**
  * @brief  Magnetic output value.[get]
  *
  * @param  val      uint16_t 3 elements array that stores data read
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_magnetic_raw_get_my(int16_t *val);

/**
  * @brief  Temperature output value.[get]
  *
  * @param  val   uint16_t that stores data read
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_temperature_raw_get_my(int16_t *val);


/* Functions to manage the sensor ------------------------------------------*/

/**
  * @brief Initializes sensor in continuos mode
  *
  */
void lis2mdl_init(void);


/**
  * @brief read value from mag sensor and save it in buf;
  *   if no new data is available: save last value read
  *
  * @param buf   float 3 elements array that stores data read
  *
  */
int32_t lis2mdl_get_mag(float *buf);


/**
  * @brief reads value from mag sensor, applies calibration
  *   and saves it in buf; if no new data is available: 
  *   uses last value read
  *
  * @param buf   float 3 elementswhere save calibrated data
  *
  */
int32_t lis2mdl_get_mag_calibrated(float *buf);


/**
  * @brief reads value from mag sensor and prints it to uart
  *   after applying calibration; if no new data is available: 
  *   uses last value read
  *
  */
void lis2mdl_print_mag(void);


/**
  * @brief reads temperature sensor and saves it in val;
  *   if no new data is available: saves last value read
  *
  * @param val   pointer to float where saving data read
  *
  */
int32_t lis2mdl_get_temp(float *val);


/**
  * @brief reads temperature sensor and prints it to uart;
  *   if no new data is available: saves last value read
  *
  */
void lis2mdl_print_temp(void);

