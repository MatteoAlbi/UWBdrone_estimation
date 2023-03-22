#include "linear_algebra.h"
#include <stdio.h>
#include <stdlib.h>

int main(){
    matrix_data_t m[12] = {1,2,3,4,5,6,7,8,9,10,11,12};
    // matrix_data_t n[9] = {1,2,3,4,5,6,7,8,9};
    // matrix_data_t res[16];
    // matrix_data_t c[16] = {0.939847271760501, 0.291587682173526, 0.148272273393554, 0.170005035193372, 0.169403645664912, 0.149365378247585, 0.0815225571754091, 0.869809718060960, 0.726783518935904, 0.773895362267150, 0.170455324694551, 0.969664232997853, 0.350671267917871, 0.869110802912895, 0.413748562060055, 0.914334401645592};

    // quadratic_form(m, n, res, 4, 3);
    // display_flat_matrix(res, 4, 4);
    // printf("%4.3e\n", determinant(res, 4));
    // inverse(res, res, 4);
    // display_flat_matrix(res, 4, 4);
    // printf("%4.3e\n", determinant(res, 4));
    // matrix_mult(m, n, res, 4, 3, 3);
    // display_flat_matrix(res, 4, 3);
    // inverse(c, c, 4);
    // display_flat_matrix(c, 4, 4);

    // matrix_data_t A[12] = { -1, -1, 1,
    //                         1, 3, 3,
    //                         -1, -1, 5,
    //                         1, 3, 7};
    
    // matrix_data_t R[12], Q[16];
    // printf("A: ");
    // display_flat_matrix(A, 4, 3);

    // qr_dec(A, 4, 3, Q, R);
    // printf("Q: ");
    // display_flat_matrix(Q, 4, 4);
    // printf("R: ");
    // display_flat_matrix(R, 4, 3);

    // matrix_mult(Q,R,A,4,3,4);
    // printf("A recomposed: ");
    // display_flat_matrix(A, 4, 3);

    // printf("A: ");
    // display_flat_matrix(A, 3, 3);

    // lu_dec(A, 3, Q, R);
    // printf("L: ");
    // display_flat_matrix(Q, 3, 3);
    // printf("U: ");
    // display_flat_matrix(R, 3, 3);

    // matrix_mult(Q,R,A,3,3,3);
    // printf("A recomposed: ");
    // display_flat_matrix(A, 3, 3);

    matrix_data_t l[16] = { 3, 0, 0, 0,
                            -2, 5, 0, 0,
                            4, -1, 2, 0,
                            -1, -4, 1, 3};
    matrix_data_t c[16] = { 3, 0, 7, -2,
                            -2, 4, 3, 0,
                            4, -1, 0, 8,
                            -1, -4, 1, 3};

    matrix_data_t b[12] = {2, 5, -3, 1, 2, 5, -3, 1, 2, 5, -3, 1};
    matrix_data_t res[12], u[16];
    transpose(l,u, 4,4);
    // display_flat_matrix(u, 4, 4);

    forward_sub(l, b, res, 4, 3);
    // display_flat_matrix(res, 4, 3);

    backward_sub(u, b, res, 4,3);
    // display_flat_matrix(res, 4, 3);

    matrix_r_divide(b, c, res, 3, 4, 4);
    display_flat_matrix(res, 3, 4);

    inverse(c,c,4);
    matrix_mult(b, c, res, 4, 3, 4);
    display_flat_matrix(res, 3, 4);

    return 0;
}