#include "EKF.hpp"

class EKFatt : public EKF{
    
    public:
        EKFatt();
        EKFatt(Matrix x, Matrix p); 

        // virtual Matrix f(const Matrix & U, double dt) const;
        // virtual Matrix JfX(const Matrix & U, double dt) const;
        // virtual Matrix JfU(const Matrix & U, double dt) const;
        // virtual Matrix h() const;
        // virtual Matrix JhX() const;

        virtual void predict(const Matrix & U, const Matrix & Ru, double dt);
        virtual void update(const Matrix & Z, const Matrix & Rz);
     
};

