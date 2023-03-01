#include "rTDoA_est.h"

static double tmp1;
static double tmp2;
static double tmp_m1_flat[NUM_ANCH*4];
static double tmp_m2_flat[NUM_ANCH*4];
static double tmp_v1[NUM_ANCH];
static double tmp_v2[NUM_ANCH];
static double tmp_v3[NUM_ANCH];
// Anchors position
// static double anchors_mat[6][3] = { {0,0,2.65},
//                                     {-1.840, 4.683, 2.961},
//                                     {2.160, 4.648, 2.632},
//                                     {8.085, 4.602, 2.938},
//                                     {7.626, -1.416, 2.637},
//                                     {4.116, -1.369, 2.735} };
static float anchors_mat[6][3] = { {3.00, 9.35, 3.15},
                                   {0.00, 7.19, 2.15},
                                   {0.00, 3.62, 3.15},
                                   {0.00, 0.00, 2.15},
                                   {4.79, 1.85, 3.15},
                                   {4.79, 5.45, 2.15} };

bool rTDoA(uint64_t ts_param[NUM_ANCH][4], float* buf){

    int i,j;

    //tx and rx values
    for(i=0; i<NUM_ANCH; i++){
        for(j=0; j<4; j++){
            tmp_m1_flat[i * 4 + j] = (double) (ts_param[i][j] / TIME_CONST);
        }
    }

    //drift tag: dt
    for(i=0; i<NUM_ANCH; i++){
        tmp1 = (tmp_m1_flat[i * 4 + 3]-tmp_m1_flat[i * 4 + 2]);
        if(tmp1 == 0){
            printf("DIV BY 0: tx1 = tx2\n");
            return false;
        }
        tmp_v1[i] = (tmp_m1_flat[i * 4 + 1] - tmp_m1_flat[i * 4 + 0]) / tmp1;
    }
                
    //TDoA
    tmp1 = tmp_v1[0];
    for(i=1; i<NUM_ANCH; i++){
        tmp_v1[i-1] = SPEED_OF_LIGHT * (tmp_m1_flat[i * 4 + 1] - tmp_m1_flat[0 * 4 + 1] - (tmp_m1_flat[i * 4 + 3]*tmp_v1[i] - tmp_m1_flat[0 * 4 + 3]*tmp1));
    }

    // coefficient matrix A
    for(j=0; j<3; j++){
        for(i=1; i<NUM_ANCH; i++){
            tmp_m1_flat[(i-1) * 4 + j] = (anchors_mat[0][j] - anchors_mat[i][j])*2;
        }
    }

    for(i=0; i<NUM_ANCH-1; i++){
        tmp_m1_flat[i * 4 + 3] = tmp_v1[i]*2;
    }

    // rhs vector b
    tmp2 = 0;
    for(j=0; j<3; j++){
        tmp2 += pow(anchors_mat[0][j],2);
    }
    for(i=1; i<NUM_ANCH; i++){
        tmp1 = 0;
        for(j=0; j<3; j++){
            tmp1 += pow(anchors_mat[i][j],2);
        }
        tmp_v2[i-1] = pow(tmp_v1[i-1],2) + tmp2 - tmp1; //b
    }
    
    // solve linear system with pseudoinverse: obtain x_t0
    if(! pseudoinverse(tmp_m1_flat, tmp_m2_flat, NUM_ANCH-1, 4) ){ //pinv_A
        printf("Matrix A non invertible\n");
        return false;
    }
    for(i=0; i<4; i++){
        tmp_v3[i] = 0;
        for(j=0; j<NUM_ANCH-1; j++){ //x_t0
            tmp_v3[i] += tmp_m2_flat[i * (NUM_ANCH-1) + j] * tmp_v2[j];
        }
    }
    
    // non linear correction: vector f and matrix del_f
    for(i=1; i<NUM_ANCH; i++){

        tmp1 = 0;
        tmp2 = 0;
        for(j=0; j<3; j++){
            tmp1 += pow(tmp_v3[j] - anchors_mat[i][j], 2);
            tmp2 += pow(tmp_v3[j] - anchors_mat[0][j], 2);
        }

        if(tmp1 == 0 || tmp2 == 0){
            printf("DIV BY 0: norm = 0\n");
            return false;
        }

        tmp1 = sqrt(tmp1);
        tmp2 = sqrt(tmp2);

        tmp_v2[i-1] = tmp1 - tmp2; //f

        for(j=0; j<3; j++){ //del_f
            tmp_m1_flat[(i-1) * 3 + j] = (tmp_v3[j] - anchors_mat[i][j]) / tmp1 - (tmp_v3[j] - anchors_mat[0][j]) / tmp2;
        }
    }
    
    //pseudoinverse of del_f
    if(! pseudoinverse(tmp_m1_flat, tmp_m2_flat, NUM_ANCH-1, 3) ){ //pinv
        printf("Matrix del_f not invertible\n");
        return false;
    }
    //perform matrix product and sum x_t0
    for(i=0; i<3; i++){
        for(j=0; j<NUM_ANCH-1; j++){
            tmp_v3[i] += tmp_m2_flat[i * (NUM_ANCH-1) + j]*(tmp_v1[j]-tmp_v2[j]);
        }
    }

    //    int i,j;

    ////tx and rx values
    //for(i=0; i<NUM_ANCH; i++){
    //    for(j=0; j<4; j++){
    //        tmp_m1_flat[i * 4 + j] = (float) (ts_param[i][j] / TIME_CONST);
    //    }
    //}

    ////drift tag: dt
    //for(i=0; i<NUM_ANCH; i++){
    //    tmp1 = (tmp_m1_flat[i * 4 + 3]-tmp_m1_flat[i * 4 + 2]);
    //    if(tmp1 == 0){
    //        //printf("DIV BY 0: tx1 = tx2\r\n");
    //        return RTDOA_DIV_0;
    //    }
    //    tmp_v1[i] = (tmp_m1_flat[i * 4 + 1] - tmp_m1_flat[i * 4 + 0]) / tmp1;
    //}
                
    ////TDoA
    //tmp1 = tmp_v1[0];
    //for(i=1; i<NUM_ANCH; i++){
    //    tmp_v1[i-1] = SPEED_OF_LIGHT * (tmp_m1_flat[i * 4 + 1] - tmp_m1_flat[0 * 4 + 1] - (tmp_m1_flat[i * 4 + 3]*tmp_v1[i] - tmp_m1_flat[0 * 4 + 3]*tmp1));
    //}

    //// coefficient matrix A
    //for(j=0; j<3; j++){
    //    for(i=1; i<NUM_ANCH; i++){
    //        tmp_m1_flat[(i-1) * 4 + j] = (anchors_mat[0][j] - anchors_mat[i][j])*2;
    //    }
    //}

    //for(i=0; i<NUM_ANCH-1; i++){
    //    tmp_m1_flat[i * 4 + 3] = tmp_v1[i]*2;
    //}

    //// rhs vector b
    //tmp2 = 0;
    //for(j=0; j<3; j++){
    //    tmp2 += pow(anchors_mat[0][j],2);
    //}
    //for(i=1; i<NUM_ANCH; i++){
    //    tmp1 = 0;
    //    for(j=0; j<3; j++){
    //        tmp1 += pow(anchors_mat[i][j],2);
    //    }
    //    tmp_v2[i-1] = pow(tmp_v1[i-1],2) + tmp2 - tmp1; //b
    //}
    
    //// solve linear system with pseudoinverse: obtain x_t0
    //if(! pseudoinverse(tmp_m1_flat, tmp_m2_flat, NUM_ANCH-1, 4) ){ //pinv_A
    //    //printf("Matrix A not invertible\r\n");
    //    return RTDOA_MAT_NINV;
    //}
    //for(i=0; i<4; i++){
    //    tmp_v3[i] = 0;
    //    for(j=0; j<NUM_ANCH-1; j++){ //x_t0
    //        tmp_v3[i] += tmp_m2_flat[i * (NUM_ANCH-1) + j] * tmp_v2[j];
    //    }
    //}
    
    //// non linear correction: vector f and matrix del_f
    //for(i=1; i<NUM_ANCH; i++){

    //    tmp1 = 0;
    //    tmp2 = 0;
    //    for(j=0; j<3; j++){
    //        tmp1 += pow(tmp_v3[j] - anchors_mat[i][j], 2);
    //        tmp2 += pow(tmp_v3[j] - anchors_mat[0][j], 2);
    //    }

    //    if(tmp1 == 0 || tmp2 == 0){
    //        //printf("DIV BY 0: norm = 0\r\n");
    //        return RTDOA_DIV_0;
    //    }

    //    tmp1 = sqrt(tmp1);
    //    tmp2 = sqrt(tmp2);

    //    tmp_v2[i-1] = tmp1 - tmp2; //f

    //    for(j=0; j<3; j++){ //del_f
    //        tmp_m1_flat[(i-1) * 3 + j] = (tmp_v3[j] - anchors_mat[i][j]) / tmp1 - (tmp_v3[j] - anchors_mat[0][j]) / tmp2;
    //    }
    //}
    
    ////pseudoinverse of del_f
    //if(! pseudoinverse(tmp_m1_flat, tmp_m2_flat, NUM_ANCH-1, 3) ){ //pinv
    //    //printf("Matrix del_f not invertible\r\n");
    //    return RTDOA_MAT_NINV;
    //}
    ////perform matrix product and sum x_t0
    //for(i=0; i<3; i++){
    //    for(j=0; j<NUM_ANCH-1; j++){
    //        tmp_v3[i] += tmp_m2_flat[i * (NUM_ANCH-1) + j]*(tmp_v1[j]-tmp_v2[j]);
    //    }
    //}

        
    if(buf == NULL) printf("%f %f %f\r\n", tmp_v3[0], tmp_v3[1], tmp_v3[2]);
    else memcpy(buf, tmp_v3, sizeof(float)*3);

    memset(tmp_m1_flat, 0, sizeof(tmp_m1_flat[0]) * NUM_ANCH * 4);
    memset(tmp_m2_flat, 0, sizeof(tmp_m2_flat[0]) * NUM_ANCH * 4);
    memset(tmp_v1,      0, sizeof(tmp_v1[0])      * NUM_ANCH);
    memset(tmp_v2,      0, sizeof(tmp_v2[0])      * NUM_ANCH);
    memset(tmp_v3,      0, sizeof(tmp_v3[0])      * NUM_ANCH);

    return true;
}