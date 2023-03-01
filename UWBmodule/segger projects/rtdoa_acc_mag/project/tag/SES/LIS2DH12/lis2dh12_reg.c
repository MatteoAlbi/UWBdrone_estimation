/**
  ******************************************************************************
  * @file    lis2dh12_reg.c
  * @author  Sensors Software Solution Team
  * @brief   LIS2DH12 driver file
  ******************************************************************************
  * @attention
  *
  * <h2><center>&copy; Copyright (c) 2021 STMicroelectronics.
  * All rights reserved.</center></h2>
  *
  * This software component is licensed by ST under BSD 3-Clause license,
  * the "License"; You may not use this file except in compliance with the
  * License. You may obtain a copy of the License at:
  *                        opensource.org/licenses/BSD-3-Clause
  *
  ******************************************************************************
  */

#include "lis2dh12_reg.h"

/**
  * @defgroup  LIS2DH12
  * @brief     This file provides a set of functions needed to drive the
  *            lis2dh12 enanced inertial module.
  * @{
  *
  */

/**
  * @defgroup  LIS2DH12_Interfaces_Functions
  * @brief     This section provide a set of functions used to read and
  *            write a generic register of the device.
  *            MANDATORY: return 0 -> no Error.
  * @{
  *
  */

/**
  * @brief  Read generic device register
  *
  * @param  ctx   read / write interface definitions(ptr)
  * @param  reg   register to read
  * @param  data  pointer to buffer that store the data read(ptr)
  * @param  len   number of consecutive register to read
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t __weak lis2dh12_read_reg(stmdev_ctx_t *ctx, uint8_t reg,
                                 uint8_t *data,
                                 uint16_t len)
{
  int32_t ret;

  ret = ctx->read_reg(ctx->handle, reg, data, len);

  return ret;
}

/**
  * @brief  Write generic device register
  *
  * @param  ctx   read / write interface definitions(ptr)
  * @param  reg   register to write
  * @param  data  pointer to data to write in register reg(ptr)
  * @param  len   number of consecutive register to write
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t __weak lis2dh12_write_reg(stmdev_ctx_t *ctx, uint8_t reg,
                                  uint8_t *data,
                                  uint16_t len)
{
  int32_t ret;

  ret = ctx->write_reg(ctx->handle, reg, data, len);

  return ret;
}

/**
  * @}
  *
  */

/**
  * @defgroup    LIS2DH12_Sensitivity
  * @brief       These functions convert raw-data into engineering units.
  * @{
  *
  */

float_t lis2dh12_from_fs2_hr_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 16.0f) * 1.0f;
}

float_t lis2dh12_from_fs4_hr_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 16.0f) *  2.0f;
}

float_t lis2dh12_from_fs8_hr_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 16.0f) * 4.0f;
}

float_t lis2dh12_from_fs16_hr_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 16.0f) * 12.0f;
}

float_t lis2dh12_from_lsb_hr_to_celsius(int16_t lsb)
{
  return (((float_t)lsb / 64.0f) / 4.0f) + 25.0f;
}

float_t lis2dh12_from_fs2_nm_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 64.0f) *  4.0f;
}

float_t lis2dh12_from_fs4_nm_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 64.0f) *  8.0f;
}

float_t lis2dh12_from_fs8_nm_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 64.0f) * 16.0f;
}

float_t lis2dh12_from_fs16_nm_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 64.0f) * 48.0f;
}

float_t lis2dh12_from_lsb_nm_to_celsius(int16_t lsb)
{
  return (((float_t)lsb / 64.0f) / 4.0f) + 25.0f;
}

float_t lis2dh12_from_fs2_lp_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 256.0f) * 16.0f;
}

float_t lis2dh12_from_fs4_lp_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 256.0f) * 32.0f;
}

float_t lis2dh12_from_fs8_lp_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 256.0f) * 64.0f;
}

float_t lis2dh12_from_fs16_lp_to_mg(int16_t lsb)
{
  return ((float_t)lsb / 256.0f) * 192.0f;
}

float_t lis2dh12_from_lsb_lp_to_celsius(int16_t lsb)
{
  return (((float_t)lsb / 256.0f) * 1.0f) + 25.0f;
}

/**
  * @}
  *
  */

/**
  * @defgroup  LIS2DH12_Data_generation
  * @brief     This section group all the functions concerning data generation.
  * @{
  *
  */

