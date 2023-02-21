/*! ----------------------------------------------------------------------------
*  @file    ekf.c
*  @brief   extended Kalman filter implementation based on uwb position data (rtdoa
*           algorithm), accelerometer and magnetometer
*
* 
* @attention
*
*
* @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
*/

#include "ekf.h"
#include "ekf_pf.h"
#include "../LIN_ALG/linear_algebra.h"

#ifndef DEBUG_ON
    #define DEBUG_ON
#endif


#pragma region /* Private variables -------------------------------------------------*/

// timer
static TickType_t lap_1st_tick, lap_2nd_tick;
static bool timer_started_flag = false;

// sensors data struct
static const man_fds_acc_t * acc_config;
static const man_fds_mag_t * mag_config;
#ifndef NO_POS
static const man_fds_uwb_t * uwb_config;
#endif

// sensor data
#ifndef NO_POS
static float uwb_data[2][3];
#endif
static float acc_data[3];
static float mag_data[2][3];

#ifndef NO_POS
// variables for computation of velocity 
static uint8_t uwb_buff_iter = 0;
static TickType_t pos_tick[2];
#endif

// variables for computation of mag vector variation
static uint8_t mag_buff_iter = 0;
//static TickType_t mag_tick[2];

// Filter states
static float X_att[4];
static float P_att[16];
#ifndef NO_POS
static float X_pos[4];
static float P_pos[16];
#endif

// measurement variables
static float z[4];
static float Rz[16];

static float dt; // interval between cycles of acc measurements

#pragma endregion


#pragma region /* Private functions ---------------------------------------------------------*/

#pragma region // -- time management

void ekf_start_timer(void){
    if(!timer_started_flag){
        lap_1st_tick = xTaskGetTickCount();
        timer_started_flag = true;
    }
}


float ekf_compute_dt(const TickType_t from_tick, const TickType_t to_tick){
    uint32_t ret = to_tick - from_tick;
    // manage overflow
    if(from_tick > to_tick) ret += (uint32_t)0xffffffffU;
    return (float)ret / 1000.0;
}


uint32_t ekf_get_lap_timer(float *const lap){
    // get tick 
    lap_2nd_tick = xTaskGetTickCount();

    if(!timer_started_flag) return NRF_ERROR_INVALID_STATE;

    // compute dt
    * lap = ekf_compute_dt(lap_1st_tick, lap_2nd_tick);
    // save new tick
    lap_1st_tick = lap_2nd_tick;
    
    return NRF_SUCCESS;
}

#pragma endregion


#pragma region // -- sensor data

#ifndef NO_POS

void ekf_get2_uwb_data(void){
    uwb_buff_iter = 0;

    // collect 2 * data position
    while(uwb_buff_iter < 2){
        // wait for uwb to collect 6 readings and successfully obtain position
        uint32_t err = tag_tdoa_run(uwb_data[uwb_buff_iter], pos_tick[uwb_buff_iter]);
        while(err) err = tag_tdoa_run(uwb_data[uwb_buff_iter], pos_tick[uwb_buff_iter]);

        uwb_buff_iter++;
    }
    uwb_buff_iter = 0;
}


uint32_t ekf_get1_uwb_data(void){
    // wait for uwb to collect 6 readings
    uint32_t err = tag_tdoa_run(uwb_data[uwb_buff_iter], pos_tick[uwb_buff_iter]);
    while(err == TDOA_NO_RES) err = tag_tdoa_run(uwb_data[uwb_buff_iter], pos_tick[uwb_buff_iter]);

    if(err == RTDOA_NO_ERR){
        uwb_buff_iter++;
        if(uwb_buff_iter > 1) uwb_buff_iter = 0;
    }
    return err;
}

#endif


uint32_t ekf_get_acc_mag_data(void){
    float acc_norm_sigma, acc_norm_dev;
    // get acc data
    uint32_t err = lis2dh_get_acc_calibrated(acc_data);
    if(!timer_started_flag) ekf_start_timer();
    else ekf_get_lap_timer(&dt); // [s]
    if(err){ /* manage error*/ }

    // acc norm [mg]
    float tmp = norm2(acc_data, 3);
    // compute acc_norm_sigma
    acc_norm_sigma = 0;
    for(uint8_t i=0; i<3; i++) acc_norm_sigma += acc_config->unc[i] * powf(acc_data[i]/tmp, 2); // uncertainty of acc norm
    // standard deviation
    acc_norm_sigma = sqrt(acc_norm_sigma) * EKF_SIGMA_99; // prob = 1 - 0.99 of detecting false ext acc
    acc_norm_dev = fabs(tmp - EKF_G_MAGNITUDE);

    /* manage norm != g*/
    if(acc_norm_dev > acc_norm_sigma){ 

        if(mag_buff_iter == 1){
            // shift registers
            memcpy(mag_data[0], mag_data[1], sizeof(float) * 3);
            //mag_tick[0] = mag_tick[1];
        }

        mag_buff_iter = 1;
    }
    else{
        mag_buff_iter = 0;
    }

    // get mag data 
    err = lis2mdl_get_mag_calibrated(mag_data[mag_buff_iter]); 
    if(err){ /* manage error*/ }
    //mag_tick[mag_buff_iter] = xTaskGetTickCount();

    return err;
}

