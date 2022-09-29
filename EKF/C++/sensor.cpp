#include "sensor.hpp"

Sensor::Sensor(const int & n){
    this->N = n;
    this->value = Matrix(n,1);
    this->bias = Matrix(n,1);
    this->scale = Matrix(n,1);
    this->R = Matrix(n,n);
}

Sensor::Sensor(const int & n, const Matrix & r){
    this->N = n;
    if(r.getC() != n || r.getR() != n) throw invalid_argument("R must be a NxN matrix");
    this->R = r;
    this->value = Matrix(n,1);
    this->bias = Matrix(n,1);
    this->scale = Matrix(n,1);
}



const int & Sensor::getN() const{
    return this->N;
}

const Matrix & Sensor::getValue() const{
    return this->value;
}

const Matrix & Sensor::getBias() const{
    return this->bias;
}

const Matrix & Sensor::getScale() const{
    return this->scale;
}

const Matrix & Sensor::getR() const{
    return this->R;
}



void Sensor::setBias(Matrix b){
    if(b.getC() != 1 || b.getR() != this->N) throw invalid_argument("bias must be a Nx1 column vector");
    this->bias = b;
}

void Sensor::setScale(Matrix s){
    if(s.getC() != 1 || s.getR() != this->N) throw invalid_argument("scale must be a Nx1 column vector");
    this->scale = s;
}

void Sensor::setR(Matrix r){
    if(r.getC() != this->N || r.getR() != this->N) throw invalid_argument("R must be a NxN matrix");
    this->R = r;
}



void Sensor::calibrate(Matrix b, Matrix s){
    if(b.getC() != 1 || b.getR() != this->N) throw invalid_argument("bias must be a Nx1 column vector");
    if(s.getC() != 1 || s.getR() != this->N) throw invalid_argument("scale must be a Nx1 column vector");
    this->bias = b;
    this->scale = s;
}

void Sensor::read(double * v, bool correctBias = false){
    this->value = Matrix(this->N, 1, v);
    for(int i=0; i<this->N; i++){
        this->value(i,0) *= this->scale(i,0);
        if(correctBias) this->value(i,0) -= this->bias(i,0);
    }
}





UWB::UWB() : Sensor(4){
    this->buff_iter = 0;
    this->counter = -1;
    this->vel_ready = false;
    delete &this->bias;
    delete &this->scale;
}



const bool UWB::velReady() const{
    return this->vel_ready;
}

const int & UWB::getBuffIter() const{
    return this->buff_iter;
}

const int & UWB::getCounter() const{
    return this->counter;
}

const double * UWB::getBuffData() const{
    return this->buffer[0];
}



void UWB::read(double * v, Matrix pos, double dt){
    if(v[0] != 0 && abs(v[0]) < 1e4 && (v[0] - pos(0,0)) < 10){
        this->value({0,1},0) = Matrix(2, 1, v);

        this->buffer[this->buff_iter][0] = v[0];
        this->buffer[this->buff_iter][1] = v[1];
        this->buff_iter++;
    }

    if(this->buff_iter > 0) this->counter++;

    if(this->buff_iter > 1){
        double delta_pos[2] = {this->buffer[1][0]-this->buffer[0][0], this->buffer[1][1]-this->buffer[0][1]};
        this->value({2,3}, 0) = Matrix(2, 1, delta_pos) / (this->counter * dt);

        this->R({2,3}, {2,3}) = this->R({0,1}, {0,1}) * 2 / pow(this->counter * dt,2);

        this->buff_iter = 0;
        this->counter = -1;
        this->vel_ready = true;
    }
}