/**
  * @brief  Temperature status register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  buff     buffer that stores data read
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_temp_status_reg_get(stmdev_ctx_t *ctx, uint8_t *buff)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_STATUS_REG_AUX, buff, 1);

  return ret;
}
/**
  * @brief  Temperature data available.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tda in reg STATUS_REG_AUX
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_temp_data_ready_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_status_reg_aux_t status_reg_aux;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_STATUS_REG_AUX,
                          (uint8_t *)&status_reg_aux, 1);
  *val = status_reg_aux.tda;

  return ret;
}
/**
  * @brief  Temperature data overrun.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tor in reg STATUS_REG_AUX
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_temp_data_ovr_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_status_reg_aux_t status_reg_aux;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_STATUS_REG_AUX,
                          (uint8_t *)&status_reg_aux, 1);
  *val = status_reg_aux.tor;

  return ret;
}
/**
  * @brief  Temperature output value.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  buff     buffer that stores data read
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_temperature_raw_get(stmdev_ctx_t *ctx, int16_t *val)
{
  uint8_t buff[2];
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_OUT_TEMP_L, buff, 2);
  *val = (int16_t)buff[1];
  *val = (*val * 256) + (int16_t)buff[0];

  return ret;
}
/**
  * @brief  Temperature sensor enable.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of temp_en in reg TEMP_CFG_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_temperature_meas_set(stmdev_ctx_t *ctx,
                                      lis2dh12_temp_en_t val)
{
  lis2dh12_temp_cfg_reg_t temp_cfg_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_TEMP_CFG_REG, (uint8_t *)&temp_cfg_reg, 1);

  if (ret == 0)
  {
    // reset register (bit 0-5 aren't used)
    memset(&temp_cfg_reg, 0x00, sizeof(lis2dh12_temp_cfg_reg_t));
    // set TEMP_EN1
    temp_cfg_reg.temp_en = (uint8_t) val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_TEMP_CFG_REG, (uint8_t *)&temp_cfg_reg, 1);
  }

  return ret;
}

/**
  * @brief  Temperature sensor enable.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      get the values of temp_en in reg TEMP_CFG_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_temperature_meas_get(stmdev_ctx_t *ctx,
                                      lis2dh12_temp_en_t *val)
{
  lis2dh12_temp_cfg_reg_t temp_cfg_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_TEMP_CFG_REG,
                          (uint8_t *)&temp_cfg_reg, 1);

  switch (temp_cfg_reg.temp_en)
  {
    case LIS2DH12_TEMP_DISABLE:
      *val = LIS2DH12_TEMP_DISABLE;
      break;

    case LIS2DH12_TEMP_ENABLE:
      *val = LIS2DH12_TEMP_ENABLE;
      break;

    default:
      *val = LIS2DH12_TEMP_DISABLE;
      break;
  }

  return ret;
}

/**
  * @brief  Operating mode selection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of lpen in reg CTRL_REG1
  *                  and HR in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_operating_mode_set(stmdev_ctx_t *ctx, lis2dh12_op_md_t val)
{
  lis2dh12_ctrl_reg1_t ctrl_reg1;
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG1, (uint8_t *)&ctrl_reg1, 1);

  if (ret == 0)
  {
    ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);
  }

  if (ret == 0)
  {
    if (val == LIS2DH12_HR_12bit)
    {
      ctrl_reg1.lpen = 0;
      ctrl_reg4.hr   = 1;
    }

    if (val == LIS2DH12_NM_10bit)
    {
      ctrl_reg1.lpen = 0;
      ctrl_reg4.hr   = 0;
    }

    if (val == LIS2DH12_LP_8bit)
    {
      ctrl_reg1.lpen = 1;
      ctrl_reg4.hr   = 0;
    }

    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG1, (uint8_t *)&ctrl_reg1, 1);
  }

  if (ret == 0)
  {
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);
  }

  return ret;
}

/**
  * @brief  Operating mode selection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of lpen in reg CTRL_REG1
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_operating_mode_get(stmdev_ctx_t *ctx, lis2dh12_op_md_t *val)
{
  lis2dh12_ctrl_reg1_t ctrl_reg1;
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG1, (uint8_t *)&ctrl_reg1, 1);

  if (ret == 0)
  {
    ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);

    if (ctrl_reg1.lpen == PROPERTY_ENABLE)
    {
      *val = LIS2DH12_LP_8bit;
    }

    else if (ctrl_reg4.hr == PROPERTY_ENABLE)
    {
      *val = LIS2DH12_HR_12bit;
    }

    else
    {
      *val = LIS2DH12_NM_10bit;
    }
  }

  return ret;
}

/**
  * @brief  Output data rate selection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of odr in reg CTRL_REG1
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_data_rate_set(stmdev_ctx_t *ctx, lis2dh12_odr_t val)
{
  lis2dh12_ctrl_reg1_t ctrl_reg1;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG1, (uint8_t *)&ctrl_reg1, 1);

  if (ret == 0)
  {
    ctrl_reg1.odr = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG1, (uint8_t *)&ctrl_reg1, 1);
  }

  return ret;
}

/**
  * @brief  Output data rate selection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      get the values of odr in reg CTRL_REG1
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_data_rate_get(stmdev_ctx_t *ctx, lis2dh12_odr_t *val)
{
  lis2dh12_ctrl_reg1_t ctrl_reg1;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG1, (uint8_t *)&ctrl_reg1, 1);

  switch (ctrl_reg1.odr)
  {
    case LIS2DH12_POWER_DOWN:
      *val = LIS2DH12_POWER_DOWN;
      break;

    case LIS2DH12_ODR_1Hz:
      *val = LIS2DH12_ODR_1Hz;
      break;

    case LIS2DH12_ODR_10Hz:
      *val = LIS2DH12_ODR_10Hz;
      break;

    case LIS2DH12_ODR_25Hz:
      *val = LIS2DH12_ODR_25Hz;
      break;

    case LIS2DH12_ODR_50Hz:
      *val = LIS2DH12_ODR_50Hz;
      break;

    case LIS2DH12_ODR_100Hz:
      *val = LIS2DH12_ODR_100Hz;
      break;

    case LIS2DH12_ODR_200Hz:
      *val = LIS2DH12_ODR_200Hz;
      break;

    case LIS2DH12_ODR_400Hz:
      *val = LIS2DH12_ODR_400Hz;
      break;

    case LIS2DH12_ODR_1kHz620_LP:
      *val = LIS2DH12_ODR_1kHz620_LP;
      break;

    case LIS2DH12_ODR_5kHz376_LP_1kHz344_NM_HP:
      *val = LIS2DH12_ODR_5kHz376_LP_1kHz344_NM_HP;
      break;

    default:
      *val = LIS2DH12_POWER_DOWN;
      break;
  }

  return ret;
}

/**
  * @brief   High pass data from internal filter sent to output register
  *          and FIFO.
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fds in reg CTRL_REG2
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_high_pass_on_outputs_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_ctrl_reg2_t ctrl_reg2;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG2, (uint8_t *)&ctrl_reg2, 1);

  if (ret == 0)
  {
    ctrl_reg2.fds = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG2, (uint8_t *)&ctrl_reg2, 1);
  }

  return ret;
}

/**
  * @brief   High pass data from internal filter sent to output register
  *          and FIFO.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fds in reg CTRL_REG2
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_high_pass_on_outputs_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_ctrl_reg2_t ctrl_reg2;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG2, (uint8_t *)&ctrl_reg2, 1);
  *val = (uint8_t)ctrl_reg2.fds;

  return ret;
}

/**
  * @brief   High-pass filter cutoff frequency selection.[set]
  *
  * HPCF[2:1]\ft @1Hz    @10Hz  @25Hz  @50Hz @100Hz @200Hz @400Hz @1kHz6 ft@5kHz
  * AGGRESSIVE   0.02Hz  0.2Hz  0.5Hz  1Hz   2Hz    4Hz    8Hz    32Hz   100Hz
  * STRONG       0.008Hz 0.08Hz 0.2Hz  0.5Hz 1Hz    2Hz    4Hz    16Hz   50Hz
  * MEDIUM       0.004Hz 0.04Hz 0.1Hz  0.2Hz 0.5Hz  1Hz    2Hz    8Hz    25Hz
  * LIGHT        0.002Hz 0.02Hz 0.05Hz 0.1Hz 0.2Hz  0.5Hz  1Hz    4Hz    12Hz
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of hpcf in reg CTRL_REG2
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_high_pass_bandwidth_set(stmdev_ctx_t *ctx, lis2dh12_hpcf_t val)
{
  lis2dh12_ctrl_reg2_t ctrl_reg2;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG2, (uint8_t *)&ctrl_reg2, 1);

  if (ret == 0)
  {
    ctrl_reg2.hpcf = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG2, (uint8_t *)&ctrl_reg2, 1);
  }

  return ret;
}

/**
  * @brief   High-pass filter cutoff frequency selection.[get]
  *
  * HPCF[2:1]\ft @1Hz    @10Hz  @25Hz  @50Hz @100Hz @200Hz @400Hz @1kHz6 ft@5kHz
  * AGGRESSIVE   0.02Hz  0.2Hz  0.5Hz  1Hz   2Hz    4Hz    8Hz    32Hz   100Hz
  * STRONG       0.008Hz 0.08Hz 0.2Hz  0.5Hz 1Hz    2Hz    4Hz    16Hz   50Hz
  * MEDIUM       0.004Hz 0.04Hz 0.1Hz  0.2Hz 0.5Hz  1Hz    2Hz    8Hz    25Hz
  * LIGHT        0.002Hz 0.02Hz 0.05Hz 0.1Hz 0.2Hz  0.5Hz  1Hz    4Hz    12Hz
  *
  * @param  ctx      read / write interface definitions
  * @param  val      get the values of hpcf in reg CTRL_REG2
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_high_pass_bandwidth_get(stmdev_ctx_t *ctx,
                                         lis2dh12_hpcf_t *val)
{
  lis2dh12_ctrl_reg2_t ctrl_reg2;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG2,
                          (uint8_t *)&ctrl_reg2, 1);

  switch (ctrl_reg2.hpcf)
  {
    case LIS2DH12_AGGRESSIVE:
      *val = LIS2DH12_AGGRESSIVE;
      break;

    case LIS2DH12_STRONG:
      *val = LIS2DH12_STRONG;
      break;

    case LIS2DH12_MEDIUM:
      *val = LIS2DH12_MEDIUM;
      break;

    case LIS2DH12_LIGHT:
      *val = LIS2DH12_LIGHT;
      break;

    default:
      *val = LIS2DH12_LIGHT;
      break;
  }

  return ret;
}

/**
  * @brief  High-pass filter mode selection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of hpm in reg CTRL_REG2
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_high_pass_mode_set(stmdev_ctx_t *ctx,
                                    lis2dh12_hpm_t val)
{
  lis2dh12_ctrl_reg2_t ctrl_reg2;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG2,
                          (uint8_t *)&ctrl_reg2, 1);

  if (ret == 0)
  {
    ctrl_reg2.hpm = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG2, (uint8_t *)&ctrl_reg2, 1);
  }

  return ret;
}

/**
  * @brief  High-pass filter mode selection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      get the values of hpm in reg CTRL_REG2
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_high_pass_mode_get(stmdev_ctx_t *ctx,
                                    lis2dh12_hpm_t *val)
{
  lis2dh12_ctrl_reg2_t ctrl_reg2;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG2,
                          (uint8_t *)&ctrl_reg2, 1);

  switch (ctrl_reg2.hpm)
  {
    case LIS2DH12_NORMAL_WITH_RST:
      *val = LIS2DH12_NORMAL_WITH_RST;
      break;

    case LIS2DH12_REFERENCE_MODE:
      *val = LIS2DH12_REFERENCE_MODE;
      break;

    case LIS2DH12_NORMAL:
      *val = LIS2DH12_NORMAL;
      break;

    case LIS2DH12_AUTORST_ON_INT:
      *val = LIS2DH12_AUTORST_ON_INT;
      break;

    default:
      *val = LIS2DH12_NORMAL_WITH_RST;
      break;
  }

  return ret;
}

/**
  * @brief  Full-scale configuration.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fs in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_full_scale_set(stmdev_ctx_t *ctx, lis2dh12_fs_t val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);

  if (ret == 0)
  {
    ctrl_reg4.fs = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);
  }

  return ret;
}

/**
  * @brief  Full-scale configuration.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      get the values of fs in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_full_scale_get(stmdev_ctx_t *ctx, lis2dh12_fs_t *val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4,
                          (uint8_t *)&ctrl_reg4, 1);

  switch (ctrl_reg4.fs)
  {
    case LIS2DH12_2g:
      *val = LIS2DH12_2g;
      break;

    case LIS2DH12_4g:
      *val = LIS2DH12_4g;
      break;

    case LIS2DH12_8g:
      *val = LIS2DH12_8g;
      break;

    case LIS2DH12_16g:
      *val = LIS2DH12_16g;
      break;

    default:
      *val = LIS2DH12_2g;
      break;
  }

  return ret;
}

/**
  * @brief  Block Data Update.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of bdu in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_block_data_update_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;\

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);

  if (ret == 0)
  {
    ctrl_reg4.bdu = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);
  }

  return ret;
}

/**
  * @brief  Block Data Update.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of bdu in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_block_data_update_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);
  *val = (uint8_t)ctrl_reg4.bdu;

  return ret;
}

/**
  * @brief  Reference value for interrupt generation.[set]
  *         LSB = ~16@2g / ~31@4g / ~63@8g / ~127@16g
  *
  * @param  ctx      read / write interface definitions
  * @param  buff     buffer that contains data to write
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_filter_reference_set(stmdev_ctx_t *ctx, uint8_t *buff)
{
  int32_t ret;

  ret = lis2dh12_write_reg(ctx, LIS2DH12_REFERENCE, buff, 1);

  return ret;
}

/**
  * @brief  Reference value for interrupt generation.[get]
  *         LSB = ~16@2g / ~31@4g / ~63@8g / ~127@16g
  *
  * @param  ctx      read / write interface definitions
  * @param  buff     buffer that stores data read
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_filter_reference_get(stmdev_ctx_t *ctx, uint8_t *buff)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_REFERENCE, buff, 1);

  return ret;
}
/**
  * @brief  Acceleration set of data available.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of zyxda in reg STATUS_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_xl_data_ready_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_status_reg_t status_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_STATUS_REG, (uint8_t *)&status_reg, 1);
  *val = status_reg.zyxda;

  return ret;
}
/**
  * @brief  Acceleration set of data overrun.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of zyxor in reg STATUS_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_xl_data_ovr_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_status_reg_t status_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_STATUS_REG, (uint8_t *)&status_reg, 1);
  *val = status_reg.zyxor;

  return ret;
}

/**
  * @brief  Acceleration output value.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  buff     buffer that stores data read
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_acceleration_raw_get(stmdev_ctx_t *ctx, int16_t *val)
{

  int32_t ret;
  uint8_t buff[6];

  ret = lis2dh12_read_reg(ctx, LIS2DH12_OUT_X_L, buff, 6);

  val[0] = (int16_t)buff[1];
  val[0] = (val[0] * 256) + (int16_t)buff[0];
  val[1] = (int16_t)buff[3];
  val[1] = (val[1] * 256) + (int16_t)buff[2];
  val[2] = (int16_t)buff[5];
  val[2] = (val[2] * 256) + (int16_t)buff[4];

  return ret;
}


/**
  * @}
  *
  */

