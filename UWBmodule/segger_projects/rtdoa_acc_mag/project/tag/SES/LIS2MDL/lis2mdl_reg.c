/**
  ******************************************************************************
  * @file    lis2mdl_reg.c
  * @author  Matteo Nardello
  * @brief   LIS2MDL driver file
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

#include "lis2mdl_reg.h"

/**
  * @defgroup    LIS2MDL
  * @brief       This file provides a set of functions needed to drive the
  *              lis2mdl ultra-low-power, high-performance 3-axis digital magnetic sensor.
  * @{
  *
  */

/**
  * @defgroup    LIS2MDL_Interfaces_Functions
  * @brief       This section provide a set of functions used to read and
  *              write a generic register of the device.
  *              MANDATORY: return 0 -> no Error.
  * @{
  *
  */

/**
  * @brief  Generic I2C register read function
  * @param  reg   register to read
  * @param  data  pointer to buffer that store the data read(ptr)
  * @param  len   number of consecutive register to read
  * @retval       interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_read_reg(uint8_t reg, uint8_t *data, uint8_t len){

  return(vTWI_Read (LIS2MDL_I2C_ADD, reg, data, len));

}

/**
  * @brief  Generic I2C register Write function
  * @param  reg   register to write
  * @param  data  data to write in register reg
  * @param  len   number of consecutive register to write
  * @retval       interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_write_reg(uint8_t reg, uint8_t *data, uint8_t len){


  return (vTWI_Write_my(LIS2MDL_I2C_ADD, reg, data, len));

}

/**
  * @}
  *
  */

/**
  * @defgroup    LIS2MDL_Sensitivity
  * @brief       These functions convert raw-data into engineering units.
  * @{
  *
  */
float_t lis2mdl_from_lsb_to_mgauss(int16_t lsb){

  return ((float_t)lsb * 1.5f);
}

float_t lis2mdl_from_lsb_to_celsius(int16_t lsb){

  return (((float_t)lsb / 8.0f) + 25.0f);
}

/**
  * @}
  *
  */

/**
  * @defgroup    LIS2MDL_data_generation
  * @brief       This section group all the functions concerning
  *              data generation
  * @{
  *
  */