#pragma endregion


#pragma region // -- calculus

void J_normalization(const float *const v, const uint8_t n, float *const J){
    float tmp = powf(norm2(v, n), 2);
    float tmp2 = powf(norm2(v, n), 3);

    for(uint8_t i=0; i<n; i++){
        for(uint8_t j=0; j<n; j++){
            if(i == j) J[i*n + j] = (tmp - powf(v[i], 2)) / tmp2;
            else J[i*n + j] = - (v[i] * v[j]) / tmp2;
        }
    }
}


void norm_acc(float *const an, float *const Ra){
    float v_tmp[9];
    float tmp = norm2(acc_data, 3);
    // normalize acc
    for(uint8_t i=0; i<3; i++) an[i] = acc_data[i] / tmp;
    // compute unc
    v2diag_m(acc_config->unc, Ra, 3);
    //J_normalization(acc_data, 3, v_tmp);
    //quadratic_form(v_tmp, Ra, Ra, 3, 3);
    // easy way
    for(uint8_t i=0; i<3*3; i++) Ra[i] /= powf(EKF_G_MAGNITUDE, 2);
    
    // case norm_acc != g -> increase Ra_n (THIS PART IS NOT USED IN RUNNING, ONLY IN INIT)
    if(mag_buff_iter > 0){
        tmp = powf( (tmp - EKF_G_MAGNITUDE) / tmp, 2); // [~ 1e-6 g]
        for(uint8_t i=0; i<3; i++) Ra[i * 4] += tmp;
    }
}


void norm_mag(float *const mn, float *const Rm, uint8_t iter){
    float v_tmp[9];
    float tmp = norm2(mag_data[iter], 3);
    // normalize mag
    for(uint8_t i=0; i<3; i++) mn[i] = mag_data[iter][i] / tmp;
    // compute unc
    v2diag_m(mag_config->unc, Rm, 3); 
    // calibration part
    quadratic_form(mag_config->soft_iron, Rm, Rm, 3, 3);
    // normalization part
    J_normalization(mag_data[iter], 3, v_tmp); 
    quadratic_form(v_tmp, Rm, Rm, 3, 3);
    // easy way
    //for(uint8_t i=0; i<3*3; i++) Rm[i] /= powf(tmp, 2);
}


void ekf_eul2quat(const float *const phi, const float *const theta, const float *const psi, float *const q){
    q[0] =  cosf(*phi/2) * cosf(*theta/2) * cosf(*psi/2) + sinf(*phi/2) * sinf(*theta/2) * sinf(*psi/2);
    q[1] =  sinf(*phi/2) * cosf(*theta/2) * cosf(*psi/2) - cosf(*phi/2) * sinf(*theta/2) * sinf(*psi/2);
    q[2] =  cosf(*phi/2) * sinf(*theta/2) * cosf(*psi/2) + sinf(*phi/2) * cosf(*theta/2) * sinf(*psi/2);
    q[3] =  cosf(*phi/2) * cosf(*theta/2) * sinf(*psi/2) - sinf(*phi/2) * sinf(*theta/2) * cosf(*psi/2);
}


void ekf_quat2eul(const float *const q, float *const eul){
    eul[0] = atan2f(2*q[1]*q[0] + 2*q[3]*q[2], pow(q[0], 2) - pow(q[1], 2) - pow(q[2], 2) + pow(q[3], 2)) * EKF_RAD_TO_DEG;
    eul[1] = asin(2*q[0]*q[2] - 2*q[1]*q[3]) * EKF_RAD_TO_DEG;
    eul[2] = atan2(2*q[3]*q[0] + 2*q[2]*q[1], pow(q[0], 2) + pow(q[1], 2) - pow(q[2], 2) - pow(q[3], 2)) * EKF_RAD_TO_DEG;
}


void ekf_quat2rotM(const float *const q, float *const matrix){
    matrix[0] = powf(q[0], 2) + powf(q[1], 2) - powf(q[2], 2) - powf(q[3], 2);
    matrix[1] = - 2 * q[0] * q[3] + 2 * q[1] * q[2];
    matrix[2] =   2 * q[0] * q[2] + 2 * q[1] * q[3];
    matrix[3] =   2 * q[0] * q[3] + 2 * q[1] * q[2];
    matrix[4] = powf(q[0], 2) - powf(q[1], 2) + powf(q[2], 2) - powf(q[3], 2);
    matrix[5] = - 2 * q[0] * q[1] + 2 * q[2] * q[3];
    matrix[6] = - 2 * q[0] * q[2] + 2 * q[1] * q[3];
    matrix[7] =   2 * q[0] * q[1] + 2 * q[2] * q[3];
    matrix[8] = powf(q[0], 2) - powf(q[1], 2) - powf(q[2], 2) + powf(q[3], 2);
}


