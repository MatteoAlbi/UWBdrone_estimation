#include "rTDoA_est_opt.h"

static double tmp1;
static double tmp2;
static double tmp_m1_flat[NUM_ANCH*4];
static double tmp_m2_flat[NUM_ANCH*4];
static double tmp_v1[NUM_ANCH];
static double tmp_v2[NUM_ANCH];
static double tmp_v3[NUM_ANCH];

static uint16_t n_samples;
static double dt_avg[6];

// Anchors position
static double anchors_mat[6][3] = { {0,0,2.65},
                                    {-1.840, 4.683, 2.961},
                                    {2.160, 4.648, 2.632},
                                    {8.085, 4.602, 2.938},
                                    {7.626, -1.416, 2.637},
                                    {4.116, -1.369, 2.735} };

bool rTDoA(uint64_t ts_param[NUM_ANCH][4], FILE * out){
    
    int i,j;
#ifdef DEBUG
    printf("n_samples: %d\n",n_samples);
    printf("dt_avg: ");
    for(int i=0;i<NUM_ANCH;i++) printf("%.10f ",dt_avg[i]);
    printf("\n");
#endif

    //tx and rx values, rows 3:29
    for(i=0; i<NUM_ANCH; i++){
        for(j=0; j<4; j++){
            tmp_m1_flat[i * 4 + j] = (double) (ts_param[i][j] / TIME_CONST);
        }
    }

#ifdef DEBUG
    printf("\nts:\n");
    display_flat_matrix(tmp_m1_flat,NUM_ANCH,4);
#endif

    //drift tag
    //rows 51:55
    for(i=0; i<NUM_ANCH; i++){
        tmp1 = (tmp_m1_flat[i * 4 + 3]-tmp_m1_flat[i * 4 + 2]);
        if(tmp1 == 0){ // DIV BY 0
            fprintf(out,"%d %d %d\n", 0, 0, 0);
            return false;
        }
        tmp_v1[i] = (tmp_m1_flat[i * 4 + 1] - tmp_m1_flat[i * 4 + 0])/tmp1;
    }
    // check dt distribution
    // tmp1 = 1;
    // for(i=0;i<NUM_ANCH;i++){
    //     if(tmp_v1[i]-1 > SIGMA) tmp1 = 0;
    // }
    
    // for(i=0;i<NUM_ANCH;i++){
    //     // if acceptable: update avg    
    //     if(tmp1){
    //         dt_avg[i] = (dt_avg[i] * n_samples + tmp_v1[i]) / (n_samples+1); 
    //     }
    //     // use avg as dt
    //     tmp_v1[i] = dt_avg[i];
    // }
    // if(tmp1) n_samples++;

    

#ifdef DEBUG
    printf("\ndt:\n");
    for(int i=0; i<NUM_ANCH; i++) printf("%f ",tmp_v1[i]);
    printf("\n");
#endif
     
    //TDoA
    //rows 72:77
    tmp1 = tmp_v1[0];
    for(i=1; i<NUM_ANCH; i++){
        tmp_v1[i-1] = SPEED_OF_LIGHT * (tmp_m1_flat[i * 4 + 1] - tmp_m1_flat[0 * 4 + 1] - (tmp_m1_flat[i * 4 + 3]*tmp_v1[i] - tmp_m1_flat[0 * 4 + 3]*tmp1));
    }

#ifdef DEBUG
    printf("\ntdoa:\n");
    for(int i=0; i<NUM_ANCH-1; i++) printf("%.15f ",tmp_v1[i]);
    printf("\n");
#endif

    // trilateral linear equation system

    // coefficient matrix A
    //row 80
    for(j=0; j<3; j++){
        for(i=1; i<NUM_ANCH; i++){
            tmp_m1_flat[(i-1) * 4 + j] = (anchors_mat[0][j] - anchors_mat[i][j])*2;
        }
    }
    for(i=0; i<NUM_ANCH-1; i++){
        tmp_m1_flat[i * 4 + 3] = tmp_v1[i]*2;
    }

#ifdef DEBUG
    printf("\nA:\n");
    display_flat_matrix(tmp_m1_flat,5,4);
#endif

    // rhs vector b
    //row 81
    tmp2 = 0;

    for(j=0; j<3; j++){
        tmp2 += pow(anchors_mat[0][j],2);
    }

    for(i=1; i<NUM_ANCH; i++){
        tmp1 = 0;
        for(j=0; j<3; j++){
            tmp1 += pow(anchors_mat[i][j],2);
        }
        tmp_v2[i-1] = pow(tmp_v1[i-1],2) + tmp2 - tmp1;
    }

#ifdef DEBUG
    printf("\nb:\n");
    for(int i=0; i<NUM_ANCH-1; i++) printf("%f ",tmp_v2[i]);
    printf("\n");
#endif

    // solve linear system with pseudoinverse
    //row 82
    //pseudoinverse of A
    if(! pseudoinverse(tmp_m1_flat, tmp_m2_flat, NUM_ANCH-1, 4) ){// Matrix A non invertible
        fprintf(out,"%d %d %d\n", 5, 0, 0);
        return false;
    }

#ifdef DEBUG
    printf("\npinvA:\n");
    display_flat_matrix(tmp_m2_flat,4,NUM_ANCH-1);
#endif
    
    //perform matrix product
    for(i=0; i<4; i++){
        tmp_v3[i] = 0;
        for(j=0; j<NUM_ANCH-1; j++){
            tmp_v3[i] += tmp_m2_flat[i * (NUM_ANCH-1) + j] * tmp_v2[j];
        }
    }

#ifdef DEBUG
    printf("\nx_t0:\n");
    for(int i=0; i<4; i++) printf("%f ",tmp_v3[i]);
    printf("\n");
#endif

    //Non linear correction (Taylor Expansion)
    //rows 89:96
    for(i=1; i<NUM_ANCH; i++){

        tmp1 = 0;
        tmp2 = 0;
        for(j=0; j<3; j++){
            tmp1 += pow(tmp_v3[j] - anchors_mat[i][j], 2);
            tmp2 += pow(tmp_v3[j] - anchors_mat[0][j], 2);
        }

        if(tmp1 == 0 || tmp2 == 0){// DIV BY 0
            fprintf(out,"%d %d %d\n", 0, 0, 0);
            return false;
        }
        
        tmp1 = sqrt(tmp1);
        tmp2 = sqrt(tmp2);

        tmp_v2[i-1] = tmp1 - tmp2;

        for(j=0; j<3; j++){
           tmp_m1_flat[(i-1) * 3 + j] = (tmp_v3[j] - anchors_mat[i][j])/tmp1 - (tmp_v3[j] - anchors_mat[0][j])/tmp2;
        }
    }

#ifdef DEBUG
    printf("\nx_t_0:\n");
    for(int i=0; i<3; i++) printf("%f ",tmp_v3[i]);
    printf("\n");
    
    printf("\nf:\n");
    for(int i=0; i<NUM_ANCH-1; i++) printf("%f ",tmp_v2[i]);
    printf("\n");
    
    printf("\ndel_f:\n");
    display_flat_matrix(tmp_m1_flat,NUM_ANCH-1,3);
#endif

    //row 98
    //pseudoinverse of del_f
    if(! pseudoinverse(tmp_m1_flat, tmp_m2_flat, NUM_ANCH-1, 3) ) {// Matrix A non invertible
        fprintf(out,"%d %d %d\n", 5, 0, 0);
        return false;
    }

#ifdef DEBUG
    printf("\npinv_del_f:\n");
    display_flat_matrix(tmp_m2_flat,3,NUM_ANCH-1);
#endif

    //perform matrix product and sum x_t_0
    for(i=0; i<3; i++){
        for(j=0; j<NUM_ANCH-1; j++){
            tmp_v3[i] += tmp_m2_flat[i * (NUM_ANCH-1) + j]*(tmp_v1[j]-tmp_v2[j]);
        }
    }

    fprintf(out,"%f %f %f\n", tmp_v3[0], tmp_v3[1], tmp_v3[2]);

    return true;

}