#include "linearAlgebra.h"

Matrix * init_matrix(int r, int c){
    Matrix * ret = (Matrix *) malloc(sizeof(Matrix));
    ret->r = r;
    ret->c = c;
    ret->v = (double *) malloc(ret->r*ret->c*sizeof(double));

    return ret;
}

Matrix * init_matrix_v(int r, int c, double* v){
    Matrix * ret = (Matrix *) malloc(sizeof(Matrix));
    ret->r = r;
    ret->c = c;
    ret->v = (double *) malloc(ret->r*ret->c*sizeof(double));
    for (int i = 0; i < ret->r; i++){
        for (int j = 0; j < ret->c; j++){
            ret->v[i * ret->c + j] = v[i * ret->c + j];
        }
    }

    return ret;    
}

Matrix * init_r_vector(int c){
    Matrix * ret = (Matrix *) malloc(sizeof(Matrix));
    ret->r = 1;
    ret->c = c;
    ret->v = (double *) malloc(ret->r*ret->c*sizeof(double));

    return ret;
}

Matrix * init_r_vector_v(int c, double* v){
    Matrix * ret = (Matrix *) malloc(sizeof(Matrix));
    ret->r = 1;
    ret->c = c;
    ret->v = (double *) malloc(ret->r*ret->c*sizeof(double));
    for (int i = 0; i < ret->r; i++){
        for (int j = 0; j < ret->c; j++){
            ret->v[i * ret->c + j] = v[i * ret->c + j];
        }
    }

    return ret;    
}

Matrix * init_c_vector(int r){
    Matrix * ret = (Matrix *) malloc(sizeof(Matrix));
    ret->r = r;
    ret->c = 1;
    ret->v = (double *) malloc(ret->r*ret->c*sizeof(double));

    return ret;    
}

Matrix * init_c_vector_v(int r, double* v){
    Matrix * ret = (Matrix *) malloc(sizeof(Matrix));
    ret->r = r;
    ret->c = 1;
    ret->v = (double *) malloc(ret->r*ret->c*sizeof(double));
    for (int i = 0; i < ret->r; i++){
        for (int j = 0; j < ret->c; j++){
            ret->v[i * ret->c + j] = v[i * ret->c + j];
        }
    }

    return ret;    
}

void del_matrix(Matrix * m){
    free(m->v);
    free(m);
}

void display_flat_matrix(Matrix *m){
    printf("dim: %dx%d\n",m->r,m->c);
    for(int i=0; i<m->r; i++){
        for(int j=0; j<m->c; j++){
            printf("%f ", m->v[i * m->c + j]);
        }
        printf("\n");
    }
}

Matrix * transpose(Matrix *m) {

    Matrix * ret = init_matrix(m->c,m->r);

    for (int i = 0; i<m->r; i++) {
        for (int j = 0; j<m->c; j++) {
            ret->v[j * m->r + i] = m->v[i * m->c + j];
        }
    }
 
    return ret;
}
 
Matrix * matrix_prod(Matrix *m1, Matrix *m2) {
    if(m1->c != m2->r) return NULL;

    Matrix * ret = init_matrix(m1->r,m2->c);

    for (int i = 0; i<m1->r; i++) {
        for (int j = 0; j<m2->c; j++) {
            ret->v[i * m2->c + j] = 0;
            for (int k = 0; k<m1->c; k++) {
                ret->v[i * m2->c + j] += m1->v[i * m1->c + k] * m2->v[k * m2->c + j];
            }
        }
    }

    return ret;
} 
 
Matrix * get_cofactor(Matrix *m, int p, int q) {
    if(m->r < p || m->c < q) return NULL;

    int i = 0, j = 0;

    Matrix * ret = init_matrix(m->r-1,m->c-1);
 
    // Looping for each element of the matrix
    for (int row = 0; row < m->r; row++){

        for (int col = 0; col < m->c; col++){

            // Copying into temporary matrix only those element
            // which are not in given row and column
            if (row != p && col != q){
                ret->v[i * (m->c-1) + j] = m->v[row * m->c + col];
                j++;
 
                // Row is filled, so increase row index and
                // reset col index
                if (j == ret->c){
                    j = 0;
                    i++;
                }
            }
        }
    }

    return ret;
}
 
double determinant(Matrix *m) {
    if(m->r != m->c) return 0;

    // Base case : if matrix contains single element
    if (m->r == 1){
        return m->v[0];
    } 
    // if matrix is 2x2
    else if (m->r == 2){
        return m->v[0]*m->v[3] - m->v[1]*m->v[2];
    }

    else{
        double D = 0; // Initialize result

        Matrix * cof; // To store cofactors
        int sign = 1; // To store sign multiplier
    
        // Iterate for each element of first row
        for (int j = 0; j < m->c; j++){
            // Getting Cofactor of m->v[0][f]
            cof = get_cofactor(m, 0, j);
            D += sign * m->v[j] * determinant(cof);
            del_matrix(cof);
    
            // terms are to be added with alternate sign
            sign = -sign;
        }

        return D;
    }
}
 
Matrix * adjoint(Matrix * m){
    if(m->r != m->c) return NULL;

    Matrix * ret = init_matrix(m->r,m->c);

    if (m->r == 1){
        ret->v[0] = 1;
        return ret;
    }
 
    int sign = 1;
    Matrix * cof; // To store cofactors
 
    for (int i=0; i<m->r; i++)
    {
        for (int j=0; j<m->c; j++)
        {
            // Get cofactor
            cof = get_cofactor(m, i, j);
 
            // sign of adj positive if sum of row
            // and column indexes is even.
            sign = ((i+j)%2==0)? 1: -1;
 
            // Interchanging rows and columns to get the
            // transpose of the cofactor matrix
            ret->v[i * m->c + j] = (sign)*(determinant(cof));

            del_matrix(cof);
        }
    }

    return ret;
}
 
Matrix * inverse(Matrix *m){

    if(m->r != m->c) return NULL;

    // Find determinant of A[][]
    double det = determinant(m); 
    if (det == 0) return NULL;

    Matrix * ret = init_matrix(m->r, m->c);
 
    // Find adjoint
    Matrix * adj = adjoint(m);
    // Transpose adjoint
    Matrix * adj_t = transpose(adj);
    del_matrix(adj);
 
    // Find Inverse using formula "inverse(m) = adj(m)^t/det(m)"
    for (int i=0; i<adj_t->r; i++){
        for (int j=0; j<adj_t->c; j++){
            ret->v[i * adj_t->c + j]= adj_t->v[i * adj_t->c + j] / det;
        }
    }
    del_matrix(adj_t);
 
    return ret;
}

Matrix * pseudoinverse(Matrix *m) {

    Matrix * m_t = transpose(m); 

    Matrix * mt_m = matrix_prod(m_t,m);

    Matrix * inv_mt_m = inverse(mt_m);
    del_matrix(mt_m);
    
    if(inv_mt_m == NULL) return NULL;

    Matrix * ret = matrix_prod(inv_mt_m, m_t);
    del_matrix(m_t);
    del_matrix(inv_mt_m);

    return ret;
}