void hamilton_prod(const float *const q1, const float *const q2, float *const qp){
    qp[0] = q1[0] * q2[0] - q1[1] * q2[1] - q1[2] * q2[2] - q1[3] * q2[3];
    qp[1] = q1[0] * q2[1] + q1[1] * q2[0] + q1[2] * q2[3] - q1[3] * q2[2];
    qp[2] = q1[0] * q2[2] - q1[1] * q2[3] + q1[2] * q2[0] + q1[3] * q2[1];
    qp[3] = q1[0] * q2[3] + q1[1] * q2[2] - q1[2] * q2[1] + q1[3] * q2[0];
}


void ekf_TRIAD(void){
    float J[12], v_tmp[16], acc_norm[3], mag_norm[3];
    float mD, mN, Zm1_num, tmp4;

    norm_mag(mag_norm, Rz, mag_buff_iter); // Rm_n
    
    norm_acc(acc_norm, v_tmp); // Ra_n

    // TRIAD
    // add acc to measure
    memcpy(&z[0], acc_norm, sizeof(float) * 3);
    // compute 4th measure
    mD = acc_norm[0]*mag_norm[0]+acc_norm[1]*mag_norm[1]+acc_norm[2]*mag_norm[2];
    mN = sqrt(1 - powf(mD, 2));
    Zm1_num = acc_norm[1]*mag_norm[2] - acc_norm[2]*mag_norm[1]; //Zm_num
    z[3] = Zm1_num/mN;

    tmp4 = powf(mN, 3); // mN^3
    
    // uncertainty propagation

    // acc contribution
    J[0] = 1;
    J[1] = 0;
    J[2] = 0;
    J[3] = 0;
    J[4] = 1;
    J[5] = 0;
    J[6] = 0;
    J[7] = 0;
    J[8] = 1;
    J[9] = Zm1_num * mD * mag_norm[0] / tmp4;
    J[10] = mag_norm[2] / mN + Zm1_num * mD * mag_norm[1] / tmp4;
    J[11] = - mag_norm[1] / mN + Zm1_num * mD * mag_norm[2] / tmp4 ;
    quadratic_form(J, v_tmp, v_tmp, 4, 3); // J_ZA * Ra_n * J_ZA^t

    // mag contribution
    J[0] = 0;
    J[1] = 0;
    J[2] = 0;
    J[3] = 0;
    J[4] = 0;
    J[5] = 0;
    J[6] = 0;
    J[7] = 0;
    J[8] = 0;
    J[9] = Zm1_num * mD * acc_norm[0] / tmp4;
    J[10] = - acc_norm[2] / mN + Zm1_num * mD * acc_norm[1] / tmp4;
    J[11] = acc_norm[1] / mN + Zm1_num * mD * acc_norm[2] / tmp4 ;
    quadratic_form(J, Rz, Rz, 4, 3); // J_ZM * Rm_n * J_ZM^t    

    for(uint8_t i=0; i<4*4; i++) Rz[i] += v_tmp[i];

}