/**
  * @brief  These registers comprise a 3 group of 16-bit number and represent
  *         hard-iron offset in order to compensate environmental effects.
  *         Data format is the same of output data raw: two’s complement
  *         with 1LSb = 1.5mG. These values act on the magnetic output data
  *         value in order to delete the environmental offset.[set]
  *
  * @param  val  buffer that contains data to write
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_mag_user_offset_set(int16_t *val){
  uint8_t buff[6];

  buff[1] = (uint8_t)((uint16_t)val[0] / 256U);
  buff[0] = (uint8_t)((uint16_t)val[0] - (buff[1] * 256U));
  buff[3] = (uint8_t)((uint16_t)val[1] / 256U);
  buff[2] = (uint8_t)((uint16_t)val[1] - (buff[1] * 256U));
  buff[5] = (uint8_t)((uint16_t)val[2] / 256U);
  buff[4] = (uint8_t)((uint16_t)val[2] - (buff[1] * 256U));

  return(lis2mdl_write_reg(LIS2MDL_OFFSET_X_REG_L, buff, 6));
}

/**
  * @brief  These registers comprise a 3 group of 16-bit number and represent
  *         hard-iron offset in order to compensate environmental effects.
  *         Data format is the same of output data raw: two’s complement
  *         with 1LSb = 1.5mG. These values act on the magnetic output data
  *         value in order to delete the environmental offset.[get]
  *
  * @param  buff  that stores data read
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_mag_user_offset_get(int16_t *val){

  uint8_t buff[6];
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_OFFSET_X_REG_L, buff, 6);

  val[0] = (int16_t)buff[1];
  val[0] = (val[0] * 256) + (int16_t)buff[0];
  val[1] = (int16_t)buff[3];
  val[1] = (val[1] * 256) + (int16_t)buff[2];
  val[2] = (int16_t)buff[5];
  val[2] = (val[2] * 256) + (int16_t)buff[4];

  return ret;
}

/**
  * @brief  Operating mode selection.[set]
  *
  * @param  val    change the values of md in reg CFG_REG_A
  * @retval        interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_operating_mode_set(lis2mdl_md_t val){
  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.md = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Operating mode selection.[get]
  *
  * @param  val   Get the values of md in reg CFG_REG_A.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_operating_mode_get(lis2mdl_md_t *val){

  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  switch (reg.md)
  {
    case LIS2MDL_POWER_DOWN:
      *val = LIS2MDL_POWER_DOWN;
      break;

    case LIS2MDL_CONTINUOUS_MODE:
      *val = LIS2MDL_CONTINUOUS_MODE;
      break;

    case LIS2MDL_SINGLE_TRIGGER:
      *val = LIS2MDL_SINGLE_TRIGGER;
      break;

    default:
      *val = LIS2MDL_POWER_DOWN;
      break;
  }

  return ret;

}

/**
  * @brief  Output data rate selection.[set]
  *
  * @param  val   change the values of odr in reg CFG_REG_A
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_data_rate_set(lis2mdl_odr_t val){
  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.odr = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Output data rate selection.[get]
  *
  * @param  val   Get the values of odr in reg CFG_REG_A.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_data_rate_get(lis2mdl_odr_t *val){
  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  switch (reg.odr)
  {
    case LIS2MDL_ODR_10Hz:
      *val = LIS2MDL_ODR_10Hz;
      break;

    case LIS2MDL_ODR_20Hz:
      *val = LIS2MDL_ODR_20Hz;
      break;

    case LIS2MDL_ODR_50Hz:
      *val = LIS2MDL_ODR_50Hz;
      break;

    case LIS2MDL_ODR_100Hz:
      *val = LIS2MDL_ODR_100Hz;
      break;

    default:
      *val = LIS2MDL_ODR_10Hz;
      break;
  }

  return ret;
}

/**
  * @brief  Enables high-resolution/low-power mode.[set]
  *
  * @param  val   change the values of lp in reg CFG_REG_A
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_power_mode_set(lis2mdl_lp_t val){

  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.lp = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Enables high-resolution/low-power mode.[get]
  *
  * @param  val   Get the values of lp in reg CFG_REG_A.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_power_mode_get(lis2mdl_lp_t *val) {

  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  switch (reg.lp)
  {
    case LIS2MDL_HIGH_RESOLUTION:
      *val = LIS2MDL_HIGH_RESOLUTION;
      break;

    case LIS2MDL_LOW_POWER:
      *val = LIS2MDL_LOW_POWER;
      break;

    default:
      *val = LIS2MDL_HIGH_RESOLUTION;
      break;
  }

  return ret;
}

/**
  * @brief  Enables the magnetometer temperature compensation.[set]
  *
  * @param  val   change the values of comp_temp_en in reg CFG_REG_A
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_offset_temp_comp_set(uint8_t val)
{
  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.comp_temp_en = val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Enables the magnetometer temperature compensation.[get]
  *
  * @param  val   change the values of comp_temp_en in reg CFG_REG_A.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_offset_temp_comp_get(uint8_t *val){

  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  *val = reg.comp_temp_en;

  return ret;
}

/**
  * @brief  Low-pass bandwidth selection.[set]
  *
  * @param  val   change the values of lpf in reg CFG_REG_B
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_low_pass_bandwidth_set(lis2mdl_lpf_t val) {

  lis2mdl_cfg_reg_b_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.lpf = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);
  }

  return ret;

}

/**
  * @brief  Low-pass bandwidth selection.[get]
  *
  * @param  val   Get the values of lpf in reg CFG_REG_B.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_low_pass_bandwidth_get(lis2mdl_lpf_t *val){

  lis2mdl_cfg_reg_b_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);

  switch (reg.lpf)
  {
    case LIS2MDL_ODR_DIV_2:
      *val = LIS2MDL_ODR_DIV_2;
      break;

    case LIS2MDL_ODR_DIV_4:
      *val = LIS2MDL_ODR_DIV_4;
      break;

    default:
      *val = LIS2MDL_ODR_DIV_2;
      break;
  }

  return ret;
}

/**
  * @brief  Reset mode.[set]
  *
  * @param  val   change the values of set_rst in reg CFG_REG_B
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_set_rst_mode_set(lis2mdl_set_rst_t val){

  lis2mdl_cfg_reg_b_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.set_rst = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Reset mode.[get]
  *
  * @param  val   Get the values of set_rst in reg CFG_REG_B.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_set_rst_mode_get(lis2mdl_set_rst_t *val){

  lis2mdl_cfg_reg_b_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);

  switch (reg.set_rst)
  {
    case LIS2MDL_SET_SENS_ODR_DIV_63:
      *val = LIS2MDL_SET_SENS_ODR_DIV_63;
      break;

    case LIS2MDL_SENS_OFF_CANC_EVERY_ODR:
      *val = LIS2MDL_SENS_OFF_CANC_EVERY_ODR;
      break;

    case LIS2MDL_SET_SENS_ONLY_AT_POWER_ON:
      *val = LIS2MDL_SET_SENS_ONLY_AT_POWER_ON;
      break;

    default:
      *val = LIS2MDL_SET_SENS_ODR_DIV_63;
      break;
  }

  return ret;
}

/**
  * @brief  Enables offset cancellation in single measurement mode.
  *         The OFF_CANC bit must be set to 1 when enabling offset
  *         cancellation in single measurement mode this means a
  *         call function: set_rst_mode(SENS_OFF_CANC_EVERY_ODR)
  *         is need.[set]
  *
  * @param  val   change the values of off_canc_one_shot in reg CFG_REG_B
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_set_rst_sensor_single_set(uint8_t val){

  lis2mdl_cfg_reg_b_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.off_canc_one_shot = val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Enables offset cancellation in single measurement mode.
  *         The OFF_CANC bit must be set to 1 when enabling offset
  *         cancellation in single measurement mode this means a
  *         call function: set_rst_mode(SENS_OFF_CANC_EVERY_ODR)
  *         is need.[get]
  *
  * @param  val   change the values of off_canc_one_shot in reg CFG_REG_B.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_set_rst_sensor_single_get(uint8_t *val){

  lis2mdl_cfg_reg_b_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);
  *val = reg.off_canc_one_shot;

  return ret;

}

/**
  * @brief  Blockdataupdate.[set]
  *
  * @param  val   change the values of bdu in reg CFG_REG_C
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_block_data_update_set(uint8_t val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.bdu = val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Blockdataupdate.[get]
  *
  * @param  val   change the values of bdu in reg CFG_REG_C.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_block_data_update_get(int8_t *val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  *val = reg.bdu;

  return ret;
}

/**
  * @brief  Magnetic set of data available.[get]
  *
  * @param  val   change the values of zyxda in reg STATUS_REG.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_mag_data_ready_get(uint8_t *val){

  lis2mdl_status_reg_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_STATUS_REG, (uint8_t *)&reg, 1);
  *val = reg.zyxda;

  return ret;
}

/**
  * @brief  Magnetic set of data overrun.[get]
  *
  * @param  val   change the values of zyxor in reg STATUS_REG.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_mag_data_ovr_get(uint8_t *val){

  lis2mdl_status_reg_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_STATUS_REG, (uint8_t *)&reg, 1);
  *val = reg.zyxor;

  return ret;
}

/**
  * @brief  Magnetic output value.[get]
  *
  * @param  buff  that stores data read
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_magnetic_raw_get(int16_t *val){

  uint8_t buff[6];
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_OUTX_L_REG, buff, 6);
  val[0] = (int16_t)buff[1];
  val[0] = (val[0] * 256) + (int16_t)buff[0];
  val[1] = (int16_t)buff[3];
  val[1] = (val[1] * 256) + (int16_t)buff[2];
  val[2] = (int16_t)buff[5];
  val[2] = (val[2] * 256) + (int16_t)buff[4];

  return ret;
}

/**
  * @brief  Temperature output value.[get]
  *
  * @param  buff  that stores data read
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_temperature_raw_get(int16_t *val){

  uint8_t buff[2];
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_TEMP_OUT_L_REG, buff, 2);
  *val = (int16_t)buff[1];
  *val = (*val * 256) + (int16_t)buff[0];

  return ret;
}

/**
  * @}
  *
  */