/**
  * @defgroup  LIS2DH12_Common
  * @brief     This section group common useful functions
  * @{
  *
  */

/**
  * @brief  DeviceWhoamI .[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  buff     buffer that stores data read
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_device_id_get(stmdev_ctx_t *ctx, uint8_t *buff)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_WHO_AM_I, buff, 1);

  return ret;
}
/**
  * @brief  Self Test.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of st in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_self_test_set(stmdev_ctx_t *ctx, lis2dh12_st_t val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);

  if (ret == 0)
  {
    ctrl_reg4.st = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);
  }

  return ret;
}

/**
  * @brief  Self Test.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of st in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_self_test_get(stmdev_ctx_t *ctx, lis2dh12_st_t *val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4,
                          (uint8_t *)&ctrl_reg4, 1);

  switch (ctrl_reg4.st)
  {
    case LIS2DH12_ST_DISABLE:
      *val = LIS2DH12_ST_DISABLE;
      break;

    case LIS2DH12_ST_POSITIVE:
      *val = LIS2DH12_ST_POSITIVE;
      break;

    case LIS2DH12_ST_NEGATIVE:
      *val = LIS2DH12_ST_NEGATIVE;
      break;

    default:
      *val = LIS2DH12_ST_DISABLE;
      break;
  }

  return ret;
}

/**
  * @brief  Big/Little Endian data selection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of ble in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_data_format_set(stmdev_ctx_t *ctx,
                                 lis2dh12_ble_t val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4,
                          (uint8_t *)&ctrl_reg4, 1);

  if (ret == 0)
  {
    ctrl_reg4.ble = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);
  }

  return ret;
}

/**
  * @brief  Big/Little Endian data selection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      get the values of ble in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_data_format_get(stmdev_ctx_t *ctx,
                                 lis2dh12_ble_t *val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4,
                          (uint8_t *)&ctrl_reg4, 1);

  switch (ctrl_reg4.ble)
  {
    case LIS2DH12_LSB_AT_LOW_ADD:
      *val = LIS2DH12_LSB_AT_LOW_ADD;
      break;

    case LIS2DH12_MSB_AT_LOW_ADD:
      *val = LIS2DH12_MSB_AT_LOW_ADD;
      break;

    default:
      *val = LIS2DH12_LSB_AT_LOW_ADD;
      break;
  }

  return ret;
}

/**
  * @brief  Reboot memory content. Reload the calibration parameters.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of boot in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_boot_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);

  if (ret == 0)
  {
    ctrl_reg5.boot = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);
  }

  return ret;
}

/**
  * @brief  Reboot memory content. Reload the calibration parameters.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of boot in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_boot_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5,
                          (uint8_t *)&ctrl_reg5, 1);
  *val = (uint8_t)ctrl_reg5.boot;

  return ret;
}

/**
  * @brief  Info about device status.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      register STATUS_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_status_get(stmdev_ctx_t *ctx,
                            lis2dh12_status_reg_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_STATUS_REG, (uint8_t *) val, 1);

  return ret;
}
/**
  * @}
  *
  */

/**
  * @defgroup   LIS2DH12_Interrupts_generator_1
  * @brief      This section group all the functions that manage the first
  *             interrupts generator
  * @{
  *
  */