void ekf_init_att(void){ 
    float J[12], v_tmp[9], acc_norm[3], mag_norm[3];
    float tmp, tmp2, tmp3;
    // get z0..z4
    
    norm_mag(mag_norm, Rz, mag_buff_iter); // Rm_n
    norm_acc(acc_norm, v_tmp); // Ra_n

    // add acc to measure z0..z2
    memcpy(&z[0], acc_norm, sizeof(float) * 3);

    // z3, z4 without dividing by mN
    tmp = 0;
    for(uint8_t i=0; i<3; i++) tmp += acc_norm[i] * mag_norm[i]; // mD
    tmp2 = acc_norm[1]*mag_norm[2] - acc_norm[2]*mag_norm[1]; // Zm1_num, z3
    tmp3 = mag_norm[0] - tmp * acc_norm[0]; // Zm2_num, z4
    tmp = powf(tmp2, 2) + powf(tmp3, 2);

    // variance propagation

    // acc contribuion
    J[0] = 0;
    J[1] = acc_norm[2] / (powf(acc_norm[1],2) + powf(acc_norm[2],2));
    J[2] = - acc_norm[1] / (powf(acc_norm[1],2) + powf(acc_norm[2],2));
    J[3] = -1 / sqrtf(1 - powf(acc_norm[0],2));
    J[4] = 0;
    J[5] = 0;
    J[6] = tmp2*(2*acc_norm[0]*mag_norm[0] + acc_norm[1]*mag_norm[1] + acc_norm[2]*mag_norm[2]) / tmp;
    J[7] = (tmp2*acc_norm[0]*mag_norm[1] + tmp3*mag_norm[2]) / tmp;
    J[8] = (tmp2*acc_norm[0]*mag_norm[2] - tmp3*mag_norm[1]) / tmp;
    quadratic_form(J, v_tmp, v_tmp, 3, 3); // J_eul_A * Ra_n * J_eul_A.t

    // mag contribution
    J[0] = 0;
    J[1] = 0;
    J[2] = 0;
    J[3] = 0;
    J[4] = 0;
    J[5] = 0;
    J[6] = -(1 - powf(acc_norm[0], 2)) * tmp2 / tmp;
    J[7] = (tmp2*acc_norm[0]*acc_norm[1] - tmp3*acc_norm[2]) / tmp;
    J[8] = (tmp2*acc_norm[0]*acc_norm[2] + tmp3*acc_norm[1]) / tmp;
    quadratic_form(J, Rz, Rz, 3, 3); // J_eul_M * Rm_n * J_eul_M.t    
    
    // eul angles variance
    for(uint8_t i=0; i<3; i++) for(uint8_t j=0; j<3; j++) Rz[i*3 + j] += v_tmp[i*3 + j]; // Rz <- Reul

    // eul angles
    tmp3 = atan2f(tmp2, tmp3); // psi
    tmp = atan2f(z[1], z[2]); // phi
    tmp2 = asinf(-z[0]); // theta
    
    // eul -> quat
    ekf_eul2quat(&tmp, &tmp2, &tmp3, X_att);

    // quat uncertainty
    J[0] =  -sinf(tmp/2)*cosf(tmp2/2)*cosf(tmp3/2)/2 + cosf(tmp/2)*sinf(tmp2/2)*sinf(tmp3/2)/2; 
    J[1] =  -cosf(tmp/2)*sinf(tmp2/2)*cosf(tmp3/2)/2 + sinf(tmp/2)*cosf(tmp2/2)*sinf(tmp3/2)/2; 
    J[2] =  -cosf(tmp/2)*cosf(tmp2/2)*sinf(tmp3/2)/2 + sinf(tmp/2)*sinf(tmp2/2)*cosf(tmp3/2)/2; 
    J[3] =   cosf(tmp/2)*cosf(tmp2/2)*cosf(tmp3/2)/2 + sinf(tmp/2)*sinf(tmp2/2)*sinf(tmp3/2)/2; 
    J[4] =  -sinf(tmp/2)*sinf(tmp2/2)*cosf(tmp3/2)/2 - cosf(tmp/2)*cosf(tmp2/2)*sinf(tmp3/2)/2; 
    J[5] =  -sinf(tmp/2)*cosf(tmp2/2)*sinf(tmp3/2)/2 - cosf(tmp/2)*sinf(tmp2/2)*cosf(tmp3/2)/2; 
    J[6] =  -sinf(tmp/2)*sinf(tmp2/2)*cosf(tmp3/2)/2 + cosf(tmp/2)*cosf(tmp2/2)*sinf(tmp3/2)/2; 
    J[7] =   cosf(tmp/2)*cosf(tmp2/2)*cosf(tmp3/2)/2 - sinf(tmp/2)*sinf(tmp2/2)*sinf(tmp3/2)/2; 
    J[8] =  -cosf(tmp/2)*sinf(tmp2/2)*sinf(tmp3/2)/2 + sinf(tmp/2)*cosf(tmp2/2)*cosf(tmp3/2)/2; 
    J[9] =  -sinf(tmp/2)*cosf(tmp2/2)*sinf(tmp3/2)/2 - cosf(tmp/2)*sinf(tmp2/2)*cosf(tmp3/2)/2; 
    J[10] = -cosf(tmp/2)*sinf(tmp2/2)*sinf(tmp3/2)/2 - sinf(tmp/2)*cosf(tmp2/2)*cosf(tmp3/2)/2; 
    J[11] =  cosf(tmp/2)*cosf(tmp2/2)*cosf(tmp3/2)/2 + sinf(tmp/2)*sinf(tmp2/2)*sinf(tmp3/2)/2;
    quadratic_form(J, Rz, P_att, 4, 3);
}


#ifndef NO_POS

void ekf_uwb2meas(void){
    // Set Rz to zeros
    for(uint8_t i=0; i<4*4; i++) Rz[i] = 0;

    if(uwb_buff_iter > 0){ // 1 measure
        // x, y pos, first sample
        memcpy(&z[0], uwb_data[0], sizeof(float) * 2);
        // uncertainty
        Rz[0] = uwb_config->unc[0];
        Rz[5] = uwb_config->unc[1];
    }
    else{ // 2 measures
        // x, y pos, second sample
        memcpy(&z[0], uwb_data[1], sizeof(float) * 2);
        // x, y vel
        float dt_vel = ekf_compute_dt(pos_tick[0], pos_tick[1]);
        z[2] = (uwb_data[1][0] - uwb_data[0][0]) / dt_vel;
        z[3] = (uwb_data[1][1] - uwb_data[0][1]) / dt_vel;
        // uncertainty
        float tmp = powf(dt_vel, 2);
        Rz[0] = uwb_config->unc[0];
        Rz[5] = uwb_config->unc[1];
        Rz[10] = uwb_config->unc[0] * 2 / tmp;
        Rz[15] = uwb_config->unc[1] * 2 / tmp;
    }
}

