/*! ----------------------------------------------------------------------------
*  @file    ekf.h
*  @brief   This file contains all the functions prototypes for the
*           ekf.c library.
*
* 
* @attention
*
*
* @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
*/

#ifndef K_FILTER
#define K_FILTER

#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>
#include <stdlib.h>

#include "linear_algebra.h"
#include "../common/config.h"
#include "lis2dh12_reg.h"
#include "lis2mdl_reg.h"
#include "TDOA.h"
#include "fds_manager.h"
#include "FreeRTOS.h"

/* Macro ---------------------------------------------------------*/
#define NO_POS // disable the position computation of the ekf

#define EKF_MAX_ACCEPTED_POS        1000.0
#define EKF_G_MAGNITUDE             1000.0 //[mg]
#define EKF_RAD_TO_DEG              180.0/ (float)M_PI
#define EKF_MG_TO_MS2               9.807/EKF_G_MAGNITUDE //[m/s^2]
#define EKF_SIGMA_68                1.0
#define EKF_SIGMA_95                2.0
#define EKF_SIGMA_99                3.0 

#pragma region /* Public functions ---------------------------------------------------------*/

/**
 * @brief convert a quaternion into Euler angles
 * 
 * @param q input quaternion
 * @param eul output euler angles
 */
void ekf_quat2eul(const float *const q, float *const eul);


/**
 * @brief Initializes the sensors config, the lap timer and the state
 *        matrices
 * 
 * @param ret pointer where to copy X_att
 * 
 * @return uint32_t NRF_SUCCESS if initialization complited
 *                  err code from ekf_get_acc_mag_data -> not able to init the attitude
 */
uint32_t ekf_init(float *const ret);


/**
 * @brief performes a Kalman step. First collect 1 uwb data and the acc and 
 *        mag readings. 
 *        If external accelerations were detected, runs only the attitude 
 *        prediction. Otherwise, increase the uncertainty of the stored attitude 
 *        and then update it.
 *        Then uses the new attitude for the prediction of the position, and then
 *        updates it (if the uwb data is valid)
 * @todo manage errors in the sensors readings
 * 
 * @param ret pointer where to copy X_att
 */
void ekf_step(float *const ret);

#pragma endregion

#endif