/**
  * @defgroup    LIS2MDL_common
  * @brief       This section group common useful functions
  * @{
  *
  */

/**
  * @brief  DeviceWhoamI.[get]
  *
  * @param  buff  that stores data read
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_device_id_get(uint8_t *buff)
{
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_WHO_AM_I, buff, 1);

  return ret;
}

/**
  * @brief  Software reset. Restore the default values in user registers.[set]
  *
  * @param  val   change the values of soft_rst in reg CFG_REG_A
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_reset_set(uint8_t val){

  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.soft_rst = val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Software reset. Restore the default values in user registers.[get]
  *
  * @param  val   change the values of soft_rst in reg CFG_REG_A.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_reset_get(uint8_t *val){

  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);
  *val = reg.soft_rst;

  return ret;
}

/**
  * @brief  Reboot memory content. Reload the calibration parameters.[set]
  *
  * @param  val   change the values of reboot in reg CFG_REG_A
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_boot_set(uint8_t val){

  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.reboot = val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Reboot memory content. Reload the calibration parameters.[get]
  *
  * @param  val   change the values of reboot in reg CFG_REG_A.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_boot_get(uint8_t *val){

  lis2mdl_cfg_reg_a_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_A, (uint8_t *)&reg, 1);
  *val = reg.reboot;

  return ret;
}

/**
  * @brief  Selftest.[set]
  *
  * @param  val   change the values of self_test in reg CFG_REG_C
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_self_test_set(uint8_t val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.self_test = val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Selftest.[get]
  *
  * @param  val   change the values of self_test in reg CFG_REG_C.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_self_test_get(uint8_t *val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  *val = reg.self_test;

  return ret;
}

/**
  * @brief  Big/Little Endian data selection.[set]
  *
  * @param  val   change the values of ble in reg CFG_REG_C
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_data_format_set(lis2mdl_ble_t val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.ble = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Big/Little Endian data selection.[get]
  *
  * @param  val   Get the values of ble in reg CFG_REG_C.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_data_format_get(lis2mdl_ble_t *val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  switch (reg.ble)
  {
    case LIS2MDL_LSB_AT_LOW_ADD:
      *val = LIS2MDL_LSB_AT_LOW_ADD;
      break;

    case LIS2MDL_MSB_AT_LOW_ADD:
      *val = LIS2MDL_MSB_AT_LOW_ADD;
      break;

    default:
      *val = LIS2MDL_LSB_AT_LOW_ADD;
      break;
  }

  return ret;
}

/**
  * @brief  Info about device status.[get]
  *
  * @param  val   registers STATUS_REG.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_status_get(lis2mdl_status_reg_t *val){

  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_STATUS_REG, (uint8_t *) val, 1);

  return ret;
}

/**
  * @}
  *
  */

