#include "linearAlgebra.hpp"

#include <stdbool.h>

class Sensor {
    protected:
        int N;
        Matrix value;
        Matrix bias;
        Matrix scale;
        Matrix R;

    public:
        Sensor(const int & n);
        Sensor(const int & n, const Matrix & r);

        const int & getN() const;
        const Matrix & getBias() const;
        const Matrix & getScale() const;
        const Matrix & getValue() const;
        const Matrix & getR() const;

        void setBias(Matrix b);
        void setScale(Matrix s);
        void setR(Matrix r);

        void calibrate(Matrix b, Matrix s);
        virtual void read(double * v, bool correctBias = false);

};


class UWB: public Sensor{

    protected:
        double buffer[2][2];
        int buff_iter;
        int counter;
        bool vel_ready;
    
    public:
        UWB();

        const bool velReady() const;
        const int & getBuffIter() const;
        const int & getCounter() const; 
        const double * getBuffData() const;

        virtual void read(double * v, Matrix pos, double dt);

};



