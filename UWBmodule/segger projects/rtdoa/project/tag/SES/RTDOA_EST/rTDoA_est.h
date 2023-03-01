#ifndef RTDOA_EST
#define RTDOA_EST

#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>
#include <string.h>

#include "linearAlgebra.h"
#include "../common/config.h"

//#define DEBUG
                          
#define TIME_CONST  (63.8976 * 1000000000)

#define RTDOA_NO_ERR        0
#define RTDOA_DIV_0         1
#define RTDOA_MAT_NINV      2
#define RTDOA_COMP_ERR      3

#define TDOA_NO_RES         10

#define TDOA_MAX_ACCEPTED_POS   1000.0 //[m]

/**
 * @brief given timestamp in matrix form, compute 
 * the tag position and saves it in x_t
 * 
 * @param ts matrix of timestamp in format
 *          rows: anchors
 *          columns: rx1 rx2 tx1 tx2
 * @param x_t initialized array double[3] where results are saved
 */
bool rTDoA(uint64_t ts_uint64[NUM_ANCH][4], float* buf);


#endif