#include "linearAlgebra.hpp"

double& Matrix::operator()(const uint & r, const uint & c){
    if(r >= this->r) throw out_of_range("Row index out of range");
    if(c >= this->c) throw out_of_range("Col index out of range");
    return this->v[r * this->c + c];
}

const double& Matrix::operator()(const uint & r, const uint & c) const{
    if(r >= this->r) throw out_of_range("Row index out of range");
    if(c >= this->c) throw out_of_range("Col index out of range");
    return this->v[r * this->c + c];
}

double& Matrix::operator()(const uint & i){
    if(this->c == 1){
        if(i >= this->r) throw out_of_range("Index out of range");
        return this->operator()(i,0);
    } 
    else if(this->r == 1){
        if(i >= this->c) throw out_of_range("Index out of range");
        return this->operator()(0,i);
    }
    else{
        if(i >= this->r || i >= this->c) throw out_of_range("Index out of range");
        return this->operator()(i,i);
    }
}

const double& Matrix::operator()(const uint & i) const{
    if(this->c == 1){
        if(i >= this->r) throw out_of_range("Index out of range");
        return this->operator()(i,0);
    } 
    else if(this->r == 1){
        if(i >= this->c) throw out_of_range("Index out of range");
        return this->operator()(0,i);
    }
    else{
        if(i >= this->r || i >= this->c) throw out_of_range("Index out of range");
        return this->operator()(i,i);
    }
}

Matrix Matrix::operator()(pair<uint,uint> rs, const uint & c) const{
    if(rs.second >= this->r) throw out_of_range("Row index out of range");
    if(c >= this->c) throw out_of_range("Col index out of range");
    if(rs.first > rs.second) throw invalid_argument("Row first element must be <= of second");

    if(rs.first == 0 && rs.second == 0) rs.second = this->r-1;
    Matrix ret = Matrix(rs.second - rs.first + 1, 1);

    for(uint i=0; i<ret.r; i++){
        ret(i,0) = this->operator()(i + rs.first, c);
    }

    return ret;
}

Matrix Matrix::operator()(const uint & r, pair<uint,uint> cs) const{
    if(r >= this->r) throw out_of_range("Row index out of range");
    if(cs.second >= this->c) throw out_of_range("Col index out of range");
    if(cs.first > cs.second) throw invalid_argument("Col first element must be <= of second");

    if(cs.first == 0 && cs.second == 0) cs.second = this->c-1;
    Matrix ret = Matrix(1, cs.second - cs.first + 1);

    for(uint j=0; j<ret.c; j++){
        ret(0,j) = this->operator()(r, j + cs.first);
    }

    return ret;
}

Matrix Matrix::operator()(pair<uint,uint> rs, pair<uint,uint> cs) const{
    if(rs.second >= this->r) throw out_of_range("Row index out of range");
    if(cs.second >= this->c) throw out_of_range("Col index out of range");
    if(rs.first > rs.second) throw invalid_argument("Row first element must be <= of second"); 
    if(cs.first > cs.second) throw invalid_argument("Col first element must be <= of second");

    if(rs.first == 0 && rs.second == 0) rs.second = this->r-1;
    if(cs.first == 0 && cs.second == 0) cs.second = this->c-1;
    Matrix ret = Matrix(rs.second - rs.first + 1, cs.second - cs.first + 1);

    for(uint i=0; i<ret.r; i++){
        for(uint j=0; j<ret.c; j++){
            ret(i,j) = this->operator()(i + rs.first, j + cs.first);
        }
    }

    return ret;
}

Matrix& Matrix::operator=(const Matrix& m){
    this->r = m.r;
    this->c = m.c;
    if(this->v != nullptr) delete[] this->v;
    this->v = new double[this->r*this->c];
    this->setV(m.getV());

    return *this;
}



void Matrix::operator+=(const double & k){
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) += k;
        }
    }
}

void Matrix::operator+=(const int & k){
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) += k;
        }
    }
}

void Matrix::operator+=(const Matrix & m){
    if(this->r != m.r || this->c != m.c) throw invalid_argument("Matrices' shapes don't match");
    
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) += m(i,j);
        }
    }
}

