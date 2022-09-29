#include "EKF.hpp"

class EKFpos : public EKF{
    
    protected:
        double buffer[2][2];
        uint buff_iter;
        int counter;
        bool vel_ready;

    public:
        EKFpos();
        EKFpos(Matrix x, Matrix p); 

        // virtual Matrix f(const Matrix & U, double dt) const;
        // virtual Matrix JfX(const Matrix & U, double dt) const;
        // virtual Matrix JfU(const Matrix & U, double dt) const;
        // virtual Matrix h() const;
        // virtual Matrix JhX() const;

        /**
         * @brief prediction step for the position. 
         * U must be the acceleration of the drone in the global frame:
         * compute it in moving frame from acc data and then project. Then propagate 
         * uncertainties. U = a | q_att
         * 
         * @param U combination off acc and attitude quaternion -> Matrix(7,1)
         * @param Ru uncertainty of U
         * @param dt time step
         */
        virtual void predict(const Matrix & U, const Matrix & Ru, double dt);
        virtual void update(const Matrix & Z, const Matrix & Rz);
};