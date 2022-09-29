#include "EKFpos.hpp"

EKFpos::EKFpos() : EKF(7) {}

EKFpos::EKFpos(Matrix x, Matrix p) : EKF(7, x, p) {} 

void EKFpos::predict(const Matrix & U, const Matrix & Ru, double dt){

    /**
    *  model matrices, NB: matrix A multiplied by pos,vel
    *                      matrix B multiplied by elaborated acceleration (considering bias as well)
    */ 
    double a[16] = {1, 0, dt, 0,
                    0, 1, 0,  dt,
                    0, 0, 1,  0,
                    0, 0, 0,  1};
    Matrix A = Matrix(4, 4, a);
    double b[8] = { pow(dt,2)/2, 0,
                    0,      pow(dt,2)/2,
                    dt,     0,
                    0,      dt};
    Matrix B = Matrix(4, 2, b);
    Matrix H = IdMat(4) & Matrix(4,3);


}