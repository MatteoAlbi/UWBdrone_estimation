#include "rTDoA_est.h"

// Anchors position
//rows 38:43
double anchors_mat[6][3] = {{0,0,2.65},
                            {-1.840, 4.683, 2.961},
                            {2.160, 4.648, 2.632},
                            {8.085, 4.602, 2.938},
                            {7.626, -1.416, 2.637},
                            {4.116, -1.369, 2.735} };  

bool rTDoA(ts_type ts_param[NUM_ANCH][4], double *x_t){
    double tmp;
    bool inverted;
    Matrix * ts = init_matrix(NUM_ANCH,4);

    //tx and rx values, rows 3:29
    for(int i=0; i<ts->r; i++){
        for(int j=0; j<ts->c; j++){
            ts->v[i * ts->c + j] = (double) ts_param[i][j] / TIME_CONST;
        }
    }

#ifdef DEBUG
    printf("\nts:\n");
    display_flat_matrix(ts);
#endif

    //drift tag
    //rows 51:55
    Matrix * dt = init_c_vector(NUM_ANCH);
    double denom;
    for(int i=0; i<NUM_ANCH; i++){
        denom = (ts->v[i * ts->c + 3] - ts->v[i * ts->c + 2]);
        if(denom == 0){
            printf("DIV BY 0: tx1 = tx2\n");
            return false;
        }
        dt->v[i] = (ts->v[i * ts->c + 1] - ts->v[i * ts->c]) / denom;
    }

#ifdef DEBUG
    printf("\ndt:\n");
    display_flat_matrix(dt);
#endif
     
    //TDoA
    //rows 72:77
    Matrix * tdoa = init_c_vector(NUM_ANCH-1);
    for(int i=1; i<NUM_ANCH; i++){
        tdoa->v[i-1] = SPEED_OF_LIGHT * (ts->v[i*ts->c+1] - ts->v[0*ts->c+1] - (ts->v[i*ts->c+3]*dt->v[i] - ts->v[0*ts->c+3]*dt->v[0]));
    }
    del_matrix(ts);
    del_matrix(dt);

#ifdef DEBUG
    printf("\ntdoa:\n");
    display_flat_matrix(tdoa);
#endif

    // trilateral linear equation system

    // coefficient matrix A
    //row 80
    Matrix * A = init_matrix(NUM_ANCH-1,4);
    for(int j=0; j<A->c-1; j++){
        for(int i=1; i<NUM_ANCH; i++){
            A->v[(i-1) * A->c + j] = (anchors_mat[0][j] - anchors_mat[i][j])*2;
        }
    }
    for(int i=0; i<NUM_ANCH-1; i++){
        A->v[i* A->c +3] = tdoa->v[i]*2;
    }

#ifdef DEBUG
    printf("\nA:\n");
    display_flat_matrix(A);
#endif

    // rhs vector b
    //row 81
    Matrix * b = init_c_vector(NUM_ANCH-1);
    double anchor_six_norm_sqr = 0;

    for(int j=0; j<3; j++){
        anchor_six_norm_sqr += pow(anchors_mat[0][j],2);
    }

    for(int i=1; i<NUM_ANCH; i++){
        tmp = 0;
        for(int j=0; j<3; j++){
            tmp += pow(anchors_mat[i][j],2);
        }
        b->v[i-1] = pow(tdoa->v[i-1],2) + anchor_six_norm_sqr - tmp;
    }

#ifdef DEBUG
    printf("\nb:\n");
    display_flat_matrix(b);
#endif

    // solve linear system with pseudoinverse
    //row 82
    //pseudoinverse of A
    Matrix * pinvA = pseudoinverse(A);
    if(pinvA == NULL) return false;
    del_matrix(A);

#ifdef DEBUG
    printf("\npinvA:\n");
    display_flat_matrix(pinvA);
#endif
    
    //perform matrix product
    Matrix * x_t0 = matrix_prod(pinvA,b);
    del_matrix(b);
    del_matrix(pinvA);

#ifdef DEBUG
    printf("\nx_t0:\n");
    display_flat_matrix(x_t0);
#endif

    //Non linear correction (Taylor Expansion)
    //rows 85:87
    Matrix * x_t_0 = init_c_vector_v(3, x_t0->v);
    Matrix * f = init_c_vector(NUM_ANCH-1);
    Matrix * del_f = init_matrix(NUM_ANCH-1,3);
    del_matrix(x_t0);

    //rows 89:96
    for(int i=1; i<NUM_ANCH; i++){

        double norm[2] = {0,0};
        for(int j=0; j<3; j++){
            norm[0] += pow(x_t_0->v[j] - anchors_mat[i][j], 2);
            norm[1] += pow(x_t_0->v[j] - anchors_mat[0][j], 2);
        }

        if(norm[0] == 0 || norm[1] == 0){
            printf("DIV BY 0: norm = 0\n");
            return false;
        }

        norm[0] = sqrt(norm[0]);
        norm[1] = sqrt(norm[1]);

        f->v[i-1] = norm[0] - norm[1];
        for(int j=0; j<3; j++){
            del_f->v[(i-1) * del_f->c + j] = (x_t_0->v[j] - anchors_mat[i][j])/norm[0] - (x_t_0->v[j] - anchors_mat[0][j])/norm[1];
        }
    }

#ifdef DEBUG
    printf("\nx_t_0:\n");
    display_flat_matrix(x_t_0);
    
    printf("\nf:\n");
    display_flat_matrix(f);
    
    printf("\ndel_f:\n");
    display_flat_matrix(del_f);
#endif

    //row 98
    //pseudoinverse of del_f
    Matrix * pinv_del_f = pseudoinverse(del_f);
    if(pinv_del_f == NULL) return false;
    del_matrix(del_f);

#ifdef DEBUG
    printf("\npinv_del_f:\n");
    display_flat_matrix(pinv_del_f);
#endif

    //perform matrix product and sum x_t_0
    for(int i=0; i<3; i++){
        x_t[i] = x_t_0->v[i];
        for(int j=0; j<NUM_ANCH-1; j++){
            x_t[i] += pinv_del_f->v[i * (NUM_ANCH-1) + j]*(tdoa->v[j]-f->v[j]);
        }
    }
    del_matrix(tdoa);
    del_matrix(f);
    del_matrix(pinv_del_f);
    del_matrix(x_t_0);

    return true;
}