/**
  * @brief  Interrupt generator 1 configuration register.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      register INT1_CFG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_gen_conf_set(stmdev_ctx_t *ctx,
                                   lis2dh12_int1_cfg_t *val)
{
  int32_t ret;

  ret = lis2dh12_write_reg(ctx, LIS2DH12_INT1_CFG, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  Interrupt generator 1 configuration register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      register INT1_CFG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_gen_conf_get(stmdev_ctx_t *ctx,
                                   lis2dh12_int1_cfg_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT1_CFG, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  Interrupt generator 1 source register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Registers INT1_SRC
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_gen_source_get(stmdev_ctx_t *ctx,
                                     lis2dh12_int1_src_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT1_SRC, (uint8_t *) val, 1);

  return ret;
}
/**
  * @brief  User-defined threshold value for xl interrupt event on
  *         generator 1.[set]
  *         LSb = 16mg@2g / 32mg@4g / 62mg@8g / 186mg@16g
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of ths in reg INT1_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_gen_threshold_set(stmdev_ctx_t *ctx,
                                        uint8_t val)
{
  lis2dh12_int1_ths_t int1_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT1_THS, (uint8_t *)&int1_ths, 1);

  if (ret == 0)
  {
    int1_ths.ths = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_INT1_THS, (uint8_t *)&int1_ths, 1);
  }

  return ret;
}

/**
  * @brief  User-defined threshold value for xl interrupt event on
  *         generator 1.[get]
  *         LSb = 16mg@2g / 32mg@4g / 62mg@8g / 186mg@16g
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of ths in reg INT1_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_gen_threshold_get(stmdev_ctx_t *ctx,
                                        uint8_t *val)
{
  lis2dh12_int1_ths_t int1_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT1_THS, (uint8_t *)&int1_ths, 1);
  *val = (uint8_t)int1_ths.ths;

  return ret;
}

/**
  * @brief  The minimum duration (LSb = 1/ODR) of the Interrupt 1 event to be
  *         recognized.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of d in reg INT1_DURATION
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_gen_duration_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_int1_duration_t int1_duration;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT1_DURATION,
                          (uint8_t *)&int1_duration, 1);

  if (ret == 0)
  {
    int1_duration.d = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_INT1_DURATION, (uint8_t *)&int1_duration, 1);
  }

  return ret;
}

/**
  * @brief  The minimum duration (LSb = 1/ODR) of the Interrupt 1 event to be
  *         recognized.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of d in reg INT1_DURATION
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_gen_duration_get(stmdev_ctx_t *ctx,
                                       uint8_t *val)
{
  lis2dh12_int1_duration_t int1_duration;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT1_DURATION,
                          (uint8_t *)&int1_duration, 1);
  *val = (uint8_t)int1_duration.d;

  return ret;
}

/**
  * @}
  *
  */

/**
  * @defgroup   LIS2DH12_Interrupts_generator_2
  * @brief      This section group all the functions that manage the second
  *             interrupts generator
  * @{
  *
  */

/**
  * @brief  Interrupt generator 2 configuration register.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers INT2_CFG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_gen_conf_set(stmdev_ctx_t *ctx,
                                   lis2dh12_int2_cfg_t *val)
{
  int32_t ret;

  ret = lis2dh12_write_reg(ctx, LIS2DH12_INT2_CFG, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  Interrupt generator 2 configuration register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers INT2_CFG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_gen_conf_get(stmdev_ctx_t *ctx,
                                   lis2dh12_int2_cfg_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT2_CFG, (uint8_t *) val, 1);

  return ret;
}
/**
  * @brief  Interrupt generator 2 source register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers INT2_SRC
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_gen_source_get(stmdev_ctx_t *ctx,
                                     lis2dh12_int2_src_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT2_SRC, (uint8_t *) val, 1);

  return ret;
}
/**
  * @brief   User-defined threshold value for xl interrupt event on
  *          generator 2.[set]
  *          LSb = 16mg@2g / 32mg@4g / 62mg@8g / 186mg@16g
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of ths in reg INT2_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_gen_threshold_set(stmdev_ctx_t *ctx,
                                        uint8_t val)
{
  lis2dh12_int2_ths_t int2_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT2_THS, (uint8_t *)&int2_ths, 1);

  if (ret == 0)
  {
    int2_ths.ths = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_INT2_THS, (uint8_t *)&int2_ths, 1);
  }

  return ret;
}

/**
  * @brief  User-defined threshold value for xl interrupt event on
  *         generator 2.[get]
  *         LSb = 16mg@2g / 32mg@4g / 62mg@8g / 186mg@16g
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of ths in reg INT2_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_gen_threshold_get(stmdev_ctx_t *ctx,
                                        uint8_t *val)
{
  lis2dh12_int2_ths_t int2_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT2_THS, (uint8_t *)&int2_ths, 1);
  *val = (uint8_t)int2_ths.ths;

  return ret;
}

/**
  * @brief  The minimum duration (LSb = 1/ODR) of the Interrupt 1 event to be
  *         recognized .[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of d in reg INT2_DURATION
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_gen_duration_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_int2_duration_t int2_duration;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT2_DURATION,
                          (uint8_t *)&int2_duration, 1);

  if (ret == 0)
  {
    int2_duration.d = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_INT2_DURATION, (uint8_t *)&int2_duration, 1);
  }

  return ret;
}

/**
  * @brief  The minimum duration (LSb = 1/ODR) of the Interrupt 1 event to be
  *         recognized.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of d in reg INT2_DURATION
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_gen_duration_get(stmdev_ctx_t *ctx,
                                       uint8_t *val)
{
  lis2dh12_int2_duration_t int2_duration;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_INT2_DURATION,
                          (uint8_t *)&int2_duration, 1);
  *val = (uint8_t)int2_duration.d;

  return ret;
}

/**
  * @}
  *
  */

/**
  * @defgroup  LIS2DH12_Interrupt_pins
  * @brief     This section group all the functions that manage interrupt pins
  * @{
  *
  */

