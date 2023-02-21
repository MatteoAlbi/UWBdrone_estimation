/*! ----------------------------------------------------------------------------
*  @file    rTDoA_est.h
*  @brief   This file contains all the functions prototypes for the
*           rTDoA_est.c library.
*
* 
* @attention
*
*
* @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
*/


#ifndef RTDOA_EST
#define RTDOA_EST

#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "linear_algebra.h"
#include "../common/config.h"

/* Macro -----------------------------------------------------------*/

//#define DEBUG
                          
#define TIME_CONST  (63.8976 * 1000000000)

#define RTDOA_NO_ERR        0
#define RTDOA_DIV_0         1
#define RTDOA_MAT_NINV      2
#define RTDOA_COMP_ERR      3

#define TDOA_NO_RES         10

#define TDOA_MAX_ACCEPTED_POS   1000.0 //[m]


/* Functions -------------------------------------------------------*/

/**
 * @brief given timestamp in matrix form, compute 
 * the tag position and saves it in x_t
 * 
 * @param ts matrix of timestamp in format
 *          rows: anchors
 *          columns: rx1 rx2 tx1 tx2
 * @param buf initialized array float[3] where results are saved
 * 
 * @return  RTDOA_NO_ERR if no error occured
 *          RTDOA_DIV_0 if div by  occured
 *          RTDOA_MAT_NINV if a matrix is not invertible
 */
uint32_t rTDoA(uint64_t ts_uint64[NUM_ANCH][4], float* buf);


#endif