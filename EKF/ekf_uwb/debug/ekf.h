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

#define _USE_MATH_DEFINES

#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include "linear_algebra.h"

typedef float ekf_data_t;

#define MIN(X, Y) (((X) < (Y)) ? (X) : (Y))
#define EKF_PI  3.141592653589793

/* Macro ---------------------------------------------------------*/
#define NO_POS // disable the position computation of the ekf

#define EKF_MAX_ACCEPTED_POS        1000.0 //[m]
#define EKF_MAX_GYRO                10.0 //[rad/s]
#define EKF_MAX_DT                  0.01 //[s]
#define EKF_G_MAGNITUDE             1000.0 //[mg]
#define EKF_RAD_TO_DEG              (ekf_data_t)(180.0/ (ekf_data_t)EKF_PI) //[deg/rad]
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
void ekf_quat2eul(const ekf_data_t *const q, ekf_data_t *const eul);


/**
 * @brief Initializes the sensors config, the lap timer and the state
 *        matrices
 * 
 * @param ret pointer where to copy X_att
 * @param au  acc uncertainty
 * @param mu  mag uncertainty
 * @param si  mag soft iron
 * @param acc acc data with which init the state
 * @param mag mag data with which init the state
 * 
 * @return uint32_t NRF_SUCCESS if initialization complited
 *                  err code from ekf_get_acc_mag_data -> not able to init the attitude
 */
uint32_t ekf_init(ekf_data_t *const ret, const ekf_data_t *const au, const ekf_data_t *const mu, const ekf_data_t *const si,
                    const float * const acc, const float * const mag);


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
 * @param ret pointer to extract variables for visualization
 */
void ekf_step(ekf_data_t *const ret, const float * const acc, const float * const mag);

#pragma endregion

#endif