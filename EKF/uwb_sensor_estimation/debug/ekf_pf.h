#ifndef K_FILTER_PF
#define K_FILTER_PF

#include "ekf.h"


#pragma region // -- time management

/**
 * @brief start the timer keeping track of the dt between
 *        accelerometer readings (uqual to the duration of a kalman step)
 * 
 */
// void ekf_start_timer(void);


/**
 * @brief Compute dt in [ms] between two machine ticks, 
 *        taking care of overflow occurance
 * 
 * @param from_tick first tick
 * @param to_tick second tick
 * @return ekf_data_t dt beween the two ticks
 */
// ekf_data_t ekf_compute_dt(const TickType_t from_tick, const TickType_t to_tick);


/**
 * @brief save the second tick of the lap timer (betweeen acc readings) and save
 *        dt between readings in lap. At the end, shift the ticks. 
 *        ekf_start_timer() must be called before this function
 * 
 * @param lap variable where save the lap duration in [ms]
 * @return uint32_t error code: NRF_ERROR_INVALID_STATE if timer_started_flag = false
 *                                                  ekf_start_timer() not called before
 *                              NRF_SUCCESS no errors
 */
// uint32_t ekf_get_lap_timer(ekf_data_t *const lap);

#pragma endregion


#pragma region // -- sensor data

#ifndef NO_POS

/**
 * @brief wait for the uwb module to generate two valid position readings
 *        and saves them in uwb_data
 * 
 */
void ekf_get2_uwb_data(void);


/**
 * @brief collect 1 uwb data (may not be valid) and save it in uwb_data
 * 
 * @return uint32_t tag_tdoa_run err code:  RTDOA_NO_ERR valid data
 *                                          other: not valid data (err code from rTDoA_est)
 */
uint32_t ekf_get1_uwb_data(void);

#endif


/**
 * @brief collect acc and mag readings, and save the result of ekf_get_lap_timer in 
 *        variable dt.
 *        Then runs a check on the acc module to detect external accelerations. 
 *        If external accelerations are detected, saves the mag readings in the second 
 *        position of mag_data, setting mag_buff_iter to 1
 * @todo implement error managements from get-data functions
 * 
 * @param acc acc data
 * @param mag mag data
 * 
 * @return uint32_t err code of lis2mdl_get_mag 
 */
uint32_t ekf_get_acc_mag_data(const ekf_data_t * const acc, const ekf_data_t * const mag);

#pragma endregion


#pragma region // -- calculus

/**
 * @brief compute the Jacobian of a normalization
 * 
 * @param v value of the vector to be normalized
 * @param n number of el of v
 * @param J vector where to save the jacobian
 */
void J_normalization(const ekf_data_t *const v, const uint8_t n, ekf_data_t *const J);


/**
 * @brief compute the normalized acc readings and their unceratinty matrix.
 *        If external acceleration where detected in reading phase, increases
 *        the uncertainty of the acc based on the deviation of the norm from 
 *        EKF_G_MAGNITUDE (value of g in acc reading udm)
 * 
 * @param an vector where to save the normalized acc readings
 * @param Ra vecotr where to save the uncertainty
 */
void norm_acc(ekf_data_t *const an, ekf_data_t *const Ra);


/**
 * @brief compute the normalized mag readings and their unceratinty matrix.
 * 
 * @param mn vector where to save the normalized mag readings
 * @param Rm vecotr where to save the uncertainty
 * @param iter iter to select the mag data in the buffer
 */
void norm_mag(ekf_data_t *const mn, ekf_data_t *const Rm, uint8_t iter);


/**
 * @brief converts euler (X, Y, Z) angle to quaternion
 * 
 * @param phi roll value
 * @param theta pitch value
 * @param psi yaw value
 * @param q variable where to save the quaternion
 */
void ekf_eul2quat(const ekf_data_t *const phi, const ekf_data_t *const theta, const ekf_data_t *const psi, ekf_data_t *const q);


/**
 * @brief convert quaternion to matrix rotation
 * 
 * @param q input quaternion
 * @param matrix variable where to save the matrix
 */
void ekf_quat2rotM(const ekf_data_t *const q, ekf_data_t *const matrix);


/**
 * @brief compute the Hamilton product between two quaternions
 *        qp = q1 * q2
 * 
 * @param q1 first quaternion
 * @param q2 seecond quaternion
 * @param qp Hamilton product
 */
void hamilton_prod(const ekf_data_t *const q1, const ekf_data_t *const q2, ekf_data_t *const qp);

/**
 * @brief hardcoded inverse of 4x4 matrix
 * 
 * @param mat input
 * @param dst vector where to save the result
 */
void inv4x4(const float * const mat, float * const dst);


/**
 * @brief runs the TRIAD alcorithm to compute the measures (saved in z) and their
 *        uncertainty (saved in Rz)
 *        NB: writes z and RZ
 * 
 */
void ekf_TRIAD(void);


/**
 * @brief initializes the attitude state X_att and P_att. Using the TRIAD algorithm, 
 *        computes the euler angles representing the currrent attitude and
 *        then convert them in a quaternion. It propagates all linearized operation 
 *        to compute P_att
 *        NB: writes on z and RZ
 * 
 */
void ekf_init_att(void);


#ifndef NO_POS

/**
 * @brief computes the measures (saved in z) and their uncertainties (saved in Rz)
 *        realted to the uwb readings. Manages the cases of 1 or 2 readings
 *        NB: writes on z and RZ
 * 
 */
void ekf_uwb2meas(void);

#endif

#pragma endregion


#pragma region // -- filter

/**
 * @brief perform the prediction step on the attitude. The idea is to perform a 
 *        prediction when the system detects external accelerations. To perform 
 *        the prediction, two consecutive readings of the magnetometer are used. 
 *        The function computes the quaternion between the two reaad vectors and 
 *        apply it on the previous attitude.
 *        NB: writes on z and RZ
 * 
 */
void ekf_att_prediction(void);


/**
 * @brief perform the update step on the attitude using the 
 *        TRIAD algorithm (executed inside the function)
 *        NB: writes on z and RZ
 * 
 */
void ekf_att_update(void);

#ifndef NO_POS

/**
 * @brief perform the prediction step on the position. It computes the extern 
 *        acceleration by projecting the raw acc radings into the global frame
 *        and then subtract the gravity component.
 *        NB: writes on z and RZ (by calling ekf_uwb2meas)
 * 
 */
void ekf_pos_prediction(void);


/**
 * @brief perform the update step on the position using the uwb readings.
 *        Manages the case of 1 reading (update only pos) and 2 readings
 *        (update pos and vel)
 *        NB: writes on z
 * 
 */
void ekf_pos_update(void);

#endif

#pragma endregion

#endif
