#include "linearAlgebra.hpp"

int main() {
        double v[25] = {21,12,32,10,
                        10,72,92,62,
                        11,12,42,2,
                        6,10,8,9,
                        2,9,0,4};

    Matrix m = Matrix(5,4,v);
    cout << m << endl;
    cout << m.t()*m << endl;
    cout << (m.t()*m).det() << endl;
    cout << m.pinv() << endl;
    cout << IdMat(4) << endl;
    cout << Ones(3,1) << endl;
    cout << (diag(5, v)&Ones(5,2) | Matrix(3,5)&Ones(3,2))<< endl;
    
    m.setV({0,2},{0,2},Matrix(3,3).getV());
    cout << m << endl;

    return 0;
}