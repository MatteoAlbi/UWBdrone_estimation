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
 * @param matrix_prod   matrix where save the result dim[r_1 * c_2]
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
 * @param matrix_prod   matrix where save the result dim[r_1 * r_2]
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


/**
 * @brief Compute QR decomposition of the given matrix: A=Q*R 
 *        with Q orthogonal matrix and R upper triangular matrix
 *      //http://matlab.izmiran.ru/help/techdoc/ref/mldivide.html
 *      //https://rpubs.com/aaronsc32/qr-decomposition-householder
 * 
 * @param A matrix to decompose
 * @param r rows of A
 * @param c columns of A
 * @param Q orthogonal matrix
 * @param R upper triangular matrix
 */
void qr_dec(const matrix_data_t *const A, const uint32_t r, const uint32_t c, 
            matrix_data_t *const Q, matrix_data_t *const R);


//https://www.tutorialspoint.com/cplusplus-program-to-perform-lu-decomposition-of-any-matrix
/**
 * @brief Compute LU decomposition of the given matrix: A = L*U with
 *        L lower triangular matrix and U upper triangular matrix
 * 
 * @param A matrix to decompose (must be square)
 * @param n rows of A = columns of A
 * @param L lower triangular matrix
 * @param U upper triangular matrix
 */
void lu_dec(const matrix_data_t *const A, const uint32_t n, 
            matrix_data_t *const L, matrix_data_t *const U);


/**
 * @brief Solve the system U*x=B using a backward substitution algorithm.
 *        U must be an upper triangular square matrix (n*n) and B is the 
 *        known terms matrix with number of rows equalt to U -> B is (n*c_b)
 * 
 * @param U     upper triangular matrix (n*n)
 * @param B     known terms matrix (n*c_b)
 * @param res   matrix where to save the result (n*c_b)
 * @param n     dim of U
 * @param c_b   columns of B
 */
void backward_sub(const matrix_data_t *const U, const matrix_data_t *const B, 
                  matrix_data_t *const res, const uint32_t n, const uint32_t c_b);

/**
 * @brief Solve the system L*x=B using a forward substitution algorithm.
 *        L must be a lower triangular square matrix (n*n) and B is the 
 *        known terms matrix with number of rows equalt to L -> B is (n*c_b)
 * 
 * @param L     lower triangular matrix (n*n)
 * @param B     known terms matrix (n*c_b)
 * @param res   matrix where to save the result (n*c_b)
 * @param n     dim of L
 * @param c_b   columns of B
 */
void forward_sub(const matrix_data_t *const L, const matrix_data_t *const B, 
                 matrix_data_t *const res, const uint32_t n, const uint32_t c_b);


/**
 * @brief computes the left division A\B, which corresponds to solve the 
 *        linear equation system A*x=B. The columns of A must be equal 
 *        the rows of B. The result has dimensions (r_a*c_b).
 *        The functions solves the problem depending on the dimensions of the 
 *        given matrices: 
 *        
 *        - A is a square matrix (r_a*c_r_common): the A amtrix is decomposed using
 *          LU decomposition: A*x=B -> L*U*x = B. Then, the problem is solved by
 *          subsequentially solving the two systems:
 *              - L*(U*x) = B, thus solving it using forward substitution the system 
 *                L*par=B equal to par=L\B
 *              - U*x=par, thus solving it using backward substitution the system 
 *                U*x=par equal to x=U\par
 * 
 * @param A             left hand division term (r_a*c_r_common)
 * @param B             right hand division term (c_r_common*c_b)
 * @param res           result (r_a*c_b)
 * @param r_a           rows of A
 * @param c_b           columns of B
 * @param c_r_common    columsn of A = rows of B
 */
void matrix_l_divide(const matrix_data_t *const A, const matrix_data_t *const B, 
                     matrix_data_t *const res, const uint32_t r_a, const uint32_t c_b, const uint32_t c_r_common);


/**
 * @brief computes the right division B/A translating it in a left 
 *        division problem following the equality B/A = (A.t\B.t).t
 *        where .t stands for transpose. The columns of A must be equal 
 *        the rows of B. The result has dimensions (r_a*c_b).
 *        The functions solves the problem depending on the dimensions of the 
 *        given matrices: 
 * 
 * @param B             left hand division term (r_b*c_r_common)
 * @param A             right hand division term (c_r_common*c_a)
 * @param res           result (r_b*c_a)
 * @param r_b           rows of B
 * @param c_a           columns of A
 * @param c_r_common    columsn of B = rows of A
 */
void matrix_r_divide(const matrix_data_t *const B, const matrix_data_t *const A, 
                     matrix_data_t *const res, const uint32_t r_b, const uint32_t c_a, const uint32_t c_r_common);

#endif