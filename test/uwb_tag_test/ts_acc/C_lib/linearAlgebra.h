#ifndef LINEAR_ALGEBRA
#define LINEAR_ALGEBRA

#include <stdio.h>
#include <stdbool.h>

// #ifndef DEBUG
// #define DEBUG
// #endif

/**
 * @brief This library works with flattened matrix
 * matrix are saved as vector with dimension row*columns
 * to access an elemnt in matrix[i][j]: flattened_matrix[i * columns + j]
 * 
 */

/**
 * @brief print to terminal matrix in table format
 * 
 * @param matrix matrix to display
 * @param r n of row of matrix
 * @param c n of column of matrix
 */
void display_flat_matrix(double *matrix, int r, int c);

void transpose(double *matrix, double *t_matrix, int r, int c);

void matrix_mult(double *matrix_1, double *matrix_2, double *matrix_product, int r_1, int c_2, int r_c_common);

void getCofactor(double *A, double *temp, int p, int q, int dim);

double determinant(double *A, int dim);

void adjoint(double *A,double *adj, int dim);

bool inverse(double *A, double *inverse, int dim);

bool pseudoinverse(double *A, double *pinv, int r, int c);


#endif