#endif

#pragma endregion


#pragma region // -- filter

void ekf_att_prediction(void){
    float J[12], v_tmp[16], v1[3], v2[3];
    float tmp, tmp2, tmp3;

    //normalize mag data
    norm_mag(v1, Rz, 1); // second
    norm_mag(v2, v_tmp, 0); // first

    // compute quaternion rotating from the second mag vector to the first one: v1 -> v2
    /* https://stackoverflow.com/questions/1171849/finding-quaternion-representing-the-rotation-from-one-vector-to-another*/
    
    tmp = powf(norm2(v1, 3), 2);
    tmp2 = powf(norm2(v2, 3), 2);
    tmp3 = sqrt(tmp * tmp2); 

    // uncertainty
    // second mag data
    J[0]  =   v1[0] * tmp2 / tmp3 + v2[0];
    J[1]  =   v1[1] * tmp2 / tmp3 + v2[1];
    J[2]  =   v1[2] * tmp2 / tmp3 + v2[2];
    J[3]  =   0;
    J[4]  =   v2[2];
    J[5]  = - v2[1];
    J[6]  = - v2[2];
    J[7]  =   0;
    J[8]  =   v2[0];
    J[9]  =   v2[1];
    J[10] = - v2[0];
    J[11] =   0;
    quadratic_form(J, Rz, Rz, 4, 3);
    // first mag data
    J[0]  =   v2[0] * tmp / tmp3 + v1[0];
    J[1]  =   v2[1] * tmp / tmp3 + v1[1];
    J[2]  =   v2[2] * tmp / tmp3 + v1[2];
    J[3]  =   0;
    J[4]  = - v1[2];
    J[5]  =   v1[1];
    J[6]  =   v1[2];
    J[7]  =   0;
    J[8]  = - v1[0];
    J[9]  = - v1[1];
    J[10] =   v1[0];
    J[11] =   0;
    quadratic_form(J, v_tmp, v_tmp, 4, 3);
    // tot
    for(uint8_t i=0; i<4*4; i++) Rz[i] += v_tmp[i];

    // value
    z[0] = tmp3 + v1[0] * v2[0] + v1[1] * v2[1] + v1[2] * v2[2];
    cross_prod3(v1, v2, &z[1]);

    // normalize
    normalize(z, 4); // q_rot
    // uncertainty
    J_normalization(z, 4, J);
    quadratic_form(J, Rz, Rz, 4, 4);

    // apply it on current attitude
    /**
     * The attitude quaternion expresses the rotation from local to global frame.
     * The rotation to be computed is G <- L(k) <- L(k+1)
     * q_rot expresses the rotation from L(k+1) to L(k)
     * X_att expresses the rotation from L(k) to G
     * In order to obtain the rotation from L(k+1) to G the rotations must be 
     * applied in the order q_rot, X_att (q1, q2).
     * Two consecutive rotations represented by quaternions can be concatenated by using
     * the Hamilton product as follows: q' = q2*q1 -> rotation q1 followed by q2
     * (https://en.wikipedia.org/wiki/Quaternions_and_spatial_rotation)
     * 
     */

    // uncertainty
    // rotating quaternion
    v_tmp[0]  =   X_att[0];
    v_tmp[1]  = - X_att[1];
    v_tmp[2]  = - X_att[2];
    v_tmp[3]  = - X_att[3];
    v_tmp[4]  =   X_att[1];
    v_tmp[5]  =   X_att[0];
    v_tmp[6]  = - X_att[3];
    v_tmp[7]  =   X_att[2];
    v_tmp[8]  =   X_att[2];
    v_tmp[9]  =   X_att[3];
    v_tmp[10] =   X_att[0];
    v_tmp[11] = - X_att[1];
    v_tmp[12] =   X_att[3];
    v_tmp[13] = - X_att[2];
    v_tmp[14] =   X_att[1];
    v_tmp[15] =   X_att[0];
    quadratic_form(v_tmp, Rz, Rz, 4, 4);
    // previous attitude
    v_tmp[0]  =   z[0];
    v_tmp[1]  = - z[1];
    v_tmp[2]  = - z[2];
    v_tmp[3]  = - z[3];
    v_tmp[4]  =   z[1];
    v_tmp[5]  =   z[0];
    v_tmp[6]  =   z[3];
    v_tmp[7]  = - z[2];
    v_tmp[8]  =   z[2];
    v_tmp[9]  = - z[3];
    v_tmp[10] =   z[0];
    v_tmp[11] =   z[1];
    v_tmp[12] =   z[3];
    v_tmp[13] =   z[2];
    v_tmp[14] = - z[1];
    v_tmp[15] =   z[0];
    quadratic_form(v_tmp, P_att, P_att, 4, 4);
    // tot
    for(uint8_t i=0; i<4*4; i++) P_att[i] += Rz[i];

    // value
    memcpy(J, X_att, sizeof(float) * 4);
    hamilton_prod(J, z, X_att);

}