/**
  * @brief  High-pass filter on interrupts/tap generator.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of hp in reg CTRL_REG2
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_high_pass_int_conf_set(stmdev_ctx_t *ctx,
                                        lis2dh12_hp_t val)
{
  lis2dh12_ctrl_reg2_t ctrl_reg2;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG2,
                          (uint8_t *)&ctrl_reg2, 1);

  if (ret == 0)
  {
    ctrl_reg2.hp = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG2, (uint8_t *)&ctrl_reg2, 1);
  }

  return ret;
}

/**
  * @brief  High-pass filter on interrupts/tap generator.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of hp in reg CTRL_REG2
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_high_pass_int_conf_get(stmdev_ctx_t *ctx,
                                        lis2dh12_hp_t *val)
{
  lis2dh12_ctrl_reg2_t ctrl_reg2;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG2,
                          (uint8_t *)&ctrl_reg2, 1);

  switch (ctrl_reg2.hp)
  {
    case LIS2DH12_DISC_FROM_INT_GENERATOR:
      *val = LIS2DH12_DISC_FROM_INT_GENERATOR;
      break;

    case LIS2DH12_ON_INT1_GEN:
      *val = LIS2DH12_ON_INT1_GEN;
      break;

    case LIS2DH12_ON_INT2_GEN:
      *val = LIS2DH12_ON_INT2_GEN;
      break;

    case LIS2DH12_ON_TAP_GEN:
      *val = LIS2DH12_ON_TAP_GEN;
      break;

    case LIS2DH12_ON_INT1_INT2_GEN:
      *val = LIS2DH12_ON_INT1_INT2_GEN;
      break;

    case LIS2DH12_ON_INT1_TAP_GEN:
      *val = LIS2DH12_ON_INT1_TAP_GEN;
      break;

    case LIS2DH12_ON_INT2_TAP_GEN:
      *val = LIS2DH12_ON_INT2_TAP_GEN;
      break;

    case LIS2DH12_ON_INT1_INT2_TAP_GEN:
      *val = LIS2DH12_ON_INT1_INT2_TAP_GEN;
      break;

    default:
      *val = LIS2DH12_DISC_FROM_INT_GENERATOR;
      break;
  }

  return ret;
}

/**
  * @brief  Int1 pin routing configuration register.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers CTRL_REG3
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_pin_int1_config_set(stmdev_ctx_t *ctx,
                                     lis2dh12_ctrl_reg3_t *val)
{
  int32_t ret;

  ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG3, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  Int1 pin routing configuration register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers CTRL_REG3
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_pin_int1_config_get(stmdev_ctx_t *ctx,
                                     lis2dh12_ctrl_reg3_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG3, (uint8_t *) val, 1);

  return ret;
}
/**
  * @brief  int2_pin_detect_4d: [set]  4D enable: 4D detection is enabled
  *                                    on INT2 pin when 6D bit on
  *                                    INT2_CFG (34h) is set to 1.
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of d4d_int2 in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_pin_detect_4d_set(stmdev_ctx_t *ctx,
                                        uint8_t val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5,
                          (uint8_t *)&ctrl_reg5, 1);

  if (ret == 0)
  {
    ctrl_reg5.d4d_int2 = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);
  }

  return ret;
}

/**
  * @brief  4D enable: 4D detection is enabled on INT2 pin when 6D bit on
  *         INT2_CFG (34h) is set to 1.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of d4d_int2 in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_pin_detect_4d_get(stmdev_ctx_t *ctx,
                                        uint8_t *val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5,
                          (uint8_t *)&ctrl_reg5, 1);
  *val = (uint8_t)ctrl_reg5.d4d_int2;

  return ret;
}

/**
  * @brief   Latch interrupt request on INT2_SRC (35h) register, with
  *          INT2_SRC (35h) register cleared by reading INT2_SRC(35h)
  *          itself.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of lir_int2 in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_pin_notification_mode_set(stmdev_ctx_t *ctx,
                                                lis2dh12_lir_int2_t val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5,
                          (uint8_t *)&ctrl_reg5, 1);

  if (ret == 0)
  {
    ctrl_reg5.lir_int2 = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);
  }

  return ret;
}

/**
  * @brief   Latch interrupt request on INT2_SRC (35h) register, with
  *          INT2_SRC (35h) register cleared by reading INT2_SRC(35h)
  *          itself.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of lir_int2 in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int2_pin_notification_mode_get(stmdev_ctx_t *ctx,
                                                lis2dh12_lir_int2_t *val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5,
                          (uint8_t *)&ctrl_reg5, 1);

  switch (ctrl_reg5.lir_int2)
  {
    case LIS2DH12_INT2_PULSED:
      *val = LIS2DH12_INT2_PULSED;
      break;

    case LIS2DH12_INT2_LATCHED:
      *val = LIS2DH12_INT2_LATCHED;
      break;

    default:
      *val = LIS2DH12_INT2_PULSED;
      break;
  }

  return ret;
}

/**
  * @brief  4D enable: 4D detection is enabled on INT1 pin when 6D bit
  *                    on INT1_CFG(30h) is set to 1.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of d4d_int1 in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_pin_detect_4d_set(stmdev_ctx_t *ctx,
                                        uint8_t val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);

  if (ret == 0)
  {
    ctrl_reg5.d4d_int1 = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);
  }

  return ret;
}

/**
  * @brief  4D enable: 4D detection is enabled on INT1 pin when 6D bit on
  *         INT1_CFG(30h) is set to 1.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of d4d_int1 in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_pin_detect_4d_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);
  *val = (uint8_t)ctrl_reg5.d4d_int1;

  return ret;
}

/**
  * @brief   Latch interrupt request on INT1_SRC (31h), with INT1_SRC(31h)
  *          register cleared by reading INT1_SRC (31h) itself.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of lir_int1 in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_pin_notification_mode_set(stmdev_ctx_t *ctx, lis2dh12_lir_int1_t val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);

  if (ret == 0)
  {
    ctrl_reg5.lir_int1 = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);
  }

  return ret;
}

/**
  * @brief   Latch interrupt request on INT1_SRC (31h), with INT1_SRC(31h)
  *          register cleared by reading INT1_SRC (31h) itself.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of lir_int1 in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_int1_pin_notification_mode_get(stmdev_ctx_t *ctx, lis2dh12_lir_int1_t *val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5,
                          (uint8_t *)&ctrl_reg5, 1);

  switch (ctrl_reg5.lir_int1)
  {
    case LIS2DH12_INT1_PULSED:
      *val = LIS2DH12_INT1_PULSED;
      break;

    case LIS2DH12_INT1_LATCHED:
      *val = LIS2DH12_INT1_LATCHED;
      break;

    default:
      *val = LIS2DH12_INT1_PULSED;
      break;
  }

  return ret;
}

/**
  * @brief  Int2 pin routing configuration register.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers CTRL_REG6
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_pin_int2_config_set(stmdev_ctx_t *ctx,
                                     lis2dh12_ctrl_reg6_t *val)
{
  int32_t ret;

  ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG6, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  Int2 pin routing configuration register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers CTRL_REG6
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_pin_int2_config_get(stmdev_ctx_t *ctx, lis2dh12_ctrl_reg6_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG6, (uint8_t *) val, 1);

  return ret;
}
/**
  * @}
  *
  */

/**
  * @defgroup  LIS2DH12_Fifo
  * @brief     This section group all the functions concerning the fifo usage
  * @{
  *
  */

/**
  * @brief  FIFO enable.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fifo_en in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);

  if (ret == 0)
  {
    ctrl_reg5.fifo_en = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);
  }

  return ret;
}

/**
  * @brief  FIFO enable.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fifo_en in reg CTRL_REG5
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_ctrl_reg5_t ctrl_reg5;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG5, (uint8_t *)&ctrl_reg5, 1);
  *val = (uint8_t)ctrl_reg5.fifo_en;

  return ret;
}

/**
  * @brief  FIFO watermark level selection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fth in reg FIFO_CTRL_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_watermark_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_fifo_ctrl_reg_t fifo_ctrl_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);

  if (ret == 0)
  {
    fifo_ctrl_reg.fth = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);
  }

  return ret;
}

/**
  * @brief  FIFO watermark level selection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fth in reg FIFO_CTRL_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_watermark_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_fifo_ctrl_reg_t fifo_ctrl_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);
  *val = (uint8_t)fifo_ctrl_reg.fth;

  return ret;
}

/**
  * @brief  Trigger FIFO selection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tr in reg FIFO_CTRL_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_trigger_event_set(stmdev_ctx_t *ctx, lis2dh12_tr_t val)
{
  lis2dh12_fifo_ctrl_reg_t fifo_ctrl_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);

  if (ret == 0)
  {
    fifo_ctrl_reg.tr = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);
  }

  return ret;
}

/**
  * @brief  Trigger FIFO selection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of tr in reg FIFO_CTRL_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_trigger_event_get(stmdev_ctx_t *ctx, lis2dh12_tr_t *val)
{
  lis2dh12_fifo_ctrl_reg_t fifo_ctrl_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);

  switch (fifo_ctrl_reg.tr)
  {
    case LIS2DH12_INT1_GEN:
      *val = LIS2DH12_INT1_GEN;
      break;

    case LIS2DH12_INT2_GEN:
      *val = LIS2DH12_INT2_GEN;
      break;

    default:
      *val = LIS2DH12_INT1_GEN;
      break;
  }

  return ret;
}

/**
  * @brief  FIFO mode selection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fm in reg FIFO_CTRL_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_mode_set(stmdev_ctx_t *ctx, lis2dh12_fm_t val)
{
  lis2dh12_fifo_ctrl_reg_t fifo_ctrl_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);

  if (ret == 0)
  {
    fifo_ctrl_reg.fm = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);
  }

  return ret;
}

/**
  * @brief  FIFO mode selection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of fm in reg FIFO_CTRL_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_mode_get(stmdev_ctx_t *ctx, lis2dh12_fm_t *val)
{
  lis2dh12_fifo_ctrl_reg_t fifo_ctrl_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_CTRL_REG, (uint8_t *)&fifo_ctrl_reg, 1);

  switch (fifo_ctrl_reg.fm)
  {
    case LIS2DH12_BYPASS_MODE:
      *val = LIS2DH12_BYPASS_MODE;
      break;

    case LIS2DH12_FIFO_MODE:
      *val = LIS2DH12_FIFO_MODE;
      break;

    case LIS2DH12_DYNAMIC_STREAM_MODE:
      *val = LIS2DH12_DYNAMIC_STREAM_MODE;
      break;

    case LIS2DH12_STREAM_TO_FIFO_MODE:
      *val = LIS2DH12_STREAM_TO_FIFO_MODE;
      break;

    default:
      *val = LIS2DH12_BYPASS_MODE;
      break;
  }

  return ret;
}

/**
  * @brief  FIFO status register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers FIFO_SRC_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_status_get(stmdev_ctx_t *ctx, lis2dh12_fifo_src_reg_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_SRC_REG, (uint8_t *) val, 1);

  return ret;
}
/**
  * @brief  FIFO stored data level.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of fss in reg FIFO_SRC_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_data_level_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_fifo_src_reg_t fifo_src_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_SRC_REG, (uint8_t *)&fifo_src_reg, 1);
  *val = (uint8_t)fifo_src_reg.fss;

  return ret;
}
/**
  * @brief  Empty FIFO status flag.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of empty in reg FIFO_SRC_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_empty_flag_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_fifo_src_reg_t fifo_src_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_SRC_REG, (uint8_t *)&fifo_src_reg, 1);
  *val = (uint8_t)fifo_src_reg.empty;

  return ret;
}
/**
  * @brief  FIFO overrun status flag.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of ovrn_fifo in reg FIFO_SRC_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_ovr_flag_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_fifo_src_reg_t fifo_src_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_SRC_REG, (uint8_t *)&fifo_src_reg, 1);
  *val = (uint8_t)fifo_src_reg.ovrn_fifo;

  return ret;
}
/**
  * @brief  FIFO watermark status.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of wtm in reg FIFO_SRC_REG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_fifo_fth_flag_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_fifo_src_reg_t fifo_src_reg;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_FIFO_SRC_REG, (uint8_t *)&fifo_src_reg, 1);
  *val = (uint8_t)fifo_src_reg.wtm;

  return ret;
}
/**
  * @}
  *
  */

