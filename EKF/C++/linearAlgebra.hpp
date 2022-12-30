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
        /**
         * @brief get operator using ()
         * 
         * @param r row index
         * @param c columns index
         * @return double& element in position (r,c)
         */
        double& operator()(const uint & r, const uint & c);

        /**
         * @brief const get operator using ()
         * 
         * @param r row index
         * @param c columns index
         * @return const double& element in position (r,c)
         */
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
        
        /**
         * @brief compute transpose
         * 
         * @return Matrix: transpose
         */
        Matrix t() const;

        /**
         * @brief compute cofactor matrix with respect indeces p and q
         * 
         * @param p row index
         * @param q column index
         * @return Matrix: cofactor matrix in position (p,q)
         */
        Matrix cof(const uint & p, const uint & q) const;

        /**
         * @brief compute determinant
         * 
         * @return double: determinant
         */
        double det() const;

        /**
         * @brief create adjoint of the matrix
         * 
         * @return Matrix: adjoint
         */
        Matrix adj() const;

        /**
         * @brief compute inverse of the matrix using adjoint/det method
         * 
         * @return Matrix: inerse
         */
        Matrix inv() const;

        /**
         * @brief compute left pseudo-inverse of the matrix 
         * using ((A'*A)^-1)*A'with A' transpose of A
         * 
         * @return Matrix: left pseudo-inverse
         */
        Matrix pinv_left() const;

        /**
         * @brief return norm2: sqrt(sum(v(i)^2)) of the given vector
         * 
         * @return double: norm2 of the vector
         */
        double norm2() const;

        /**
         * @brief return the normalized vector
         * 
         * @return Matrix: normalized vector (matrix with one dim=1)
         */
        Matrix normalize() const;

        /**
         * @brief normalized the vector, modifying current object
         * 
         */
        void normalize_self();
};

// cout operators
ostream& operator<<(ostream& os, const Matrix& m);
ostream& operator<<(ostream& os, const Matrix * m);

// math operators
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

/**
 * @brief concatenates matrices per columns
 * 
 * @param m1 first matrix
 * @param m2 second matrix
 * @return Matrix 
 */
Matrix operator&(const Matrix& m1, const Matrix& m2);

/**
 * @brief concatenates matrices per rows
 * 
 * @param m1 first matrix
 * @param m2 second matrix
 * @return Matrix
 */
Matrix operator|(const Matrix& m1, const Matrix& m2);

// creation of particular matrices

/**
 * @brief create identity matrix of shape dim*dim 
 * 
 * @param dim 
 * @return Matrix 
 */
Matrix IdMat(const uint & dim);

/**
 * @brief create matrix of only ones of shape r*c
 * 
 * @param r 
 * @param c 
 * @return Matrix 
 */
Matrix Ones(const uint & r, const uint & c);


Matrix diag(const uint & dim, double * v);
double * diag(const Matrix & m);

#endif