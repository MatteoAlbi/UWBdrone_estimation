/*! ----------------------------------------------------------------------------
*  @file    linear_algebra.c
*  @brief   Implementation of basic linear algebra functions to manipulate
*           2D matrices
*
* 
* @attention This library works with flattened matrix;
*            matrix are saved as vector with dimension row*columns;
*            to access an elemnt in matrix[i][j]: flattened_matrix[i * columns + j]
*
*
* @authors	Matteo Albi:            matteo.albi@studenti.unitn.it
*/

#include "linear_algebra.h"


void display_flat_matrix(const matrix_data_t *const matrix, const uint32_t r, const uint32_t c){
    printf("dim: %dx%d\n",r,c);
    for(uint32_t i=0; i<r; i++){
        for(uint32_t j=0; j<c; j++){
            printf("%f ", matrix[i * c + j]);
        }
        printf("\n");
    }
}


matrix_data_t norm2(const matrix_data_t *const v, const uint32_t n){
    matrix_data_t sum = 0;
    for(uint32_t i=0; i<n; i++) sum += powf(v[i], 2);
    return sqrtf(sum);
}


void normalize(matrix_data_t *const v, const uint32_t n){
    matrix_data_t norm = norm2(v, n);
    for(uint32_t i=0; i<n; i++) v[i] /= norm;
}


/* assign to t_matrix the transpose of matrix
 * r = number of rows of matrix
 * c = number of columns of matrix
 */
void transpose(const matrix_data_t *const matrix, matrix_data_t *const t_matrix, const uint32_t r, const uint32_t c){

    for (uint32_t i = 0; i<r; i++) {
        for (uint32_t j = 0; j<c; j++) {
            t_matrix[j * r + i] = matrix[i * c + j];
        }
    }
}


void self_transpose(matrix_data_t *const matrix, const uint32_t r, const uint32_t c){
    float tmp[r*c];
    transpose(matrix, tmp, r, c);
    memcpy(matrix, tmp, sizeof(matrix_data_t)*r*c);
}


/* perform matrix_product = matrix_1*matrix_2
 * r_1 = number of row of matrix_1
 * c_2 = number of column of matrix_2
 * r_c_common = number of row of matrix_2 = number of column of matrix_1
 */ 
void matrix_mult(const matrix_data_t *const matrix_1, const matrix_data_t *const matrix_2, 
                 matrix_data_t *const matrix_product, const uint32_t r_1, const uint32_t c_2, const uint32_t r_c_common) {
    for (uint32_t i = 0; i<r_1; i++) {
        for (uint32_t j = 0; j<c_2; j++) {
            matrix_product[i * c_2 + j] = 0;
            for (uint32_t k = 0; k<r_c_common; k++) {
                matrix_product[i * c_2 + j] += matrix_1[i * r_c_common + k] * matrix_2[k * c_2 + j];
            }
        }
    }
} 


void matrix_mult_T(const matrix_data_t *const matrix_1, const matrix_data_t *const matrix_2, 
                   matrix_data_t *const matrix_product, const uint32_t r_1, const uint32_t r_2, const uint32_t c_c_common){
    for (uint32_t i = 0; i<r_1; i++) {
        for (uint32_t j = 0; j<r_2; j++) {
            matrix_product[i * r_2 + j] = 0;
            for (uint32_t k = 0; k<c_c_common; k++) {
                matrix_product[i * r_2 + j] += matrix_1[i * c_c_common + k] * matrix_2[j * c_c_common + k];
            }
        }
    }

}


void quadratic_form(const matrix_data_t *const m1, const matrix_data_t *const m2, 
                    matrix_data_t *const q_form, const uint32_t r, const uint32_t c){
    float tmp[r*c], tmp2[r*c];
    matrix_mult(m1, m2, tmp, r, c, c);
    transpose(m1, tmp2, r, c);
    matrix_mult(tmp, tmp2, q_form, r, r, c);
}


void cross_prod3(const matrix_data_t *const v1, const matrix_data_t *const v2, matrix_data_t *const vp){
    vp[0] = v1[1] * v2[2] - v1[2] * v2[1];
    vp[1] = v1[2] * v2[0] - v1[0] * v2[2];
    vp[2] = v1[0] * v2[1] - v1[1] * v2[0];
}
 

/* Function to get cofactor 
 * Compute cofactor A(p,q) and saves it in temp
 * temp supposed to be of dim(n-1,n-1)
 * p = row for which compute the cofactor
 * q = column for which compute the cofactor
 * dim = dim of A (supposed to be square)
 */
