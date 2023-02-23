#include "linear_algebra.h"
#include <stdio.h>
#include <stdlib.h>

int main(){
    matrix_data_t m[12] = {1,2,3,4,5,6,7,8,9,10,11,12};
    matrix_data_t n[9] = {1,2,3,4,5,6,7,8,9};
    matrix_data_t res[16];

    quadratic_form(m, n, res, 4, 3);
    display_flat_matrix(res, 4, 4);
    printf("%4.3e\n", determinant(res, 4));
    inverse(res, res, 4);
    // printf
    display_flat_matrix(res, 4, 4);

    float test = 1.5123215151;
    printf("%f\t", test);
    printf("%f\t", (double)test);

    return 0;
}