void ekf_att_update(void){
    float J[16], S[16], W[16];

    // get z measurements
    ekf_TRIAD(); 

    // innovation
    z[0] -= - 2 * X_att[2] * X_att[0] + 2 * X_att[3] * X_att[1];
    z[1] -=   2 * X_att[1] * X_att[0] + 2 * X_att[3] * X_att[2];
    z[2] -=   powf(X_att[0], 2) - powf(X_att[1], 2) - powf(X_att[2], 2) + powf(X_att[3], 2);
    z[3] -=   2 * X_att[3] * X_att[0] + 2 * X_att[2] * X_att[1];

    // Jh
    J[0]  = - X_att[2] * 2;
    J[1]  =   X_att[3] * 2;
    J[2]  = - X_att[0] * 2;
    J[3]  =   X_att[1] * 2;
    J[4]  =   X_att[1] * 2;
    J[5]  =   X_att[0] * 2;
    J[6]  =   X_att[3] * 2;
    J[7]  =   X_att[2] * 2;
    J[8]  =   X_att[0] * 2;
    J[9]  = - X_att[1] * 2;
    J[10] = - X_att[2] * 2;
    J[11] =   X_att[3] * 2;
    J[12] =   X_att[3] * 2;
    J[13] =   X_att[2] * 2;
    J[14] =   X_att[1] * 2;
    J[15] =   X_att[0] * 2;

    // Kalman steps
    quadratic_form(J, P_att, S, 4, 4);
    for(uint8_t i=0; i<4*4; i++) S[i] += Rz[i]; // S
    //self_transpose(J, 4, 4); // J.t
    matrix_mult_T(P_att, J, Rz, 4, 4, 4); // Rz <- P_att * J.t
    inverse(S, S, 4); // S^-1
    matrix_mult(Rz, S, W, 4, 4, 4); // W = P_att * J.t / S

    // X_att
    matrix_mult(W, z, S, 4, 1, 4); // S <- W * inn
    for(uint8_t i=0; i<4; i++) X_att[i] += S[i];
    normalize(X_att, 4);

    // P_att
    //self_transpose(J, 4, 4); // J
    matrix_mult(W, J, S, 4, 4, 4); // S <- W * J
    for(uint8_t i=0; i<4*4; i++) S[i] = -S[i]; // S <- - W * J ;
    for(uint8_t i=0; i<4; i++) S[i*5] += 1.0; // S <- I - W * J;
    matrix_mult(S, P_att, J, 4, 4, 4); // J <- P_att
    memcpy(P_att, J, sizeof(float)*16);
}


#ifndef NO_POS

