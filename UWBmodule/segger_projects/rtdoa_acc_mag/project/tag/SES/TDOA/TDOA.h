/*! ----------------------------------------------------------------------------
 *  @file    TDOA.h
 *  @brief
 *
 *
 * @attention
 *
 *
 * @authors	Luca Santoro:       luca.santoro@unitn.it
 *          Matteo Nardello:	matteo.nardello@unitn.it
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
//added
#include "rTDoA_est.h"
//#include "lis2dh12_reg.h"
//#include "lis2mdl_reg.h"

#ifndef DEBUG_ON
//#define DEBUG_ON
#endif


/**
 * @brief run TDOA procedure. At the end perform RTDOA to get
 *        tag position and saves it rtdoa_buf. If rtdoa_buf == NULL, print
 *        the position to UART
 * 
 * @param rtdoa_buf     pointer to float[3] where save the position
 * @param tick          save tick of received data
 * @return uint32_t     RTDOA_NO_ERR if no error occured
 *                      TDOA_NO_RES if not enough data to run rtdoa
 *                      rtdoa_err_code in error occured during rtdoa algorithm
 */
uint32_t tag_tdoa_run(float * rtdoa_buf, TickType_t * tick);