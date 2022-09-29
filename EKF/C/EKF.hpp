#include "linearAlgebra.hpp"

class EKF{

    protected:
        uint N;
        Matrix X;
        Matrix P;

    public:
        EKF(uint N);
        EKF(uint N, Matrix x, Matrix p);
        // ~EKF();
        // virtual Matrix f(const Matrix & U, double dt) const = 0;
        // virtual Matrix JfX(const Matrix & U, double dt) const = 0;
        // virtual Matrix JfU(const Matrix & U, double dt) const = 0;
        // virtual Matrix h() const = 0;
        // virtual Matrix JhX() const = 0;

        const uint& getN() const;
        const Matrix& getX() const;
        const Matrix& getP() const;

        void init(const Matrix & x, const Matrix & p);
        virtual void predict(const Matrix & U, const Matrix & Ru, double dt) = 0;
        virtual void update(const Matrix & Z, const Matrix & Rz) = 0;
};