void ekf_pos_prediction(void){
    float tmp[16], Ra[9];
    float dt2 = powf(dt, 2) / 2;

    // get extern acc
    ekf_quat2rotM(X_att, tmp);
    matrix_mult(tmp, acc_data, z, 3, 1, 3);
    z[2] -= EKF_G_MAGNITUDE;
    // convert to [m/s^2]
    for(uint8_t i=0; i<3; i++) z[i] *= EKF_MG_TO_MS2;
    // uncertainty
    // acc contribution
    v2diag_m(acc_config->unc, Ra, 3);
    quadratic_form(tmp, Ra, Ra, 3, 3);
    // X_att contribution
    tmp[0] =    2 * X_att[0] * acc_data[0] - 2 * X_att[3] * acc_data[1] + 2 * X_att[2] * acc_data[2];
    tmp[1] =    2 * X_att[1] * acc_data[0] + 2 * X_att[2] * acc_data[1] + 2 * X_att[3] * acc_data[2];
    tmp[2] =  - 2 * X_att[2] * acc_data[0] + 2 * X_att[1] * acc_data[1] + 2 * X_att[0] * acc_data[2];
    tmp[3] =  - 2 * X_att[3] * acc_data[0] - 2 * X_att[0] * acc_data[1] + 2 * X_att[1] * acc_data[2];
    tmp[4] =    2 * X_att[3] * acc_data[0] + 2 * X_att[0] * acc_data[1] - 2 * X_att[1] * acc_data[2];
    tmp[5] =    2 * X_att[2] * acc_data[0] - 2 * X_att[1] * acc_data[1] - 2 * X_att[0] * acc_data[2];
    tmp[6] =    2 * X_att[1] * acc_data[0] + 2 * X_att[2] * acc_data[1] + 2 * X_att[3] * acc_data[2];
    tmp[7] =    2 * X_att[0] * acc_data[0] - 2 * X_att[3] * acc_data[1] + 2 * X_att[2] * acc_data[2];
    tmp[8] =  - 2 * X_att[2] * acc_data[0] + 2 * X_att[1] * acc_data[1] + 2 * X_att[0] * acc_data[2];
    tmp[9] =    2 * X_att[3] * acc_data[0] + 2 * X_att[0] * acc_data[1] - 2 * X_att[1] * acc_data[2];
    tmp[10] = - 2 * X_att[0] * acc_data[0] + 2 * X_att[3] * acc_data[1] - 2 * X_att[2] * acc_data[2];
    tmp[11] =   2 * X_att[1] * acc_data[0] + 2 * X_att[2] * acc_data[1] + 2 * X_att[3] * acc_data[2];
    quadratic_form(tmp, P_att, Rz, 3, 4);
    for(uint8_t i=0; i<3*3; i++) Ra[i] = (Ra[i] + Rz[i]) * powf(EKF_MG_TO_MS2, 2);

    // X_pos prediction
    X_pos[0] += X_pos[2] * dt + z[0] * dt2;
    X_pos[1] += X_pos[3] * dt + z[1] * dt2;
    X_pos[2] +=                 z[0] * dt;
    X_pos[3] +=                 z[1] * dt;

    dt2 *= 2;
    float dt3 = powf(dt, 3), dt4 = powf(dt, 4);
    // P_pos   
    tmp[0]  = dt  * P_pos[8]  + P_pos[0]  + (dt * P_pos[10] + P_pos[2]) * dt + dt4 * Ra[0] / 4;  
    tmp[1]  = dt  * P_pos[9]  + P_pos[1]  + (dt * P_pos[11] + P_pos[3]) * dt + dt4 * Ra[1] / 4; 
    tmp[2]  = dt  * P_pos[10] + P_pos[2]  + dt3 * Ra[0] / 2; 
    tmp[3]  = dt  * P_pos[11] + P_pos[3]  + dt3 * Ra[1] / 2; 
    tmp[4]  = dt  * P_pos[12] + P_pos[4]  + (dt * P_pos[14] + P_pos[6]) * dt + dt4 * Ra[3] / 4; 
    tmp[5]  = dt  * P_pos[13] + P_pos[5]  + (dt * P_pos[15] + P_pos[7]) * dt + dt4 * Ra[4] / 4; 
    tmp[6]  = dt  * P_pos[14] + P_pos[6]  + dt3 * Ra[3] / 2; 
    tmp[7]  = dt  * P_pos[15] + P_pos[7]  + dt3 * Ra[4] / 2; 
    tmp[8]  = dt  * P_pos[10] + P_pos[8]  + dt3 * Ra[0] / 2; 
    tmp[9]  = dt  * P_pos[11] + P_pos[9]  + dt3 * Ra[1] / 2; 
    tmp[10] = dt2 * Ra[0]     + P_pos[10]; 
    tmp[11] = dt2 * Ra[1]     + P_pos[11];
    tmp[12] = dt  * P_pos[14] + P_pos[12] + dt3 * Ra[3] / 2; 
    tmp[13] = dt  * P_pos[15] + P_pos[13] + dt3 * Ra[4] / 2; 
    tmp[14] = dt2 * Ra[3]     + P_pos[14]; 
    tmp[15] = dt2 * Ra[4]     + P_pos[15];
    memcpy(P_pos, tmp, sizeof(float) * 16);
}