void Matrix::operator-=(const double & k){
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) -= k;
        }
    }
}

void Matrix::operator-=(const int & k){
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) -= k;
        }
    }
}

void Matrix::operator-=(const Matrix & m){
    if(this->r != m.r || this->c != m.c) throw invalid_argument("Matrices' shapes don't match");
    
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) -= m(i,j);
        }
    }
}

void Matrix::operator*=(const double & k){
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) *= k;
        }
    }
}

void Matrix::operator*=(const int & k){
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) *= k;
        }
    }
}

void Matrix::operator*=(const Matrix & m){
    if(this->c != m.r) throw invalid_argument("Matrices' shapes don't match");
    
    double v[this->r * m.c];

    for (uint i = 0; i<this->r; i++) {
        for (uint j = 0; j<m.c; j++) {
            v[i * m.c + j] = 0;
            for (uint k = 0; k<this->c; k++) {
                v[i * m.c + j] += this->operator()(i,k) * m(k,j);
            }
        }
    }

    this->c = m.c;
    this->setV(v);
}

void Matrix::operator/=(const double & k){
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) /= k;
        }
    }
}

void Matrix::operator/=(const int & k){
    for(uint i=0; i<this->r; i++){
        for(uint j=0; j<this->c; j++){
            this->operator()(i,j) /= k;
        }
    }
}

void Matrix::operator/=(const Matrix & m){
    Matrix inv;
    try
    {
        if(m.getC() == m.getR()) inv = m.inv();
        else inv = m.pinv_left();
    }
    catch(const std::exception& e)
    {
        std::cerr << e.what() << '\n';
        throw invalid_argument("Matrix m not invertible");
    }    

    this->operator*=(inv);
}



void Matrix::operator&=(const Matrix & m){
    if(this->r != m.r) throw invalid_argument("Matrices must have same number of rows");
    
    uint totC = this->c + m.c;
    double v[this->r * totC];

    for (uint i = 0; i<this->r; i++) {
        for (uint j = 0; j<totC; j++) {
            if(j < this->c) v[i * totC + j] = this->operator()(i,j);
            else v[i * totC + j] = m(i,j-this->c);
        }
    }

    this->c += m.c;
    this->setV(v);
}

void Matrix::operator|=(const Matrix & m){
    if(this->c != m.c) throw invalid_argument("Matrices must have same number of columns");
    
    uint totR = this->r + m.r;
    double v[totR * this->c];

    for (uint i = 0; i<totR; i++) {
        for (uint j = 0; j<this->c; j++) {
            if(i < this->r) v[i * this->c + j] = this->operator()(i,j);
            else v[i * this->c + j] = m(i-this->r,j);
        }
    }
    
    this->r += m.r;
    this->setV(v);
}



Matrix::Matrix(){
    this->r = 0;
    this->c = 0;
    this->v = nullptr;
}

Matrix::Matrix(const uint & r, const uint & c) {
    this->r = r;
    this->c = c;
    this->v = new double[this->r*this->c]();
}

Matrix::Matrix(const uint & r, const uint & c, const double * v) {
    this->r = r;
    this->c = c;
    this->v = new double[this->r*this->c];
    this->setV(v);   
}

Matrix::Matrix(Matrix & m){
    this->r = m.r;
    this->c = m.c;
    this->v = new double[this->r*this->c];
    this->setV(m.getV());
}

Matrix::Matrix(const Matrix & m){
    this->r = m.r;
    this->c = m.c;
    this->v = new double[this->r*this->c];
    this->setV(m.getV());
}

Matrix::~Matrix() {
    if(this->v != nullptr) delete[] this->v;
}



const uint & Matrix::getR() const{
    return this->r;
}

const uint & Matrix::getC() const{
    return this->c;
}

const double* Matrix::getV() const{
    return this->v;
}

void Matrix::setV(const double * v){
    try{
        for (uint i = 0; i < this->r; i++){
            for (uint j = 0; j < this->c; j++){
                this->operator()(i,j) = v[i * this->c + j];
            }
        }
    }
    catch(const exception& e){
        cerr << e.what() << '\n';
        throw out_of_range("Not enough values in v to init the matrix");
    }
}