/**
  * @defgroup    LIS2MDL_interrupts
  * @brief       This section group all the functions that manage interrupts
  * @{
  *
  */

/**
  * @brief  The interrupt block recognition checks data after/before the
  *         hard-iron correction to discover the interrupt.[set]
  *
  * @param  val   change the values of int_on_dataoff in reg CFG_REG_B
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_offset_int_conf_set(lis2mdl_int_on_dataoff_t val){
  lis2mdl_cfg_reg_b_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.int_on_dataoff = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  The interrupt block recognition checks data after/before the
  *         hard-iron correction to discover the interrupt.[get]
  *
  * @param  val   Get the values of int_on_dataoff in reg CFG_REG_B.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_offset_int_conf_get(lis2mdl_int_on_dataoff_t *val){

  lis2mdl_cfg_reg_b_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_B, (uint8_t *)&reg, 1);

  switch (reg.int_on_dataoff)
  {
    case LIS2MDL_CHECK_BEFORE:
      *val = LIS2MDL_CHECK_BEFORE;
      break;

    case LIS2MDL_CHECK_AFTER:
      *val = LIS2MDL_CHECK_AFTER;
      break;

    default:
      *val = LIS2MDL_CHECK_BEFORE;
      break;
  }

  return ret;
}

/**
  * @brief  Data-ready signal on INT_DRDY pin.[set]
  *
  * @param  val   change the values of drdy_on_pin in reg CFG_REG_C
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_drdy_on_pin_set(uint8_t val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  if (ret == 0){

    reg.drdy_on_pin = val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  }

  return ret;
}

/**
  * @brief  Data-ready signal on INT_DRDY pin.[get]
  *
  * @param  val   change the values of drdy_on_pin in reg CFG_REG_C.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_drdy_on_pin_get(uint8_t *val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  *val = reg.drdy_on_pin;

  return ret;
}

/**
  * @brief  Interrupt signal on INT_DRDY pin.[set]
  *
  * @param  val   change the values of int_on_pin in reg CFG_REG_C
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_int_on_pin_set(uint8_t val){
  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.int_on_pin = val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Interrupt signal on INT_DRDY pin.[get]
  *
  * @param  val   change the values of int_on_pin in reg CFG_REG_C.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_int_on_pin_get(uint8_t *val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  *val = reg.int_on_pin;

  return ret;
}

/**
  * @brief  Interrupt generator configuration register.[set]
  *
  * @param  val   registers INT_CRTL_REG.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_int_gen_conf_set(lis2mdl_int_crtl_reg_t *val){

  int32_t ret;

  ret = lis2mdl_write_reg(LIS2MDL_INT_CRTL_REG, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  Interrupt generator configuration register.[get]
  *
  * @param  val   registers INT_CRTL_REG.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_int_gen_conf_get(lis2mdl_int_crtl_reg_t *val){

  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_INT_CRTL_REG, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  Interrupt generator source register.[get]
  *
  * @param  val   registers INT_SOURCE_REG.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_int_gen_source_get(lis2mdl_int_source_reg_t *val)
{
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_INT_SOURCE_REG, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  User-defined threshold value for xl interrupt event on generator.
  *         Data format is the same of output data raw: two’s complement with
  *         1LSb = 1.5mG.[set]
  *
  * @param  buff  that contains data to write
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_int_gen_treshold_set(uint16_t val){

  uint8_t buff[2];
  int32_t ret;

  buff[1] = (uint8_t)(val / 256U);
  buff[0] = (uint8_t)(val - (buff[1] * 256U));
  ret = lis2mdl_write_reg(LIS2MDL_INT_THS_L_REG, buff, 2);

  return ret;
}

/**
  * @brief  User-defined threshold value for xl interrupt event on generator.
  *         Data format is the same of output data raw: two’s complement with
  *         1LSb = 1.5mG.[get]
  *
  * @param  buff  that stores data read
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_int_gen_treshold_get(uint16_t *val){

  uint8_t buff[2];
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_INT_THS_L_REG, buff, 2);
  *val = buff[1];
  *val = (*val * 256U) +  buff[0];

  return ret;
}

/**
  * @}
  *
  */

