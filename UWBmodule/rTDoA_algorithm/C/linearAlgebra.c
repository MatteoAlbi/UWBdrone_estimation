#include "linearAlgebra.h"

void display_flat_matrix(double *matrix, int r, int c){
    printf("dim: %dx%d\n",r,c);
    for(int i=0; i<r; i++){
        for(int j=0; j<c; j++){
            printf("%f ", matrix[i * c + j]);
        }
        printf("\n");
    }
}

/* assign to t_matrix the transpose of matrix
 * r = number of rows of matrix
 * c = number of columns of matrix
 */
void transpose(double *matrix, double *t_matrix, int r, int c) {

    for (int i = 0; i<r; i++) {
        for (int j = 0; j<c; j++) {
            t_matrix[j * r + i] = matrix[i * c + j];
        }
    }
 
    return;
}
 
/* perform matrix_product = matrix_1*matrix_2
 * r_1 = number of row of matrix_1
 * c_2 = number of column of matrix_2
 * r_c_common = number of row of matrix_2 = number of column of matrix_1
 */ 
void matrix_mult(double *matrix_1, double *matrix_2, double *matrix_product, int r_1, int c_2, int r_c_common) {
    for (int i = 0; i<r_1; i++) {
        for (int j = 0; j<c_2; j++) {
            matrix_product[i * c_2 + j] = 0;
            for (int k = 0; k<r_c_common; k++) {
                matrix_product[i * c_2 + j] += matrix_1[i * r_c_common + k] * matrix_2[k * c_2 + j];
            }
        }
    }
} 
 
/* Function to get cofactor 
 * Compute cofactor A(p,q) and saves it in temp
 * temp supposed to be of dim(n-1,n-1)
 * p = row for which compute the cofactor
 * q = column for which compute the cofactor
 * dim = dim of A (supposed to be square)
 */
void getCofactor(double *A, double *temp, int p, int q, int dim)
{
    int i = 0, j = 0;
 
    // Looping for each element of the matrix
    for (int row = 0; row < dim; row++)
    {
        for (int col = 0; col < dim; col++)
        {
            // Copying into temporary matrix only those element
            // which are not in given row and column
            if (row != p && col != q)
            {
                temp[i * (dim-1) + j] = A[row * dim + col];
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
double determinant(double *A, int dim)
{
    double D = 0; // Initialize result
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
        double temp[(dim-1)*(dim-1)]; // To store cofactors
        int sign = 1; // To store sign multiplier
    
        // Iterate for each element of first row
        for (int f = 0; f < dim; f++)
        {
            // Getting Cofactor of A[0][f]
            getCofactor(A, temp, 0, f, dim);
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
void adjoint(double *A,double *adj, int dim)
{
    if (dim == 1)
    {
        adj[0] = 1;
        return;
    }
 
    int sign = 1;
    double temp[(dim-1)*(dim-1)]; // To store cofactors
 
    for (int i=0; i<dim; i++)
    {
        for (int j=0; j<dim; j++)
        {
            // Get cofactor
            getCofactor(A, temp, i, j, dim);
 
            // sign of adj positive if sum of row
            // and column indexes is even.
            sign = ((i+j)%2==0)? 1: -1;
 
            // Get the cofactor matrix
            adj[i * dim + j] = (sign)*(determinant(temp, dim-1));
        }
    }
}
 
/* Function to calculate and store inverse, returns false if
 * matrix is singular
 * inverse must be of same dim of A
 * dim = dim of A(supposed to be square)
 */
bool inverse(double *A, double *inverse, int dim)
{
    // Find determinant of A[][]
#ifdef DEBUG 
    printf("Matrix to invert:\n");
    display_flat_matrix(A,dim,dim);
#endif
    double det = determinant(A, dim); 
    if (det == 0)
    {
        printf("Singular matrix, can't find its inverse\n");
        return false;
    }
 
    // Find adjoint
    double adj[dim*dim];
    adjoint(A, adj, dim);
 
    // Find Inverse using formula "inverse(A) = adj(A)^T/det(A)"
    for (int i=0; i<dim; i++){
        for (int j=0; j<dim; j++){
            inverse[j * dim + i]= adj[i * dim + j]/det;
        }
    }
 
    return true;
}

/* Compute pseudoinverse of matrix A and saves it in pinv
 * pinv will be of dimension c*r flattened
 * r = number of rows of A
 * c = number of columns of A 
 */
bool pseudoinverse(double *A, double *pinv, int r, int c){
    
    double transpose_A[r*c];
    transpose(A, transpose_A, r, c);

    double product[c*c];
    matrix_mult(transpose_A, A, product, c, c, r);

    double inverse_AtA[c*c];
    bool invertible = inverse(product, inverse_AtA, c);
    
    if(!invertible) return false;
    matrix_mult(inverse_AtA, transpose_A, pinv, c, r, c);

    return true;
}

