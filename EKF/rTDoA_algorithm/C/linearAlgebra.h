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

typedef float matrix_data_t;


/**
  * @brief print to terminal matrix in table format
  * 
  * @param matrix      matrix to display
  * @param r           n of rows of matrix
  * @param c           n of columns of matrix
  *
  */
void display_flat_matrix(matrix_data_t *matrix, uint32_t r, uint32_t c);


/**
 * @brief compute the norm of the passed vector
 * 
 * @param v           vector to which compute the norm
 * @param n           n of elements of vector
 * @return matrix_data_t 
 */
matrix_data_t norm2(matrix_data_t *v, uint32_t n);


/**
  * @brief compute transpose of matrix and save it in t_matrix
  * 
  * @param matrix      input matrix
  * @param t_matrix    matrix where save transpose
  * @param r           n of rows of matrix
  * @param c           n of columns of matrix
  *
  */
void transpose(matrix_data_t *matrix, matrix_data_t *t_matrix, uint32_t r, uint32_t c);


/**
  * @brief modify matrix in its transpose, works onlt for square matrices
  * 
  * @param m        input matrix
  * @param r        dim of matrix (supposed to be square)
  *
  */
void self_transpose_square(matrix_data_t *m, uint32_t n);


/**
  * @brief compute matrix multiplication matrix_1 * matrix_2
  * 
  * @param matrix_1      input matrix 1
  * @param matrix_2      input matrix 2
  * @param matrix_prod   matrix where save the result
  * @param r_1           number of rows of matrix_1
  * @param c_2           number of columns of matrix_2
  * @param r_c_common    number of rows of matrix_2 = number of columsn of matrix_1
  *
  */
void matrix_mult(matrix_data_t *matrix_1, matrix_data_t *matrix_2, matrix_data_t *matrix_product, uint32_t r_1, uint32_t c_2, uint32_t r_c_common);

/**
  * @brief Function to get cofactor, compute cofactor A(p,q) and saves it in temp
  *        temp supposed to be of dim(n-1,n-1)
  *
  * @param A      input matrix
  * @param temp   matrix where save the result
  * @param p      row for which compute the cofactor
  * @param q      column for which compute the cofactor
  * @param dim    dim of A (supposed to be square)
  *
  */
void get_cofactor(matrix_data_t *A, matrix_data_t *temp, uint32_t p, uint32_t q, uint32_t dim);

/** 
  * @brief Recursive function to find determinant of matrix A (supposed to be square)
  * 
  * @param A      input matrix
  * @param dim    dim of A (supposed to be square)
  * @retval       determinant of matrix A
  *
  */
matrix_data_t determinant(matrix_data_t *A, uint32_t dim);


/**
  * @brief Compute adjoint of matrix A (supposed to be square)
  *
  * @param A      input matrix
  * @param adj    matrix where save the result
  * @param dim    dim of A (supposed to be square)
  *
  */
void adjoint(matrix_data_t *A,matrix_data_t *adj, uint32_t dim);

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
bool inverse(matrix_data_t *A, matrix_data_t *inverse, uint32_t dim);

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
bool pseudoinverse(matrix_data_t *A, matrix_data_t *pinv, uint32_t r, uint32_t c);

/**
  * @brief Extract diagonal from matrix
  *
  * @param d    input vector
  * @param A    matrix where save the result
  * @param n    n of elements to extract
  * @param c          n of columns of A
  *
  */
void get_diag(matrix_data_t *A, matrix_data_t *d, uint32_t n, uint32_t c);

/**
  * @brief Generate a matrix with diagonal elements equal to the vector
  *
  * @param d    input vector
  * @param A    matrix where save the result
  * @param n    n of elements of d
  *
  */
void v2diag_m(matrix_data_t *d, matrix_data_t *A, uint32_t n);


#endif