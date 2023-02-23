/*! ----------------------------------------------------------------------------
 *  @file    linear_algebra.h
 *  @brief   This file contains all the functions prototypes for the
 *           linear_algebra.c library.
 *
 * 
 * @attention This library works with flattened matrix;
 *            matrix are saved as vector with dimension row*columns;
 *            to access an elemnt in matrix[i][j]: flattened_matrix[i * columns + j]
 *
 *
 * @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
 */


#ifndef LINEAR_ALGEBRA
#define LINEAR_ALGEBRA

#include <stdio.h>
#include <stdbool.h>
#include <math.h>
#include <string.h>

typedef unsigned int uint32_t;
typedef float matrix_data_t;


/**
 * @brief print to terminal matrix in table format
 * 
 * @param matrix      matrix to display
 * @param r           n of rows of matrix
 * @param c           n of columns of matrix
 *
 */
void display_flat_matrix(const matrix_data_t *const matrix, const uint32_t r, const uint32_t c);


/**
 * @brief compute the norm of the passed vector
 * 
 * @param v           vector to which compute the norm
 * @param n           n of elements of vector
 * @return matrix_data_t 
 */
matrix_data_t norm2(const matrix_data_t *const v, const uint32_t n);


/**
 * @brief normalize the vector v
 *  
 * @param v     vector to normalize
 * @param n     vector length
 */
void normalize(matrix_data_t *const v, const uint32_t n);


/**
 * @brief compute transpose of matrix and save it in t_matrix
 *        NB: t_matrix must be different from matrix
 * 
 * @param matrix      input matrix
 * @param t_matrix    matrix where save transpose
 * @param r           n of rows of matrix
 * @param c           n of columns of matrix
 *
 */
void transpose(const matrix_data_t *const matrix, matrix_data_t *const t_matrix, const uint32_t r, const uint32_t c);


/**
 * @brief modify matrix in its transpose,
 * 
 * @param matrix      input matrix
 * @param r           n of rows of matrix
 * @param c           n of columns of matrix
 *
 */
void self_transpose(matrix_data_t *const matrix, const uint32_t r, const uint32_t c);


/**
 * @brief compute matrix multiplication matrix_1 * matrix_2
 *        NB: matrix_prod must be different from matrix_1 and matrix_2
 * 
 * @param matrix_1      input matrix 1
 * @param matrix_2      input matrix 2
 * @param matrix_prod   matrix where save the result
 * @param r_1           number of rows of matrix_1
 * @param c_2           number of columns of matrix_2
 * @param r_c_common    number of rows of matrix_2 = number of columns of matrix_1
 *
 */
void matrix_mult(const matrix_data_t *const matrix_1, const matrix_data_t *const matrix_2, 
                 matrix_data_t *const matrix_product, const uint32_t r_1, const uint32_t c_2, const uint32_t r_c_common);


/**
 * @brief compute matrix multiplication matrix_1 * matrix_2.t (second matrix is transposed)
 *        NB: matrix_prod must be different from matrix_1 and matrix_2
 * 
 * @param matrix_1      input matrix 1
 * @param matrix_2      input matrix 2
 * @param matrix_prod   matrix where save the result
 * @param r_1           number of rows of matrix_1
 * @param r_2           number of rows of matrix_2
 * @param c_c_common    number of columns of matrix_2 = number of columns of matrix_1
 *
 */
void matrix_mult_T(const matrix_data_t *const matrix_1, const matrix_data_t *const matrix_2, 
                   matrix_data_t *const matrix_product, const uint32_t r_1, const uint32_t r_2, const uint32_t c_c_common);


/**
 * @brief Compute quadratic form q_form = m1 * m2 * m1.t
 *        NB: m2 shape is square [n_columns(m1), n_columns(m1)]
 *            m2 can be equal to q_form
 *            m1 is changed in its transpose
 * 
 * @param m1 first matrix (outer factors)
 * @param m2 second matrix (middle factor)
 * @param q_form matrtix where save the result: square matrix [n_rows(m1), n_rows(m1)]
 * @param r n_rows(m1)
 * @param c n_columns(m1)
 */
void quadratic_form(const matrix_data_t *const m1, const matrix_data_t *const m2, 
                    matrix_data_t *const q_form, const uint32_t r, const uint32_t c);


/**
 * @brief Compute the cross produc vp = v1 x v2 (only for 3d vectors)
 *        NB: vp must be different from v1 and v2
 * 
 * @param v1 first input vector
 * @param v2 second input vector
 * @param vp vector where save the result
 */
void cross_prod3(const matrix_data_t *const v1, const matrix_data_t *const v2, matrix_data_t *const vp);


/**
 * @brief Function to get cofactor, compute cofactor A(p,q) and saves it in temp
 *        temp supposed to be of dim(n-1,n-1)
 *
 * @param A      input matrix
 * @param cof   matrix where save the result
 * @param p      row for which compute the cofactor
 * @param q      column for which compute the cofactor
 * @param dim    dim of A (supposed to be square)
 *
 */
void get_cofactor(const matrix_data_t *const A, matrix_data_t *const cof, const uint32_t p, 
                  const uint32_t q, const uint32_t dim);

/** 
 * @brief Recursive function to find determinant of matrix A (supposed to be square)
 * 
 * @param A      input matrix
 * @param dim    dim of A (supposed to be square)
 * @retval       determinant of matrix A
 *
 */
matrix_data_t determinant(const matrix_data_t *const A, const uint32_t dim);


/**
 * @brief Compute adjoint of matrix A (supposed to be square)
 *
 * @param A      input matrix
 * @param adj    matrix where save the result
 * @param dim    dim of A (supposed to be square)
 *
 */
void adjoint(const matrix_data_t *const A, matrix_data_t *const adj, const uint32_t dim);


/**
 * @brief Compute inverse of matrix A (supposed to be square)
 *
 * @param A          input matrix
 * @param inverse    matrix where save the result
 * @param dim        dim of A (supposed to be square)
 * @retval           true: able to compute inverse
 *                   false: matrix non-invertible
 *
 */
bool inverse(const matrix_data_t *const A, matrix_data_t *const inverse, const uint32_t dim);


/**
 * @brief Compute pseudoinverse of matrix A
 *
 * @param A          input matrix
 * @param pinv       matrix where save the result
 * @param r          n of rows of A
 * @param c          n of columns of A
 * @retval           true: able to compute inverse
 *                   false: matrix non-invertible
 *
 */
bool pseudoinverse(const matrix_data_t *const A, matrix_data_t *const pinv, const uint32_t r, const uint32_t c);


/**
 * @brief Extract diagonal from matrix
 *
 * @param A    input matrix
 * @param d    vector where save the result
 * @param n    n of elements to extract
 * @param c    n of columns of A
 *
 */
void get_diag(const matrix_data_t *const A, matrix_data_t *const d, const uint32_t n, const uint32_t c);


/**
 * @brief Generate a matrix with diagonal elements equal to the vector
 *
 * @param d    input vector
 * @param A    matrix where save the result
 * @param n    n of elements of d
 *
 */
void v2diag_m(const matrix_data_t *const d, matrix_data_t *const A, const uint32_t n);


#endif