void ekf_pos_update(void){
    // load uwb measures in z and Rz
    ekf_uwb2meas();

    if(uwb_buff_iter > 0){ // 1 measure
        float S[4], W[4];
        // innovation
        z[0] -= X_pos[0];
        z[1] -= X_pos[1];

        // Kalman steps
        for(uint8_t i=0; i<2; i++) for(uint8_t j=0; j<2; j++) S[i*2+j] = P_pos[i*4+j] + Rz[i*4+j];
        inverse(S, S, 2); // S^-1
        for(uint8_t i=0; i<2; i++) for(uint8_t j=0; j<2; j++){
            W[i*2+j] = 0;
            for(uint8_t k=0; k<2; k++) W[i*2+j] += P_pos[i*4+k] * S[k*2+j];
        }

        // X_pos
        matrix_mult(W, z, S, 2, 1, 2);
        for(uint8_t i=0; i<2; i++) X_pos[i] += S[i];

        // P_pos
        S[0] = (1-W[0]) * P_pos[0] - W[1] * P_pos[4];
        S[1] = (1-W[0]) * P_pos[1] - W[1] * P_pos[5];
        S[2] = (1-W[3]) * P_pos[4] - W[2] * P_pos[0];
        S[3] = (1-W[3]) * P_pos[5] - W[2] * P_pos[1];
        for(uint8_t i=0; i<2; i++) for(uint8_t j=0; j<2; j++) P_pos[i*4+j] = S[i*2+j];

    }
    else{ // 2 measures
        float S[16], W[16];
        // innovation
        for(uint8_t i=0; i<4; i++) z[i] -= X_pos[i];

        // Kalman steps
        for(uint8_t i=0; i<4*4; i++) S[i] = P_pos[i] + Rz[i];
        inverse(S, S, 4); // S^-1
        matrix_mult(P_pos, S, W, 4, 4, 4); // W

        // X_pos
        matrix_mult(W, z, S, 4, 1, 4);
        for(uint8_t i=0; i<4; i++) X_pos[i] += S[i];

        // P_pos
        for(uint8_t i=0; i<4; i++) for(uint8_t j=0; j<4; j++){
            if(i==j) S[i*4+j] = 1 - W[i*4+j];
            else S[i*4+j] = - W[i*4+j];
        }
        matrix_mult(S, P_pos, W, 4, 4, 4);
        memcpy(P_pos, W, sizeof(float)*16);
    }
}

#endif

#pragma endregion

#pragma endregion


#pragma region /* Public functions ---------------------------------------------------------*/

uint32_t ekf_init(float *const ret){
    uint32_t err;

    acc_config = man_fds_get_acc_config();
    mag_config = man_fds_get_mag_config();
#ifndef NO_POS
    uwb_config = man_fds_get_uwb_config();
#endif
    // -- init state matrices

#ifndef NO_POS
    // get 2 * uwb data
    ekf_get2_uwb_data();
#endif

    // get acc and mag data
    err = ekf_get_acc_mag_data();

    if(err) {/* Manage error */}
    else ekf_init_att(); // init attitude

#ifdef DEBUG_ON
    memcpy(ret, X_att, sizeof(float) * 4);
#endif

#ifndef NO_POS
    // init position
    ekf_uwb2meas();
    memcpy(X_pos, z, sizeof(float) * 4);
    memcpy(P_pos, Rz, sizeof(float) * 16);
#endif

    return NRF_SUCCESS;
}


void ekf_step(float *const ret){
    uint32_t err, uwb_err;

#ifndef NO_POS
    // get 1 uwb data
    uwb_err = ekf_get1_uwb_data();
#endif

    // get acc and mag data
    err = ekf_get_acc_mag_data();
    if(err) {/* Manage error */}
#ifdef DEBUG_ON
    printf("cal_a:\t%3.2f\t%3.2f\t%3.2f", acc_data[0], acc_data[1],acc_data[2]);
    printf("\tcal_m:\t%3.2f\t%3.2f\t%3.2f", mag_data[mag_buff_iter][0], mag_data[mag_buff_iter][1],mag_data[mag_buff_iter][2]);
#endif
    // -- attitude
    if(mag_buff_iter == 1){
      ekf_att_prediction(); // use mag for prediction
    }
    /** increase unc based on dt:
     * usual attitude pred: (S_omega*dt/2 * + eye(4)) * X_att(1:4, k)
     * with S_omega skew matrix of the gyroscope, 
     * hp: max gyro reading ~ 1 rad/s
     * -> norm2 of S*dt/2 * is 3*dt/2: multiply P_att by (1 + 3*dt/2)^2
     */ 
    else{ 
        float tmp = powf(1 + 3*dt/2, 2);
        // cap at 1.03 -> dt = 0.01 [s] (for debug mode)
        tmp = MIN(1.03, tmp);
        //ret[5] = tmp;
        for(uint8_t i=0; i<4; i++) P_att[i*5] *= tmp; // only diagonal
        ekf_att_update();
        //ekf_init_att();
    }

    // force the quaternion to be with positive fourth component
    //if(X_att[3] < 0) for(uint8_t i=0; i<4; i++) X_att[i] = -X_att[i];

#ifdef DEBUG_ON
    // return for debugging
    memcpy(ret, X_att, sizeof(float) * 4);
    ret[4] = dt;

    // extern acc for debug
    float tmp[9];
    // rotation matrix local -> global
    ekf_quat2rotM(X_att, tmp);
    // rotate local acc in global frame
    matrix_mult(tmp, acc_data, z, 3, 1, 3);
    // eliminate gravity
    z[2] -= EKF_G_MAGNITUDE;
    // convert from milli_g to m/s^2
    for(uint8_t i=0; i<3; i++) z[i] *= EKF_MG_TO_MS2;
    memcpy(&ret[5], z, sizeof(float) * 3);
    ret[8] = mag_buff_iter;
#endif

#ifndef NO_POS
    // -- position
    ekf_pos_prediction();
    if(! uwb_err) ekf_pos_update();
#endif

}

#pragma endregion