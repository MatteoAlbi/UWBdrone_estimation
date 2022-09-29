#ifndef RTDOA_EST
#define RTDOA_EST

#include <stdio.h>
#include <math.h>
#include <stdint.h>
#include <stdbool.h>

#include "linearAlgebra.h"

//#define DEBUG
//#define TEST

#define NUM_ANCH	    6
#define SPEED_OF_LIGHT  299702547

#ifndef TEST                            
#define TIME_CONST  (63.8976 * 1000000000)
typedef uint64_t ts_type;
#else
#define TIME_CONST 1;
typedef double ts_type;
#endif

extern double anchors_mat[6][3];

/**
 * @brief given timestamp in matrix form, compute 
 * the tag position and saves it in x_t
 * 
 * @param ts matrix of timestamp in format
 *          rows: anchors
 *          columns: rx1 rx2 tx1 tx2
 * @param x_t initialized array double[3] where results are saved
 * @return true if the computation didn't rised exceptions
 * @exception if when computing a pseudoinverse matrix the result is NULL: return false
 * @exception if tx1 = tx2 for any anchors: return false
 * @exception if norm of x_t_0 - anchors_mat = 0: return false
 */
bool rTDoA(ts_type ts_uint64[NUM_ANCH][4],  double *x_t);

#endif