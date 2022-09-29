#ifndef LINEAR_ALGEBRA
#define LINEAR_ALGEBRA

#include <stdio.h>
#include <stdbool.h>
#include <stdlib.h>
#include <math.h>
#include <stdexcept>
#include <exception>
#include <iostream>
#include <sstream>
#include <string>
#include <utility>

using namespace std;
typedef unsigned int uint;

class Matrix {
    protected: 
        uint r;
        uint c;
        double * v;

    public:
        double& operator()(const uint & r, const uint & c);
        const double& operator()(const uint & r, const uint & c) const;
        double& operator()(const uint & i);
        const double& operator()(const uint & i) const;
        Matrix operator()(pair<uint,uint> rs, const uint & c) const;
        Matrix operator()(const uint & r, pair<uint,uint> cs) const;
        Matrix operator()(pair<uint,uint> rs, pair<uint,uint> cs) const;
        Matrix& operator=(const Matrix& m);

        void operator+=(const double & k);
        void operator+=(const int & k);
        void operator+=(const Matrix & m);

        void operator-=(const double & k);
        void operator-=(const int & k);
        void operator-=(const Matrix & m);

        void operator*=(const double & k);
        void operator*=(const int & k);
        void operator*=(const Matrix & m);
        
        void operator/=(const double & k);
        void operator/=(const int & k);
        void operator/=(const Matrix & m);

        /**
         * @brief concatenate matrices per columns
         * 
         * @param m matrix to concatenate
         */
        void operator&=(const Matrix & m);
        /**
         * @brief concatenate matrices per rows
         * 
         * @param m matrix to concatenate
         */
        void operator|=(const Matrix & m);

        Matrix();
        Matrix(const uint & r, const uint & c);
        Matrix(const uint & r, const uint & c, const double * v);
        Matrix(Matrix & m);
        Matrix(const Matrix & m);
        ~Matrix();

        const uint & getR() const;
        const uint & getC() const;
        const double* getV() const;
        void setV(const double * v);
        void setV(pair<uint,uint> rs, pair<uint,uint> cs, const double * v);
        
        Matrix t() const;
        Matrix cof(const uint & p, const uint & q) const;
        double det() const;
        Matrix adj() const;
        Matrix inv() const;
        Matrix pinv() const;
        double norm() const;
        Matrix normalize() const;
        void normalize_self();
};

ostream& operator<<(ostream& os, const Matrix& m);
ostream& operator<<(ostream& os, const Matrix * m);

Matrix operator+(const Matrix& m, const double& k);
Matrix operator+(const Matrix& m, const int & k);
Matrix operator+(const Matrix& m1, const Matrix& m2);

Matrix operator-(const Matrix& m, const double& k);
Matrix operator-(const Matrix& m, const int & k);
Matrix operator-(const Matrix& m1, const Matrix& m2);

Matrix operator*(const Matrix& m, const double& k);
Matrix operator*(const Matrix& m, const int & k);
Matrix operator*(const Matrix& m1, const Matrix& m2);

Matrix operator/(const Matrix& m, const double& k);
Matrix operator/(const Matrix& m, const int & k);
Matrix operator/(const Matrix& m1, const Matrix& m2);

Matrix operator&(const Matrix& m1, const Matrix& m2);
Matrix operator|(const Matrix& m1, const Matrix& m2);

Matrix IdMat(const uint & dim);
Matrix Ones(const uint & r, const uint & c);
Matrix diag(const uint & dim, double * v);
double * diag(const Matrix & m);

#endif