void get_cofactor(const matrix_data_t *const A, matrix_data_t *const cof, const uint32_t p, 
                  const uint32_t q, const uint32_t dim){
    uint32_t i = 0, j = 0;
 
    // Looping for each element of the matrix
    for (uint32_t row = 0; row < dim; row++)
    {
        for (uint32_t col = 0; col < dim; col++)
        {
            // Copying into cof matrix only those element
            // which are not in given row and column
            if (row != p && col != q)
            {
                cof[i * (dim-1) + j] = A[row * dim + col];
                j++;
 
                // Row is filled, so increase row index and
                // reset col index
                if (j == dim - 1)
                {
                    j = 0;
                    i++;
                }
            }
        }
    }
}
 

/* Recursive function to find determinant of matrix A
 *dim = dim of A (supposed to be square)
 */
matrix_data_t determinant(const matrix_data_t *const A, const uint32_t dim){
    matrix_data_t D = 0; // Initialize result
 
    // Base case : if matrix contains single element
    if (dim == 1){
        D = A[0];
    } 
    // if matrix is 2x2
    else if (dim == 2){
        D = A[0]*A[3] - A[1]*A[2];
    }
    // // if matrix is 3x3
    else if(dim == 3){
        D += A[0]*A[4]*A[8];
        D += A[1]*A[5]*A[6];
        D += A[2]*A[3]*A[7];
        D -= A[2]*A[4]*A[6];
        D -= A[1]*A[3]*A[8];
        D -= A[0]*A[5]*A[7];
    }

    else
    {
        matrix_data_t temp[(dim-1)*(dim-1)]; // To store cofactors
        int sign = 1; // To store sign multiplier
    
        // Iterate for each element of first row
        for (uint32_t f = 0; f < dim; f++)
        {
            // Getting Cofactor of A[0][f]
            get_cofactor(A, temp, 0, f, dim);
            D += sign * A[0 * dim + f] * determinant(temp, dim - 1);
    
            // terms are to be added with alternate sign
            sign = -sign;
        }
    }
    return D;
}
 

/* Compute adjoint of A and saves it in adj
 * adj must be of same dim of A
 * dim = dim of A(supposed to be square)
 */
void adjoint(const matrix_data_t *const A, matrix_data_t *const adj, const uint32_t dim){
    if (dim == 1)
    {
        adj[0] = 1;
        return;
    }
 
    int sign = 1;
    matrix_data_t temp[(dim-1)*(dim-1)]; // To store cofactors
 
    for (uint32_t i=0; i<dim; i++)
    {
        for (uint32_t j=0; j<dim; j++)
        {
            // Get cofactor
            get_cofactor(A, temp, i, j, dim);
 
            // sign of adj positive if sum of row
            // and column indexes is even.
            sign = ((i+j)%2==0)? 1: -1;
 
            // Get the cofactor matrix
            adj[i * dim + j] = (sign)*(determinant(temp, dim-1));
        }
    }
}
 

/* Function to calculate and store inverse, returns false if
 * inverse must be of same dim of A
 * dim = dim of A(supposed to be square)
 */
bool inverse(const matrix_data_t *const A, matrix_data_t *const inverse, const uint32_t dim){
    // Find determinant of A[][]
    matrix_data_t det = determinant(A, dim); 
    if (det == 0)
    {
        printf("Singular matrix, can't find its inverse\n");
        return false;
    }
 
    // Find adjoint
    matrix_data_t adj[dim*dim];
    adjoint(A, adj, dim);
 
    // Find Inverse using formula "inverse(A) = adj(A)/det(A)"
    for (uint32_t i=0; i<dim; i++){
        for (uint32_t j=0; j<dim; j++){
            inverse[j * dim + i]= adj[i * dim + j] / det;
        }
    }
 
    return true;
}


/* Compute pseudoinverse of matrix A and saves it in pinv
 * pinv will be of dimension c*r flattened
 * r = number of rows of A
 * c = number of columns of A 
 */
bool pseudoinverse(const matrix_data_t *const A, matrix_data_t *const pinv, const uint32_t r, const uint32_t c){
    
    matrix_data_t transpose_A[r*c];
    transpose(A, transpose_A, r, c);

    matrix_data_t product[c*c];
    matrix_mult(transpose_A, A, product, c, c, r);

    matrix_data_t inverse_AtA[c*c];
    bool invertible = inverse(product, inverse_AtA, c);
    
    if(!invertible) return false;
    matrix_mult(inverse_AtA, transpose_A, pinv, c, r, c);

    return true;
}


void get_diag(const matrix_data_t *const A, matrix_data_t *const d, const uint32_t n, const uint32_t c){
  for(uint32_t i=0; i<n; i++) d[i] = A[i*c + i];
}


void v2diag_m(const matrix_data_t *const d, matrix_data_t *const A, const uint32_t n){
  for(uint32_t i=0; i<n; i++) for(uint32_t j=0; j<n; j++){
    if(i == j) A[i*n + j] = d[i];
    else A[i*n + j] = 0;
  }
}