/**
  * @defgroup  LIS2DH12_Tap_generator
  * @brief     This section group all the functions that manage the tap and
  *            double tap event generation
  * @{
  *
  */

/**
  * @brief  Tap/Double Tap generator configuration register.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers CLICK_CFG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_tap_conf_set(stmdev_ctx_t *ctx, lis2dh12_click_cfg_t *val)
{
  int32_t ret;

  ret = lis2dh12_write_reg(ctx, LIS2DH12_CLICK_CFG, (uint8_t *) val, 1);

  return ret;
}

/**
  * @brief  Tap/Double Tap generator configuration register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers CLICK_CFG
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_tap_conf_get(stmdev_ctx_t *ctx, lis2dh12_click_cfg_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CLICK_CFG, (uint8_t *) val, 1);

  return ret;
}
/**
  * @brief  Tap/Double Tap generator source register.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      registers CLICK_SRC
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_tap_source_get(stmdev_ctx_t *ctx, lis2dh12_click_src_t *val)
{
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CLICK_SRC, (uint8_t *) val, 1);

  return ret;
}
/**
  * @brief  User-defined threshold value for Tap/Double Tap event.[set]
  *         1 LSB = full scale/128
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of ths in reg CLICK_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_tap_threshold_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_click_ths_t click_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CLICK_THS, (uint8_t *)&click_ths, 1);

  if (ret == 0)
  {
    click_ths.ths = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CLICK_THS, (uint8_t *)&click_ths, 1);
  }

  return ret;
}

/**
  * @brief  User-defined threshold value for Tap/Double Tap event.[get]
  *         1 LSB = full scale/128
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of ths in reg CLICK_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_tap_threshold_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_click_ths_t click_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CLICK_THS, (uint8_t *)&click_ths, 1);
  *val = (uint8_t)click_ths.ths;

  return ret;
}

/**
  * @brief   If the LIR_Click bit is not set, the interrupt is kept high
  *          for the duration of the latency window.
  *          If the LIR_Click bit is set, the interrupt is kept high until the
  *          CLICK_SRC(39h) register is read.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of lir_click in reg CLICK_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_tap_notification_mode_set(stmdev_ctx_t *ctx, lis2dh12_lir_click_t val)
{
  lis2dh12_click_ths_t click_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CLICK_THS, (uint8_t *)&click_ths, 1);

  if (ret == 0)
  {
    click_ths.lir_click = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CLICK_THS, (uint8_t *)&click_ths, 1);
  }

  return ret;
}

/**
  * @brief   If the LIR_Click bit is not set, the interrupt is kept high
  *          for the duration of the latency window.
  *          If the LIR_Click bit is set, the interrupt is kept high until the
  *          CLICK_SRC(39h) register is read.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of lir_click in reg CLICK_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_tap_notification_mode_get(stmdev_ctx_t *ctx,
                                           lis2dh12_lir_click_t *val)
{
  lis2dh12_click_ths_t click_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CLICK_THS,
                          (uint8_t *)&click_ths, 1);

  switch (click_ths.lir_click)
  {
    case LIS2DH12_TAP_PULSED:
      *val = LIS2DH12_TAP_PULSED;
      break;

    case LIS2DH12_TAP_LATCHED:
      *val = LIS2DH12_TAP_LATCHED;
      break;

    default:
      *val = LIS2DH12_TAP_PULSED;
      break;
  }

  return ret;
}

/**
  * @brief  The maximum time (1 LSB = 1/ODR) interval that can elapse
  *         between the start of the click-detection procedure and when the
  *         acceleration falls back below the threshold.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tli in reg TIME_LIMIT
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_shock_dur_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_time_limit_t time_limit;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_TIME_LIMIT, (uint8_t *)&time_limit, 1);

  if (ret == 0)
  {
    time_limit.tli = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_TIME_LIMIT, (uint8_t *)&time_limit, 1);
  }

  return ret;
}

/**
  * @brief  The maximum time (1 LSB = 1/ODR) interval that can elapse between
  *         the start of the click-detection procedure and when the
  *         acceleration falls back below the threshold.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tli in reg TIME_LIMIT
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_shock_dur_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_time_limit_t time_limit;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_TIME_LIMIT,
                          (uint8_t *)&time_limit, 1);
  *val = (uint8_t)time_limit.tli;

  return ret;
}

/**
  * @brief  The time (1 LSB = 1/ODR) interval that starts after the first
  *         click detection where the click-detection procedure is
  *         disabled, in cases where the device is configured for
  *         double-click detection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tla in reg TIME_LATENCY
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_quiet_dur_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_time_latency_t time_latency;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_TIME_LATENCY, (uint8_t *)&time_latency, 1);

  if (ret == 0)
  {
    time_latency.tla = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_TIME_LATENCY, (uint8_t *)&time_latency, 1);
  }

  return ret;
}

/**
  * @brief  The time (1 LSB = 1/ODR) interval that starts after the first
  *         click detection where the click-detection procedure is
  *         disabled, in cases where the device is configured for
  *         double-click detection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tla in reg TIME_LATENCY
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_quiet_dur_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_time_latency_t time_latency;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_TIME_LATENCY,
                          (uint8_t *)&time_latency, 1);
  *val = (uint8_t)time_latency.tla;

  return ret;
}

/**
  * @brief  The maximum interval of time (1 LSB = 1/ODR) that can elapse
  *         after the end of the latency interval in which the click-detection
  *         procedure can start, in cases where the device is configured
  *         for double-click detection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tw in reg TIME_WINDOW
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_double_tap_timeout_set(stmdev_ctx_t *ctx,
                                        uint8_t val)
{
  lis2dh12_time_window_t time_window;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_TIME_WINDOW, (uint8_t *)&time_window, 1);

  if (ret == 0)
  {
    time_window.tw = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_TIME_WINDOW, (uint8_t *)&time_window, 1);
  }

  return ret;
}

/**
  * @brief  The maximum interval of time (1 LSB = 1/ODR) that can elapse
  *         after the end of the latency interval in which the
  *         click-detection procedure can start, in cases where the device
  *         is configured for double-click detection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of tw in reg TIME_WINDOW
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_double_tap_timeout_get(stmdev_ctx_t *ctx,
                                        uint8_t *val)
{
  lis2dh12_time_window_t time_window;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_TIME_WINDOW,
                          (uint8_t *)&time_window, 1);
  *val = (uint8_t)time_window.tw;

  return ret;
}

/**
  * @}
  *
  */

