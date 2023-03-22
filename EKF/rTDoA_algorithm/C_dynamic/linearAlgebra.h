#ifndef LINEAR_ALGEBRA
#define LINEAR_ALGEBRA

/**
 * @brief This library works with flattened matrix
 * matrix are saved as vector with dimension row*columns
 * to access an elemnt in matrix[i][j]: flattened_matrix[i * columns + j]
 * 
 */

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>


/**
 * @brief struct that stores matrices/vectors using arrays
 * matrix: r and c > 1
 * column vector: c = 1
 * row vector: r = 1
 * 
 * @param r rows of Matrix
 * @param c columuns of Matrix
 * @param v values of Matrix, dinamically allocated
 */
typedef struct{
    int r;
    int c;
    double * v; 
}Matrix;

/**
 * @brief initialize a matrix with #rows = r, #columns = c
 * v initialized to 0
 * 
 * @param r #rows of Matrix
 * @param c #columns of Matrix
 * @return Matrix* pointer to struct
 */
Matrix * init_matrix(int r, int c);

/**
 * @brief initialize a matrix with #rows = r, #columns = c
 * values of Matrix initialized to v
 * 
 * @param r #rows of Matrix
 * @param c #columns of Matrix
 * @param v values to initialize the matrix
 * @return Matrix* pointer to struct
 */
Matrix * init_matrix_v(int r, int c, double* v);

/**
 * @brief initialize a row vector with #rows = 1, #columns = c
 * v initialized to 0
 * 
 * @param c #columns of Matrix
 * @return Matrix* pointer to struct
 */
Matrix * init_r_vector(int c);

/**
 * @brief initialize a row vector with #rows = 1, #columns = c
 * values of Matrix initialized to v
 * 
 * @param c #columns of Matrix
 * @param v values to initialize the matrix
 * @return Matrix* pointer to struct
 */
Matrix * init_r_vector_v(int c, double* v);

/**
 * @brief initialize of column vector with #rows = r, #columns = 1
 * v initialized to 0
 * 
 * @param r #rows of Matrix
 * @return Matrix* pointer to struct
 */
Matrix * init_c_vector(int r);

/**
 * @brief initialize of column vector with #rows = r, #columns = 1
 * values of Matrix initialized to v
 * 
 * @param r #rows of Matrix
 * @param v values to initialize the matrix
 * @return Matrix* pointer to struct
 */
Matrix * init_c_vector_v(int r, double* v);

/**
 * @brief deallocate pointer to matrix
 * first must deallocate v
 * 
 * @param m pointer to input matrix
 */
void del_matrix(Matrix * m);

/**
 * @brief print to terminal matrix in table format
 * 
 * @param matrix pointer to matrix to display
 * @param r n of row of matrix
 * @param c n of column of matrix
 */
void display_flat_matrix(Matrix *m);

/**
 * @brief return transpose of m 
 * 
 * @param m pointer to input matrix
 * @return Matrix* transpose of m
 */
Matrix * transpose(Matrix *m);

/**
 * @brief return result of matrix product m1*m2
 * 
 * @param m1 pointer to first input matrix
 * @param m2 pointer to second input matrix
 * @return Matrix* product of m1 and m2
 * @exception if #column m1 != #row m2: return NULL 
 */
Matrix * matrix_prod(Matrix *m1, Matrix *m2);

/**
 * @brief Get the cofactor matrix of m wrt to the 
 * row p and column q
 * 
 * @param m pointer to input matrix
 * @param p row wrt compute cofactor matrix
 * @param q column wrt compute cofactor matrix
 * @return Matrix* cofactor matrix of m
 * @exception if p > #row m or q > #column m: return NULL
 */
Matrix * get_cofactor(Matrix *m, int p, int q);

/**
 * @brief Recursive function to find determinant of m
 * m must be square
 * 
 * @param m pointer to input matrix
 * @return double determinant of m
 * @exception if m isn't square: return 0
 */
double determinant(Matrix *m);

/**
 * @brief compute adjoint of m
 * m must be square
 * 
 * @param m pointer to input matrix
 * @return Matrix* adjoint of m
 * @exception if m isn't square: return NULL
 */
Matrix * adjoint(Matrix *m);

/**
 * @brief compute inverse of matrix m
 * m must be square
 * 
 * @param m pointer to input matrix
 * @return Matrix* inverse of m
 * @exception if m isn't square: return NULL
 * @exception if determinant of m = 0: return NULL
 */
Matrix * inverse(Matrix *m);

/**
 * @brief compute pseudoinverse of m
 * 
 * @param m pointer to input matrix
 * @return Matrix* pseudoinverse of m
 * @exception if determinant of (m transpose * m) = 0: return NULL
 */
Matrix * pseudoinverse(Matrix *m);

#endif