void Matrix::setV(pair<uint,uint> rs, pair<uint,uint> cs, const double * v){
    if(rs.second >= this->r) throw out_of_range("Row index out of range");
    if(cs.second >= this->c) throw out_of_range("Col index out of range");
    if(rs.first > rs.second) throw invalid_argument("Row first element must be <= of second"); 
    if(cs.first > cs.second) throw invalid_argument("Col first element must be <= of second");

    if(rs.first == 0 && rs.second == 0) rs.second = this->r-1;
    if(cs.first == 0 && cs.second == 0) cs.second = this->c-1;

    uint nRows = rs.second - rs.first + 1;
    uint nCols = cs.second - cs.first + 1;

    try{
        for (uint i = 0; i < nRows; i++){
            for (uint j = 0; j < nCols; j++){
                this->operator()(i + rs.first, j + cs.first) = v[i * nCols + j];
            }
        }
    }
    catch(const exception& e){
        cerr << e.what() << '\n';
        throw out_of_range("Not enough values in v to init the matrix");
    }
}



Matrix Matrix::t() const{
    Matrix ret = Matrix(this->c, this->r);
    for (uint i = 0; i<this->r; i++) {
        for (uint j = 0; j<this->c; j++) {
            ret.v[j * ret.c + i] = this->v[i * this->c + j];
        }
    }
    return ret;
}

Matrix Matrix::cof(const uint & p, const uint & q) const{
    if(this->r < p || this->c < q) throw invalid_argument("p or q exceed matrix boundaries");

    uint i = 0, j = 0;

    Matrix ret = Matrix(this->r-1,this->c-1);

    // Looping for each element of the matrix
    for (uint row = 0; row < this->r; row++){

        for (uint col = 0; col < this->c; col++){

            // Copying into result matrix only those element
            // which are not in given row and column
            if (row != p && col != q){
                ret(i,j) = this->operator()(row,col);
                j++;
 
                // Row is filled, so increase row index and
                // reset col index
                if (j == ret.c){
                    j = 0;
                    i++;
                }
            }
        }
    }

    return ret;
}

double Matrix::det() const{
    if(this->r != this->c) throw invalid_argument("The matrix must be square");

    // Base case : if matrix contains single element
    if (this->r == 1){
        return this->v[0];
    } 
    // if matrix is 2x2
    else if (this->r == 2){
        return this->v[0]*this->v[3] - this->v[1]*this->v[2];
    }

    else{
        double D = 0; // Initialize result

        Matrix cof = Matrix(); // To store cofactors
        int sign = 1; // To store sign multiplier
    
        // Iterate for each element of first row
        for (uint j = 0; j < this->c; j++){
            // Getting Cofactor of m->v[0][f]
            cof = this->cof(0, j);
            D += sign * this->v[j] * cof.det();
    
            // terms are to be added with alternate sign
            sign = -sign;
        }

        return D;
    }
}

Matrix Matrix::adj() const{
    if(this->r != this->c) throw invalid_argument("The matrix must be square");

    Matrix ret = Matrix(this->r, this->c);

    if (this->r == 1){
        ret.v[0] = 1;
        return ret;
    }

    int sign = 1;
    Matrix cof; // To store cofactors

    for (uint i=0; i<this->r; i++){
        for (uint j=0; j<this->c; j++){
            // Get cofactor
            cof = this->cof(i,j);
 
            // sign of adj positive if sum of row
            // and column indexes is even.
            sign = ((i+j)%2==0) ? 1 : -1;
 
            // Interchanging rows and columns to get the
            // transpose of the cofactor matrix
            ret(i,j) = sign*cof.det();
        }
    }

    return ret;
}

Matrix Matrix::inv() const{
    if(this->r != this->c) throw invalid_argument("The matrix must be square");

    // Find determinant of A
    double det = this->det(); 
    if (det == 0) throw runtime_error("Matrix not invertible: det = 0");
 
    // Find Inverse using formula "inverse(m) = adj(m)^t/det(m)"
    return this->adj().t() / det;
}

