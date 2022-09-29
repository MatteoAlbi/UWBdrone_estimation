#include "rTDoA_est.h"

// Anchors position
//rows 38:43

void trans_2D_1D_5_4(double matrix_2D[NUM_ANCH-1][4], double *matrix) {
    for (int i = 0; i < NUM_ANCH-1; i++){
        for (int j = 0; j < 4; j++){
            matrix[i * 4 + j] = matrix_2D[i][j];
        }
    }
    return;
}

void trans_2D_1D_5_3(double matrix_2D[NUM_ANCH-1][3], double *matrix) {
    for (int i = 0; i < NUM_ANCH-1; i++){
        for (int j = 0; j < 3; j++){
            matrix[i * 3 + j] = matrix_2D[i][j];
        }
    }
    return;
}

bool rTDoA(uint64_t ts_param[NUM_ANCH][4], double *x_t){
    double anchors_mat[6][3] = {{2.92, 11.05, 6.68},
                            {0.00, 0.00, 5.68},
                            {5.65, 0.00, 5.74},
                            {3.05, 4.95, 6.26},
                            {8.01, 7.35, 7.03},
                            {13.22, 4.95, 6.22}};
    int i,j;

    double tmp;
    bool inverted;
    double ts[NUM_ANCH][4];

    //tx and rx values, rows 3:29
    for(i=0; i<NUM_ANCH; i++){
        for(j=0; j<4; j++){
            ts[i][j] = (double) (ts_param[i][j] / TIME_CONST);
        }
    }

#ifdef DEBUG
    printf("\nts:\n");
    for(int i=0; i<NUM_ANCH; i++){
        for(int j=0; j<4; j++) printf("%.15f ", ts[i][j]);
        printf("\n");
    }
#endif

    //drift tag
    //rows 51:55
    double dt[NUM_ANCH];
    double denom;
    for(i=0; i<NUM_ANCH; i++){
        denom = (ts[i][3]-ts[i][2]);
        if(denom == 0){
            printf("DIV BY 0: tx1 = tx2\n");
            return false;
        }
        dt[i] = (ts[i][1]-ts[i][0])/(ts[i][3]-ts[i][2]);
    }

#ifdef DEBUG
    printf("\ndt:\n");
    for(int i=0; i<NUM_ANCH; i++) printf("%f ",dt[i]);
    printf("\n");
#endif
     
    //TDoA
    //rows 72:77
    double tdoa[NUM_ANCH-1];
    for(i=1; i<NUM_ANCH; i++){
        tdoa[i-1] = SPEED_OF_LIGHT * (ts[i][1] - ts[0][1] - (ts[i][3]*dt[i] - ts[0][3]*dt[0]));
    }

#ifdef DEBUG
    printf("\ntdoa:\n");
    for(int i=0; i<NUM_ANCH-1; i++) printf("%.15f ",tdoa[i]);
    printf("\n");
#endif

    // trilateral linear equation system

    // coefficient matrix A
    //row 80
    double A[NUM_ANCH-1][4];
    for(j=0; j<3; j++){
        for(i=1; i<NUM_ANCH; i++){
            A[i-1][j] = (anchors_mat[0][j] - anchors_mat[i][j])*2;
        }
    }
    for(i=0; i<NUM_ANCH-1; i++){
        A[i][3] = tdoa[i]*2;
    }

#ifdef DEBUG
    printf("\nA:\n");
    for(int i=0; i<NUM_ANCH-1; i++){
        for(int j=0; j<4; j++) printf("%.15f ",A[i][j]);
        printf("\n");
    }
#endif

    // rhs vector b
    //row 81
    double b[NUM_ANCH-1];
    double anchor_six_norm_sqr = 0;

    for(j=0; j<3; j++){
        anchor_six_norm_sqr += pow(anchors_mat[0][j],2);
    }

    for(i=1; i<NUM_ANCH; i++){
        tmp = 0;
        for(j=0; j<3; j++){
            tmp += pow(anchors_mat[i][j],2);
        }
        b[i-1] = pow(tdoa[i-1],2) + anchor_six_norm_sqr - tmp;
    }

#ifdef DEBUG
    printf("\nb:\n");
    for(int i=0; i<NUM_ANCH-1; i++) printf("%f ",b[i]);
    printf("\n");
#endif

    // solve linear system with pseudoinverse
    //row 82
    //flatten A
    double A_flat[(NUM_ANCH-1)*4];
    trans_2D_1D_5_4(A, A_flat);
    //flat pseudoinverse of A
    double pinv_A_flat[4*(NUM_ANCH-1)];
    inverted = pseudoinverse(A_flat, pinv_A_flat, NUM_ANCH-1, 4); 
    if(!inverted) return false;

#ifdef DEBUG
    printf("\npinvA:\n");
    display_flat_matrix(pinv_A_flat,4,NUM_ANCH-1);
#endif
    
    //perform matrix product
    double x_t0[4];
    for(i=0; i<4; i++){
        x_t0[i] = 0;
        for(j=0; j<NUM_ANCH-1; j++){
            x_t0[i] += pinv_A_flat[i * (NUM_ANCH-1) + j] * b[j];
        }
    }

#ifdef DEBUG
    printf("\nx_t0:\n");
    for(int i=0; i<4; i++) printf("%f ",x_t0[i]);
    printf("\n");
#endif

    //Non linear correction (Taylor Expansion)
    //rows 85:87
    double x_t_0[3] = {x_t0[0], x_t0[1], x_t0[2]};
    double f[NUM_ANCH-1];
    double del_f[NUM_ANCH-1][3] = {{0x00}};
    double norm[2];
    
    //rows 89:96
    for(i=1; i<NUM_ANCH; i++){

        norm[0] = 0;
        norm[1] = 0;
        for(j=0; j<3; j++){
            norm[0] += pow(x_t_0[j] - anchors_mat[i][j], 2);
            norm[1] += pow(x_t_0[j] - anchors_mat[0][j], 2);
        }

        if(norm[0] == 0 || norm[1] == 0){
            printf("DIV BY 0: norm = 0\n");
            return false;
        }
        
        norm[0] = sqrt(norm[0]);
        norm[1] = sqrt(norm[1]);

        f[i-1] = norm[0] - norm[1];

        for(j=0; j<3; j++){
           del_f[i-1][j] = (x_t_0[j] - anchors_mat[i][j])/norm[0] - (x_t_0[j] - anchors_mat[0][j])/norm[1];
        }
    }

#ifdef DEBUG
    printf("\nx_t_0:\n");
    for(int i=0; i<3; i++) printf("%f ",x_t_0[i]);
    printf("\n");
    
    printf("\nf:\n");
    for(int i=0; i<NUM_ANCH-1; i++) printf("%f ",f[i]);
    printf("\n");
    
    printf("\ndel_f:\n");
    for(int i=0; i<NUM_ANCH-1; i++){
        for(int j=0; j<3; j++) printf("%.8f ",del_f[i][j]);
        printf("\n");
    }
#endif

    //row 98
    //flatten del_f
    double del_f_flat[(NUM_ANCH-1)*3];
    trans_2D_1D_5_3(del_f, del_f_flat);
    //flat pseudoinverse of del_f
    double pinv_del_f_flat[3*(NUM_ANCH-1)];
    inverted = pseudoinverse(del_f_flat, pinv_del_f_flat, NUM_ANCH-1, 3); 
    if(!inverted) return false;

#ifdef DEBUG
    printf("\npinv_del_f:\n");
    display_flat_matrix(pinv_del_f_flat,3,NUM_ANCH-1);
#endif

    //perform matrix product and sum x_t_0
    for(i=0; i<3; i++){
        x_t[i] = x_t_0[i];
        for(j=0; j<NUM_ANCH-1; j++){
            x_t[i] += pinv_del_f_flat[i * (NUM_ANCH-1) + j]*(tdoa[j]-f[j]);
        }
    }

    return true;

}