/**
  * @defgroup  LIS2DH12_Activity_inactivity
  * @brief     This section group all the functions concerning activity
  *            inactivity functionality
  * @{
  *
  */

/**
  * @brief    Sleep-to-wake, return-to-sleep activation threshold in
  *           low-power mode.[set]
  *           1 LSb = 16mg@2g / 32mg@4g / 62mg@8g / 186mg@16g
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of acth in reg ACT_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_act_threshold_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_act_ths_t act_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_ACT_THS, (uint8_t *)&act_ths, 1);

  if (ret == 0)
  {
    act_ths.acth = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_ACT_THS, (uint8_t *)&act_ths, 1);
  }

  return ret;
}

/**
  * @brief  Sleep-to-wake, return-to-sleep activation threshold in low-power
  *         mode.[get]
  *         1 LSb = 16mg@2g / 32mg@4g / 62mg@8g / 186mg@16g
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of acth in reg ACT_THS
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_act_threshold_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_act_ths_t act_ths;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_ACT_THS, (uint8_t *)&act_ths, 1);
  *val = (uint8_t)act_ths.acth;

  return ret;
}

/**
  * @brief  Sleep-to-wake, return-to-sleep.[set]
  *         duration = (8*1[LSb]+1)/ODR
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of actd in reg ACT_DUR
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_act_timeout_set(stmdev_ctx_t *ctx, uint8_t val)
{
  lis2dh12_act_dur_t act_dur;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_ACT_DUR, (uint8_t *)&act_dur, 1);

  if (ret == 0)
  {
    act_dur.actd = val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_ACT_DUR, (uint8_t *)&act_dur, 1);
  }

  return ret;
}

/**
  * @brief  Sleep-to-wake, return-to-sleep.[get]
  *         duration = (8*1[LSb]+1)/ODR
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of actd in reg ACT_DUR
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_act_timeout_get(stmdev_ctx_t *ctx, uint8_t *val)
{
  lis2dh12_act_dur_t act_dur;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_ACT_DUR, (uint8_t *)&act_dur, 1);
  *val = (uint8_t)act_dur.actd;

  return ret;
}

/**
  * @}
  *
  */

/**
  * @defgroup  LIS2DH12_Serial_interface
  * @brief     This section group all the functions concerning serial
  *            interface management
  * @{
  *
  */

/**
  * @brief  Connect/Disconnect SDO/SA0 internal pull-up.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of sdo_pu_disc in reg CTRL_REG0
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_pin_sdo_sa0_mode_set(stmdev_ctx_t *ctx,
                                      lis2dh12_sdo_pu_disc_t val)
{
  lis2dh12_ctrl_reg0_t ctrl_reg0;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG0, (uint8_t *)&ctrl_reg0, 1);

  if (ret == 0)
  {
    ctrl_reg0.sdo_pu_disc = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG0, (uint8_t *)&ctrl_reg0, 1);
  }

  return ret;
}

/**
  * @brief  Connect/Disconnect SDO/SA0 internal pull-up.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of sdo_pu_disc in reg CTRL_REG0
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_pin_sdo_sa0_mode_get(stmdev_ctx_t *ctx,
                                      lis2dh12_sdo_pu_disc_t *val)
{
  lis2dh12_ctrl_reg0_t ctrl_reg0;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG0,
                          (uint8_t *)&ctrl_reg0, 1);

  switch (ctrl_reg0.sdo_pu_disc)
  {
    case LIS2DH12_PULL_UP_DISCONNECT:
      *val = LIS2DH12_PULL_UP_DISCONNECT;
      break;

    case LIS2DH12_PULL_UP_CONNECT:
      *val = LIS2DH12_PULL_UP_CONNECT;
      break;

    default:
      *val = LIS2DH12_PULL_UP_DISCONNECT;
      break;
  }

  return ret;
}

/**
  * @brief  SPI Serial Interface Mode selection.[set]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      change the values of sim in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_spi_mode_set(stmdev_ctx_t *ctx, lis2dh12_sim_t val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);

  if (ret == 0)
  {
    ctrl_reg4.sim = (uint8_t)val;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);
  }

  return ret;
}

/**
  * @brief  SPI Serial Interface Mode selection.[get]
  *
  * @param  ctx      read / write interface definitions
  * @param  val      Get the values of sim in reg CTRL_REG4
  * @retval          interface status (MANDATORY: return 0 -> no Error)
  *
  */
int32_t lis2dh12_spi_mode_get(stmdev_ctx_t *ctx, lis2dh12_sim_t *val)
{
  lis2dh12_ctrl_reg4_t ctrl_reg4;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG4, (uint8_t *)&ctrl_reg4, 1);

  switch (ctrl_reg4.sim)
  {
    case LIS2DH12_SPI_4_WIRE:
      *val = LIS2DH12_SPI_4_WIRE;
      break;

    case LIS2DH12_SPI_3_WIRE:
      *val = LIS2DH12_SPI_3_WIRE;
      break;

    default:
      *val = LIS2DH12_SPI_4_WIRE;
      break;
  }

  return ret;
}

/**
  * @}
  *
  */

/**
  * @}
  *
  */


/************************ (C) COPYRIGHT STMicroelectronics *****END OF FILE****/

// ADD by Matteo Albi

#ifndef DEBUG_ON
  #define DEBUG_ON
#endif

/* Private variables ---------------------------------------------------------*/
static int16_t data_raw_acceleration[3];
static int16_t lis2dh12_data_raw_temperature;
static float acceleration_mg[3];
static float lis2dh12_temperature_degC;
static uint8_t acc_whoamI;
static stmdev_ctx_t dev_ctx;
static bool acc_device_found;
// calibration data struct
static const man_fds_acc_t * acc_config;

/* Definition of TWI functions ------------------------------------------*/

static int32_t platform_write(uint8_t* dev_adrs_pnt, uint8_t reg, const uint8_t *bufp, uint16_t len){
  //ret_code_t ret = vTWI_Write(*dev_adrs_pnt, reg, bufp, len);
  ret_code_t ret = vTWI_Write_my(*dev_adrs_pnt, reg, bufp, len);
  return (int32_t)ret;
}

static int32_t platform_read(uint8_t* dev_adrs_pnt, uint8_t reg, uint8_t *bufp, uint16_t len){
  ret_code_t ret = vTWI_Read(*dev_adrs_pnt, reg, bufp, len);
  return (int32_t)ret;
}


/* Definition of my functions to get/set registers ------------------------------------------*/

int32_t lis2dh12_enable_all_acc_axis(stmdev_ctx_t *ctx)
{
  lis2dh12_ctrl_reg1_t ctrl_reg1;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, LIS2DH12_CTRL_REG1, (uint8_t *)&ctrl_reg1, 1);

  if (ret == 0)
  {
    ctrl_reg1.xen = 1;
    ctrl_reg1.yen = 1;
    ctrl_reg1.zen = 1;
    ret = lis2dh12_write_reg(ctx, LIS2DH12_CTRL_REG1, (uint8_t *)&ctrl_reg1, 1);
  }

  return ret;
}


void lis2dh12_print_reg(stmdev_ctx_t *ctx, uint8_t reg_add){
  uint8_t data;
  int32_t ret;

  ret = lis2dh12_read_reg(ctx, reg_add, &data, 1);

  if (ret == 0)
  {
    printf("Register 0x%02x value: 0x%02x\r\n", reg_add, data);
  }
  else{
    printf("Unable to read register 0x%02x\r\n", reg_add);
  }

}


