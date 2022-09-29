#include "EKF.hpp"

EKF::EKF(uint N){   
    if(N < 1) throw invalid_argument("The number of states must be at least 1"); 
    this->N = N;
    this->X = Matrix(N,1);
    this->P = Matrix(N,N);
}

EKF::EKF(uint N, Matrix x, Matrix p){  
    if(N < 1) throw invalid_argument("The number of states must be at least 1"); 
    this->N = N;  
    this->init(x,p);
}



const uint& EKF::getN() const{
    return this->N;
}

const Matrix& EKF::getX() const{
    return this->X;
}

const Matrix& EKF::getP() const{
    return this->P;
}



void EKF::init(const Matrix & x, const Matrix & p){
    if(x.getC() != 1 || x.getR() != this->N) throw invalid_argument("X must be a Nx1 column vector");
    if(p.getC() != this->N || p.getR() != this->N) throw invalid_argument("P must be a NxN matrix");
    this->X = x;
    this->P = p;
}

// void EKF::predict(const Matrix & U, const Matrix & Ru, double dt){
//     Matrix jfx = this->JfX(U, dt);
//     Matrix jfu = this->JfU(U, dt);

//     this->X = this->f(U, dt);
//     this->P = jfx * this->P * jfx.t() + jfu * Ru * jfu.t();
// }

// void EKF::update(const Matrix & Z, const Matrix & Rz){
//     Matrix jhx = this->JhX();
    
//     Matrix inn = Z - this->h();
//     Matrix S = jhx * this->P * jhx.t() + Rz;
//     Matrix W = this->P * jhx.t() / S;
//     this->X += W * inn;
//     this->P = (IdMat(this->N) - W * jhx) * this->P;
// }