/**
  * @defgroup    LIS2MDL_serial_interface
  * @brief       This section group all the functions concerning serial
  *              interface management
  * @{
  *
  */

/**
  * @brief  SPI Serial Interface Mode selection.[set]
  *
  * @param  val      change the values of 4wspi in reg CFG_REG_C
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_spi_mode_set(lis2mdl_sim_t val){
  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg._4wspi = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  SPI Serial Interface Mode selection.[get]
  *
  * @param  val      Get the values of 4wspi in reg CFG_REG_C
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_spi_mode_get(lis2mdl_sim_t *val){

  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  switch (reg._4wspi)
  {
    case LIS2MDL_SPI_4_WIRE:
      *val = LIS2MDL_SPI_4_WIRE;
      break;

    case LIS2MDL_SPI_3_WIRE:
      *val = LIS2MDL_SPI_3_WIRE;
      break;

    default:
      *val = LIS2MDL_SPI_3_WIRE;
      break;
  }

  return ret;
}

/**
  * @brief  Enable/Disable I2C interface.[set]
  *
  * @param  val   change the values of i2c_dis in reg CFG_REG_C
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_i2c_interface_set(lis2mdl_i2c_dis_t val)
{
  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  if (ret == 0)
  {
    reg.i2c_dis = (uint8_t)val;
    ret = lis2mdl_write_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);
  }

  return ret;
}

/**
  * @brief  Enable/Disable I2C interface.[get]
  *
  * @param  val   Get the values of i2c_dis in reg CFG_REG_C.(ptr)
  * @retval       interface status.(MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2mdl_i2c_interface_get(lis2mdl_i2c_dis_t *val)
{
  lis2mdl_cfg_reg_c_t reg;
  int32_t ret;

  ret = lis2mdl_read_reg(LIS2MDL_CFG_REG_C, (uint8_t *)&reg, 1);

  switch (reg.i2c_dis)
  {
    case LIS2MDL_I2C_ENABLE:
      *val = LIS2MDL_I2C_ENABLE;
      break;

    case LIS2MDL_I2C_DISABLE:
      *val = LIS2MDL_I2C_DISABLE;
      break;

    default:
      *val = LIS2MDL_I2C_ENABLE;
      break;
  }

  return ret;
}

/**
  * @}
  *
  */