Matrix Matrix::pinv_left() const{
    try{
        return (this->t() * (*this)).inv() * this->t();
    }
    catch(const runtime_error& rte){
        std::cerr << rte.what() << '\n';
        throw runtime_error("Matrix (m.t * m) not invertible");
    }
    catch(const exception& e){
        std::cerr << e.what() << '\n';
        throw runtime_error("Unknown error occured");
    }
}

double Matrix::norm2() const{
    if(this->r == 1 || this->c == 1){
        double ret = 0;
        for(uint i=0; i< this->r+this->c-1; i++){
            ret += pow(this->v[i],2);
        }
        return sqrt(ret);
    }
    else{
        // cout << "Norm only appliable to row/column vectors" << endl;
        // return NULL;
        throw invalid_argument("Norm only appliable to row/column vectors");
    }
}

Matrix Matrix::normalize() const{
    return Matrix(*this) / this->norm2();
}

void Matrix::normalize_self(){
    this->operator/=(this->norm2());
}



ostream& operator<<(ostream& os, const Matrix& m){
    os << "Matrix(" << m.getR() << "x" << m.getC() << ")" << endl;
    for(uint i=0; i<m.getR(); i++){
        if(i>0) os << endl;
        for(uint j=0; j<m.getC(); j++){
            if(j>0) os << " ";
            os << m(i,j);
        }
    }
    
    return os;
}

ostream& operator<<(ostream& os, const Matrix * m){
    os << "Matrix(" << m->getR() << "x" << m->getC() << ")" << endl;
    for(uint i=0; i<m->getR(); i++){
        if(i>0) os << endl;
        for(uint j=0; j<m->getC(); j++){
            if(j>0) os << " ";
            os << m->operator()(i,j);
        }
    }
    
    return os;
}

Matrix operator+(const Matrix& m, const double& k){
    Matrix ret = Matrix(m.getR(), m.getC());

    for (uint i = 0; i<m.getR(); i++) {
        for (uint j = 0; j<m.getC(); j++) {
            ret(i, j) = m(i, j) + k;
        }
    }

    return ret;
}

Matrix operator+(const Matrix& m, const int& k){
    Matrix ret = Matrix(m.getR(), m.getC());

    for (uint i = 0; i<m.getR(); i++) {
        for (uint j = 0; j<m.getC(); j++) {
            ret(i, j) = m(i, j) + k;
        }
    }

    return ret;
}

Matrix operator+(const Matrix& m1, const Matrix& m2){
    if(m1.getR() != m2.getR() || m1.getC() != m2.getC()) throw invalid_argument("Matrices' shapes don't match");
    
    Matrix ret = Matrix(m1.getR(), m1.getC());

    for (uint i = 0; i<m1.getR(); i++) {
        for (uint j = 0; j<m1.getC(); j++) {
            ret(i, j) = m1(i, j) + m2(i, j);
        }
    }

    return ret;
}

Matrix operator-(const Matrix& m, const double& k){
    Matrix ret = Matrix(m.getR(), m.getC());

    for (uint i = 0; i<m.getR(); i++) {
        for (uint j = 0; j<m.getC(); j++) {
            ret(i, j) = m(i, j) - k;
        }
    }

    return ret;
}

Matrix operator-(const Matrix& m, const int& k){
    Matrix ret = Matrix(m.getR(), m.getC());

    for (uint i = 0; i<m.getR(); i++) {
        for (uint j = 0; j<m.getC(); j++) {
            ret(i, j) = m(i, j) - k;
        }
    }

    return ret;
}

Matrix operator-(const Matrix& m1, const Matrix& m2){
    if(m1.getR() != m2.getR() || m1.getC() != m2.getC()) throw invalid_argument("Matrices' shapes don't match");
    
    Matrix ret = Matrix(m1.getR(), m1.getC());

    for (uint i = 0; i<m1.getR(); i++) {
        for (uint j = 0; j<m1.getC(); j++) {
            ret(i, j) = m1(i, j) - m2(i, j);
        }
    }

    return ret;
}