int32_t lis2dh12_acceleration_raw_get_my(stmdev_ctx_t *ctx, int16_t *val){
  int32_t err, ret;
  uint8_t low_data, high_data;

  ret = 0;
                
  // X-axis
  err = lis2dh12_read_reg(ctx, LIS2DH12_OUT_X_L, &low_data, 1);
  ret |= err;
  err = lis2dh12_read_reg(ctx, LIS2DH12_OUT_X_H, &high_data, 1);
  ret |= err;
  val[0] = (int16_t)(high_data * 256) + (int16_t)low_data;

  // Y-axis	
  err = lis2dh12_read_reg(ctx, LIS2DH12_OUT_Y_L, &low_data, 1);
  ret |= err;
  err = lis2dh12_read_reg(ctx, LIS2DH12_OUT_Y_H, &high_data, 1);
  ret |= err;
  val[1] = (int16_t)(high_data * 256) + (int16_t)low_data;

  // Z-axis
  err = lis2dh12_read_reg(ctx, LIS2DH12_OUT_Z_L, &low_data, 1);
  ret |= err;
  err = lis2dh12_read_reg(ctx, LIS2DH12_OUT_Z_H, &high_data, 1);
  ret |= err;
  val[2] = (int16_t)(high_data * 256) + (int16_t)low_data;

  return ret;
}


int32_t lis2dh12_temperature_raw_get_my(stmdev_ctx_t *ctx, int16_t *val){
  int32_t err, ret;
  uint8_t low_data, high_data;

  ret = 0;
  err = lis2dh12_read_reg(ctx, LIS2DH12_OUT_TEMP_L, &low_data, 1);
  ret |= err;
  err = lis2dh12_read_reg(ctx, LIS2DH12_OUT_TEMP_H, &high_data, 1);
  ret |= err;
  *val = (int16_t)(high_data * 256) + (int16_t)low_data;

  return ret;
}


/* Definition of my functions to manage the sensor ------------------------------------------*/

void lis2dh_init_bypass(void){
  // init handling communication struct 
  dev_ctx.write_reg = platform_write;
  dev_ctx.read_reg = platform_read;
  dev_ctx.handle = malloc(sizeof(uint8_t));
  *dev_ctx.handle = LIS2DH_MY_ADD;

  int32_t err;
  ret_code_t err_twi;  

  // Check device ID
  err = lis2dh12_device_id_get(&dev_ctx, &acc_whoamI);

  if (err || acc_whoamI != LIS2DH12_ID) {
    acc_device_found = false;
    printf("\r\nLIS2DH12 device not found at LIS2DH12_I2C_ADD = 0x%02x\r\n", LIS2DH_MY_ADD);  
  }
  else{
    acc_device_found = true;
    printf("\r\nLIS2DH12 device found ID = 0x%02x\r\n", acc_whoamI);
    
    // TEMP SENSOR
    // Enable temperature sensor
    err = lis2dh12_temperature_meas_set(&dev_ctx, LIS2DH12_TEMP_ENABLE);
    if(err) printf("Error in enabling temp sensor\r\n");

    // Enable block data update
    err = lis2dh12_block_data_update_set(&dev_ctx, 1);
    if(err) printf("Error in enabling block data update\r\n");

    //ACC SENSOR    

    // Disable self-test
    err = lis2dh12_self_test_set(&dev_ctx, LIS2DH12_ST_DISABLE);
    if(err) printf("Error in disabling self test\r\n");

    // Set FIFO mode to Bypass mode
    err = lis2dh12_fifo_mode_set(&dev_ctx, LIS2DH12_BYPASS_MODE);
    if(err) printf("Error in setting mode\r\n");

    // Set full scale to 2g
    err = lis2dh12_full_scale_set(&dev_ctx, LIS2DH12_2g);
    if(err) printf("Error in setting scale\r\n");

    // Set device to 12 bit resol
    err = lis2dh12_operating_mode_set(&dev_ctx, LIS2DH12_HR_12bit);
    if(err) printf("Error in setting resolution\r\n");

    // Set Output Data Rate to 50Hz
    err = lis2dh12_data_rate_set(&dev_ctx, LIS2DH12_ODR_100Hz);
    if(err) printf("Error in setting data rate\r\n");

    // Enable all acc axis outputs
    err = lis2dh12_enable_all_acc_axis(&dev_ctx);
    if(err) printf("Error in enabling acc axis outputs\r\n");

#ifdef DEBUG_ON
    // Print set registers
    //lis2dh12_print_reg(&dev_ctx, LIS2DH12_TEMP_CFG_REG);
    //lis2dh12_print_reg(&dev_ctx, LIS2DH12_CTRL_REG1);
    //lis2dh12_print_reg(&dev_ctx, LIS2DH12_CTRL_REG4);
    //lis2dh12_print_reg(&dev_ctx, LIS2DH12_FIFO_CTRL_REG);
#endif

    acc_config = man_fds_get_acc_config();

    if(!err) printf("Configuration of LIS2DH12 successful\r\n");
  }

}


int32_t lis2dh_get_acc(float *buf){
  int32_t err = 0;

  if(! acc_device_found){
    //printf("Device not found during init\r\n");
    err = 1;
  }
  else{
    // read if new data is available
    uint8_t data_ready;
    err = lis2dh12_xl_data_ready_get(&dev_ctx, &data_ready);
    //if(err) printf("Error in checking new data availability\r\n");

    if(data_ready && !err){
      // Blue led on to signal starting read
      //bsp_board_led_on(BLUE_LED);

      // Read XL samples 
      err = lis2dh12_acceleration_raw_get_my(&dev_ctx, data_raw_acceleration);
      
      // convert to float and compensate bias
      if(!err){
        acceleration_mg[0] = lis2dh12_from_fs2_hr_to_mg(data_raw_acceleration[0]);
        acceleration_mg[1] = lis2dh12_from_fs2_hr_to_mg(data_raw_acceleration[1]);
        acceleration_mg[2] = lis2dh12_from_fs2_hr_to_mg(data_raw_acceleration[2]);
      }

      //bsp_board_led_off(BLUE_LED);
    }

    if(!err && buf != NULL){
      buf[0] = acceleration_mg[0]; 
      buf[1] = acceleration_mg[1]; 
      buf[2] = acceleration_mg[2];
    }
  }

  return err;
  
}


int32_t lis2dh_get_acc_calibrated(float *buf){
  int32_t err = lis2dh_get_acc(NULL);
  
  if(!err){      
    // apply offset and scale
    buf[0] =  (acceleration_mg[0] - acc_config->bias[0]) * acc_config->scale[0];
    buf[1] =  (acceleration_mg[1] - acc_config->bias[1]) * acc_config->scale[1];
    buf[2] =  (acceleration_mg[2] - acc_config->bias[2]) * acc_config->scale[2];
  }

  return err;
}


void lis2dh_print_acc(void){
  float tmp[3];

  if(lis2dh_get_acc_calibrated(tmp)) printf("Error during data reading");
  else{
    // Print to UART most recent data  
    printf("acc:\t%4.2f\t%4.2f\t%4.2f\r\n",
                      tmp[0], 
                      tmp[1], 
                      tmp[2]);
  }   
}


int32_t lis2dh_get_temp(float *val){
  int32_t err;

  if(! acc_device_found){
    err = 1;
  }
  else{
    uint8_t data_ready;
    err = lis2dh12_temp_data_ready_get(&dev_ctx, &data_ready);
    //if(err) printf("Error in checking new data availability\r\n");

    if (data_ready && !err) {
      // Read temperature data
      err = lis2dh12_temperature_raw_get_my(&dev_ctx, &lis2dh12_data_raw_temperature);
      if(!err) {
        // Convert raw data in float
        lis2dh12_temperature_degC = lis2dh12_from_lsb_hr_to_celsius(lis2dh12_data_raw_temperature);
      }
    }
    if(!err && val != NULL) *val = lis2dh12_temperature_degC;
  }

  return err;  
}


void lis2dh_print_temp(void){
  int32_t err = lis2dh_get_temp(NULL);

  if(err) printf("Error during data reading");
  else{
    // Print to UART most recent data
    printf("tmp mag:\t%6.2f\r\n", lis2dh12_temperature_degC);
  }  
  
}