/*****************************END OF FILE****/


// ADD by Matteo Albi

#ifndef DEBUG_ON
  #define DEBUG_ON
#endif

/* Private variables ---------------------------------------------------------*/
static int16_t data_raw_magnetic[3];
static int16_t lis2mdl_data_raw_temperature;
static float magnetic_mG[3];
static float lis2mdl_temperature_degC;
static uint8_t mag_whoamI;
static bool mag_device_found;
// calibration data struct
static const man_fds_mag_t * mag_config;

/* Definition of my functions to get/set registers ------------------------------------------*/

void lis2mdl_print_reg(uint8_t reg_add){
  uint8_t data;
  int32_t ret;

  ret = lis2mdl_read_reg(reg_add, &data, 1);

  if (ret == 0)
  {
    printf("Register 0x%02x value: 0x%02x\r\n", reg_add, data);
  }
  else{
    printf("Unable to read register 0x%02x\r\n", reg_add);
  }

}


int32_t lis2mdl_magnetic_raw_get_my(int16_t *val){

  int32_t err, ret;
  uint8_t low_data, high_data;

  ret = 0;

  // X-axis
  err = lis2mdl_read_reg(LIS2MDL_OUTX_L_REG, &low_data, 1);
  ret |= err;
  err = lis2mdl_read_reg(LIS2MDL_OUTX_H_REG, &high_data, 1);
  ret |= err;
  val[0] = ((int16_t)high_data) * 256 + (int16_t)low_data;

  // Y-axis	
  err = lis2mdl_read_reg(LIS2MDL_OUTY_L_REG, &low_data, 1);
  ret |= err;
  err = lis2mdl_read_reg(LIS2MDL_OUTY_H_REG, &high_data, 1);
  ret |= err;
  val[1] = ((int16_t)high_data) * 256 + (int16_t)low_data;

  // Z-axis
  err = lis2mdl_read_reg(LIS2MDL_OUTZ_L_REG, &low_data, 1);
  ret |= err;
  err = lis2mdl_read_reg(LIS2MDL_OUTZ_H_REG, &high_data, 1);
  ret |= err;
  val[2] = ((int16_t)high_data) * 256 + (int16_t)low_data;

  return ret;
}


int32_t lis2mdl_temperature_raw_get_my(int16_t *val){
  int32_t err, ret;
  uint8_t low_data, high_data;

  ret = 0;
  err = lis2mdl_read_reg(LIS2MDL_TEMP_OUT_L_REG, &low_data, 1);
  ret |= err;
  err = lis2mdl_read_reg(LIS2MDL_TEMP_OUT_H_REG, &high_data, 1);
  ret |= err;
  *val = (int16_t)(high_data * 256) + (int16_t)low_data;

  return ret;

  return ret;
}

/* Definition of my functions to manage the sensor ------------------------------------------*/


void lis2mdl_init(void){
  int32_t err;

  /* Check device ID */
  err = lis2mdl_device_id_get(&mag_whoamI);
  
  if (err || mag_whoamI != LIS2MDL_ID){
    mag_device_found = false;
    printf("\r\nError in reading device id at LIS2MDL_I2C_ADD = 0x%02x\r\n", LIS2MDL_I2C_ADD);  
  }
  else{
    mag_device_found = true;
    printf("\r\nLIS2MDL device found, ID = 0x%02x\r\n", mag_whoamI);
    
    // CFG_REG_A
    // reset registers
    err = lis2mdl_reset_set(1);
    if(err) printf("Error in resetting the registers\r\n");

    // continuous mode
    err = lis2mdl_operating_mode_set(LIS2MDL_CONTINUOUS_MODE);
    if(err) printf("Error in setting operating mode\r\n");

    //enable temperature compensation
    err = lis2mdl_offset_temp_comp_set(1);
    if(err) printf("Error in enabling temperature compensation\r\n");

    // high resolution  
    err = lis2mdl_power_mode_set(LIS2MDL_HIGH_RESOLUTION);
    if(err) printf("Error in setting resolution\r\n");

    // set strem frequency
    err = lis2mdl_data_rate_set(LIS2MDL_ODR_100Hz);
    if(err) printf("Error in setting strem frequency\r\n");

    // CFG_REG_C
    // enable block data update
    err = lis2mdl_block_data_update_set(1);
    if(err) printf("Error in enabling block data update\r\n");

    //disable self test
    err = lis2mdl_self_test_set(0);
    if(err) printf("Error in disabling self test\r\n");

#ifdef DEBUG_ON
    // Print set registers
    //lis2mdl_print_reg(LIS2MDL_CFG_REG_A);
    //lis2mdl_print_reg(LIS2MDL_CFG_REG_C);
#endif

    mag_config = man_fds_get_mag_config();

    if(!err) printf("Configuration of LIS2MDL successful\r\n");

  }

}