Matrix operator*(const Matrix& m, const double& k){
    Matrix ret = Matrix(m.getR(), m.getC());

    for (uint i = 0; i<m.getR(); i++) {
        for (uint j = 0; j<m.getC(); j++) {
            ret(i, j) = m(i, j) * k;
        }
    }

    return ret;
}

Matrix operator*(const Matrix& m, const int& k){
    Matrix ret = Matrix(m.getR(), m.getC());

    for (uint i = 0; i<m.getR(); i++) {
        for (uint j = 0; j<m.getC(); j++) {
            ret(i, j) = m(i, j) * k;
        }
    }

    return ret;
}

Matrix operator*(const Matrix& m1, const Matrix& m2){
    if(m1.getC() != m2.getR()) throw invalid_argument("Matrices' shapes don't match");
    
    Matrix ret = Matrix(m1.getR(), m2.getC());

    for (uint i = 0; i<m1.getR(); i++) {
        for (uint j = 0; j<m2.getC(); j++) {
            ret(i,j) = 0;
            for (uint k = 0; k<m1.getC(); k++) {
                ret(i,j) += m1(i,k) * m2(k,j);
            }
        }
    }

    return ret;
}

Matrix operator/(const Matrix& m, const double& k){
    Matrix ret = Matrix(m.getR(), m.getC());

    for (uint i = 0; i<m.getR(); i++) {
        for (uint j = 0; j<m.getC(); j++) {
            ret(i, j) = m(i, j) / k;
        }
    }

    return ret;
}

Matrix operator/(const Matrix& m, const int& k){
    Matrix ret = Matrix(m.getR(), m.getC());

    for (uint i = 0; i<m.getR(); i++) {
        for (uint j = 0; j<m.getC(); j++) {
            ret(i, j) = m(i, j) / k;
        }
    }

    return ret;
}

Matrix operator/(const Matrix& m1, const Matrix& m2){
    Matrix inv;
    try
    {
        if(m2.getC() == m2.getR()) inv = m2.inv();
        else inv = m2.pinv_left();
    }
    catch(const std::exception& e)
    {
        std::cerr << e.what() << '\n';
        throw invalid_argument("Matrix m2 not invertible");
    }    

    return m1*inv;
}



Matrix operator&(const Matrix& m1, const Matrix& m2){
    if(m1.getR() != m2.getR()) throw invalid_argument("Matrices must have same number of rows");

    Matrix ret = Matrix(m1.getR(), m1.getC()+m2.getC());

    for(uint i=0; i<ret.getR(); i++){
        for(uint j=0; j<ret.getC(); j++){
            if(j < m1.getC()) ret(i,j) = m1(i,j);
            else ret(i,j) = m2(i,j-m1.getC());
        }
    }

    return ret;
}

Matrix operator|(const Matrix& m1, const Matrix& m2){
    if(m1.getC() != m2.getC()) throw invalid_argument("Matrices must have same number of columns");

    Matrix ret = Matrix(m1.getR()+m2.getR(), m1.getC());

    for(uint i=0; i<ret.getR(); i++){
        for(uint j=0; j<ret.getC(); j++){
            if(i < m1.getR()) ret(i,j) = m1(i,j);
            else ret(i,j) = m2(i-m1.getR(),j);
        }
    }

    return ret;
}



Matrix IdMat(const uint & dim){
    Matrix ret = Matrix(dim,dim);
    for(uint i=0; i<dim; i++){
        ret(i,i) = 1;
    }
    return ret;
}

Matrix Ones(const uint & r, const uint & c){
    return Matrix(r,c)+1;
}

Matrix diag(const uint & dim, double * v){
    Matrix ret = Matrix(dim,dim);
    
    for(uint i=0; i<dim; i++){
        ret(i,i) = v[i];
    }

    return ret;
}

double * diag(const Matrix & m){
    uint dim = min(m.getC(),m.getR());
    double * v = new double[dim]();

    for(uint i=0;i<dim; i++){
        v[i] = m(i,i);
    }

    return v;
}



