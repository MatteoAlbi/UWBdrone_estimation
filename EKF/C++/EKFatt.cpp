#include "EKFatt.hpp"

EKFatt::EKFatt() : EKF(7) {}
EKFatt::EKFatt(Matrix x, Matrix p) : EKF(7, x, p) {} 


void EKFatt::predict(const Matrix & U, const Matrix & Ru, double dt){
    if(U.getC() != 1 || U.getR() != 3) throw invalid_argument("U must be a 3x1 column vec");
    if(Ru.getC() != 3 || Ru.getR() != 3) throw invalid_argument("Ru must be a 3x3 matrix");

    // compute new state
    Matrix wNoBias = U - this->X({4,6},{});
    double v1[16] = {0, -wNoBias(0), -wNoBias(1), -wNoBias(2),
                    0, 0, wNoBias(2), -wNoBias(1),
                    0, 0, 0, wNoBias(0),
                    0, 0, 0, 0};
    Matrix Sw = Matrix(4, 4, v1);
    Sw -= Sw.t();
    
    this->X.setV({0,3},{}, ( (Sw*dt/2 + IdMat(4)) * this->X({0,3},{}) ).getV());
    // this->X.setV({4,6},{}, this->X({4,6},{}).getV());
    // normalize state quaternion
    this->X.setV({0,3},{}, this->X({0,3},{}).normalize().getV());

    // propagate uncertainties
    double v2[12] = {-this->X(1), -this->X(2), -this->X(3),
                    this->X(0), -this->X(3), this->X(2),
                    this->X(3), this->X(0), -this->X(1),
                    -this->X(2), this->X(1), this->X(0)};
    Matrix tmp = Matrix(4, 3, v2)*dt/2;

    Matrix JfU = tmp | 
                 Matrix(3,3);
    Matrix JfX = (Sw*dt/2 + IdMat(4)) & tmp*(-1) |
                 Matrix(3,4) & IdMat(3);

    this->P.setV((JfX * this->P * JfX.t() + JfU * Ru * JfU.t()).getV());
}

void EKFatt::update(const Matrix & Z, const Matrix & Rz){
    if(Z.getC() != 1 || Z.getR() != 4) throw invalid_argument("Z must be a 4x1 column vec");
    if(Rz.getC() != 4 || Rz.getR() != 4) throw invalid_argument("Rz must be a 4x4 matrix");

    // function h
    double h[4] = { -2*this->X(2)*this->X(0) + 2*this->X(3)*this->X(1),
                    2*this->X(1)*this->X(0) + 2*this->X(3)*this->X(2),
                    pow(this->X(0),2) - pow(this->X(1),2) - pow(this->X(2),2) + pow(this->X(3),2),
                    2*this->X(3)*this->X(0) + 2*this->X(2)*this->X(1)};
    Matrix Zpred = Matrix(4, 1, h);
    // jacobian of h
    double jh[16] = { -this->X(2), this->X(3), -this->X(0), this->X(1),
                      this->X(1), this->X(0), this->X(3), this->X(2),
                      this->X(0), -this->X(1), -this->X(2), this->X(3),
                      this->X(3), this->X(2), this->X(1), this->X(0)};
    Matrix Jh = Matrix(4, 7);
    Jh.setV({0,3},{0,3}, jh);

    // kalmann steps  
    Matrix inn = Z - Zpred;
    Matrix S = Jh * this->P * Jh.t() + Rz;
    Matrix W = this->P * Jh.t() / S;
    this->X += W * inn;
    this->P.setV( (IdMat(7) - W * Jh).getV() );

    // normalize state quaternion
    this->X.setV({0,3},{}, this->X({0,3},{}).normalize().getV());    
}