int32_t lis2mdl_get_mag(float *buf){
  int32_t err = 0;

  if(! mag_device_found){
    err = 1;
  }
  else{
    // read if new data is available
    uint8_t data_ready;
    err = lis2mdl_mag_data_ready_get(&data_ready);

    if(data_ready && !err){
      // Green led on to signal starting read
      //bsp_board_led_on(GREEN_LED);

      // Read XL samples
      err = lis2mdl_magnetic_raw_get_my(data_raw_magnetic);

      // convert to mgauss
      if(!err){
        magnetic_mG[0] = lis2mdl_from_lsb_to_mgauss(data_raw_magnetic[0]);
        magnetic_mG[1] = lis2mdl_from_lsb_to_mgauss(data_raw_magnetic[1]);
        magnetic_mG[2] = lis2mdl_from_lsb_to_mgauss(data_raw_magnetic[2]);
      }
      
      //bsp_board_led_off(GREEN_LED);
    }
    
    if(!err && buf != NULL){
      buf[0] = magnetic_mG[0];
      buf[1] = magnetic_mG[1]; 
      buf[2] = magnetic_mG[2];
    }

  }

  return err;
}


int32_t lis2mdl_get_mag_calibrated(float *buf){
  int32_t err = lis2mdl_get_mag(NULL);

#ifdef DEBUG_ON
  //printf("raw_m:\t%3.2f\t%3.2f\t%3.2f", magnetic_mG[0], magnetic_mG[1], magnetic_mG[2]);
#endif
  
  if(!err){      
    // compensate hard_iron and soft_iron
    buf[0] =  (magnetic_mG[0] - mag_config->hard_iron[0]) * mag_config->soft_iron[0] + 
              (magnetic_mG[1] - mag_config->hard_iron[1]) * mag_config->soft_iron[3] + 
              (magnetic_mG[2] - mag_config->hard_iron[2]) * mag_config->soft_iron[6];

    buf[1] =  (magnetic_mG[0] - mag_config->hard_iron[0]) * mag_config->soft_iron[1] + 
              (magnetic_mG[1] - mag_config->hard_iron[1]) * mag_config->soft_iron[4] + 
              (magnetic_mG[2] - mag_config->hard_iron[2]) * mag_config->soft_iron[7];

    buf[2] =  (magnetic_mG[0] - mag_config->hard_iron[0]) * mag_config->soft_iron[2] + 
              (magnetic_mG[1] - mag_config->hard_iron[1]) * mag_config->soft_iron[5] + 
              (magnetic_mG[2] - mag_config->hard_iron[2]) * mag_config->soft_iron[8];

  }

  return err;
}


void lis2mdl_print_mag(void){
  float tmp[3];

  if(lis2mdl_get_mag_calibrated(tmp)) printf("Error during data reading");
  else{
    // Print to UART most recent data  
    printf("mag:\t%4.2f\t%4.2f\t%4.2f\r\n",
                      tmp[0], 
                      tmp[1], 
                      tmp[2]);
  }

}


int32_t lis2mdl_get_temp(float *val){
  int32_t err = 0;

  if(! mag_device_found){
    err = 1;
  }
  else{
    // Read temperature data
    err = lis2mdl_temperature_raw_get_my(&lis2mdl_data_raw_temperature);
    if(!err) {
      // Convert raw data in float
      lis2mdl_temperature_degC = lis2mdl_from_lsb_to_celsius(lis2mdl_data_raw_temperature);
    }
    if(!err && val != NULL) *val = lis2mdl_temperature_degC;
  }

  return err;
}


void lis2mdl_print_temp(void){
  int32_t err = lis2mdl_get_temp(NULL);

  if(err) printf("Error during data reading");
  else{
    // Print to UART most recent data
    printf("tmp mag:\t%6.2f\r\n", lis2mdl_temperature_degC);
  }  
}