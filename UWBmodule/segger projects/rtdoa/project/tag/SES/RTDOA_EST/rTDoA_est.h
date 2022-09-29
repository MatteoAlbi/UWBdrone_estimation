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

/**
 * @brief given timestamp in matrix form, compute 
 * the tag position and saves it in x_t
 * 
 * @param ts matrix of timestamp in format
 *          rows: anchors
 *          columns: rx1 rx2 tx1 tx2
 * @param x_t initialized array double[3] where results are saved
 */
bool rTDoA(uint64_t ts_uint64[NUM_ANCH][4]);


#endif