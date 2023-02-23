classdef EKF < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Hidden = true)
        % state and uncert. matrices
        X_att = zeros(4,1);
        P_att = zeros(4);
        % sensor config
        Ra;
        Rm;
        soft_iron;
        % sensor data
        acc_data = zeros(3,1);
        mag_data = zeros(3,2);

        % data mangement
        EKF_SIGMA_99 = 3;
        EKF_MAX_GYRO = 1;
        EKF_DT = 0.01;
        mag_buff_iter = 1;
    end

    methods

        function obj = EKF(ra, rm, si)
            %EKF Construct an instance of this class
            %   Detailed explanation goes here
            obj.Ra = ra;
            obj.Rm = rm;
            obj.soft_iron = si;
        end

        function x_att = get_att(obj)
            x_att = obj.X_att;
        end

        function init_att(obj, acc, mag)
            obj.elab_data(acc, mag);

            [a_n, Ra_n] = norm_acc(obj);
            [m_n, Rm_n] = norm_mag(obj, obj.mag_buff_iter);

            mD = sum(a_n.*m_n);
            Zm_num1 = (a_n(2)*m_n(3) - a_n(3)*m_n(2));
            Zm_num2 = m_n(1) - mD*a_n(1);
            tmp = Zm_num1^2 + Zm_num2^2;

            phi = atan2(a_n(2), a_n(3));
            theta = asin(a_n(1));
            psi = atan2(Zm_num1, Zm_num2);

            J_acc = [0, a_n(3) / (a_n(2)^2+a_n(3)^2), -a_n(2) / (a_n(2)^2+a_n(3)^2);
                     -1 / sqrt(1 - a_n(1)^2), 0, 0;
                     Zm_num1*(a_n(1)*m_n(1) + mD) / tmp, ... 
                     (Zm_num1*a_n(1)*m_n(2) + Zm_num2*m_n(3)) / tmp, ...
                     (Zm_num1*a_n(1)*m_n(3) - Zm_num2*m_n(2)) / tmp];

            J_mag = [0, 0, 0; 
                     0, 0, 0; 
                     -(1.0 - a_n(1)^2) * Zm_num2 / tmp,...
                     (Zm_num1*a_n(1)*a_n(2) - Zm_num2*a_n(3)) / tmp,...
                     (Zm_num1*a_n(1)*a_n(3) + Zm_num2*a_n(2)) / tmp];
            Reul = J_acc*Ra_n*J_acc' + J_mag*Rm_n*J_mag';

            obj.X_att = obj.eul_to_quat(phi, theta, psi);
            Jeul = [ -sin(phi/2)*cos(theta/2)*cos(psi/2)/2 + cos(phi/2)*sin(theta/2)*sin(psi/2)/2, ...
                     -cos(phi/2)*sin(theta/2)*cos(psi/2)/2 + sin(phi/2)*cos(theta/2)*sin(psi/2)/2, ... 
                     -cos(phi/2)*cos(theta/2)*sin(psi/2)/2 + sin(phi/2)*sin(theta/2)*cos(psi/2)/2; 
                     cos(phi/2)*cos(theta/2)*cos(psi/2)/2 + sin(phi/2)*sin(theta/2)*sin(psi/2)/2, ...
                     -sin(phi/2)*sin(theta/2)*cos(psi/2)/2 - cos(phi/2)*cos(theta/2)*sin(psi/2)/2, ...
                     -sin(phi/2)*cos(theta/2)*sin(psi/2)/2 - cos(phi/2)*sin(theta/2)*cos(psi/2)/2; 
                     -sin(phi/2)*sin(theta/2)*cos(psi/2)/2 + cos(phi/2)*cos(theta/2)*sin(psi/2)/2, ...
                     cos(phi/2)*cos(theta/2)*cos(psi/2)/2 - sin(phi/2)*sin(theta/2)*sin(psi/2)/2, ...
                     -cos(phi/2)*sin(theta/2)*sin(psi/2)/2 + sin(phi/2)*cos(theta/2)*cos(psi/2)/2; 
                     -sin(phi/2)*cos(theta/2)*sin(psi/2)/2 - cos(phi/2)*sin(theta/2)*cos(psi/2)/2, ...
                     -cos(phi/2)*sin(theta/2)*sin(psi/2)/2 - sin(phi/2)*cos(theta/2)*cos(psi/2)/2, ...
                     cos(phi/2)*cos(theta/2)*cos(psi/2)/2 + sin(phi/2)*sin(theta/2)*sin(psi/2)/2];
            obj.P_att = Jeul*Reul*Jeul';

        end

        function step(obj, acc, mag)
            obj.elab_data(acc, mag);

            if obj.mag_buff_iter == 2
                obj.predict_att();
            else
                obj.update_att();
            end

        end
        
    end

    methods(Hidden = true)

        function [J_N] = J_normalization(vector)
            %   J_normalization 
            %   Compute the jacobian of the normalization operation on the given vector
            mod = norm(vector);
            len = length(vector);
            J_N = zeros(len,len);
            
            for i = 1:len
                for j = 1:len
                    if(i == j)
                        J_N(i,j) = (mod^2 - vector(i)^2);
                    else
                        J_N(i,j) = -vector(i)*vector(j);
                    end
                end
            end
            
            J_N = J_N/mod^3;
        end
        
        function [a_n, Ra_n] = norm_acc(obj)
            a_n = obj.acc_data ./ norm(obj.acc_data);
            J = J_normalization(obj.acc_data);
            Ra_n = J*obj.Ra*J';
        end

        function [m_n, Rm_n] = norm_mag(obj, iter)
            m_n = obj.mag_data(:,iter) ./ norm(obj.mag_data(:,iter));
            Rm_n = obj.soft_iron*obj.Rm*obj.soft_iron';
            J = J_normalization(obj.mag_data(:,iter));
            Rm_n = J*Rm_n*J';
        end

        function elab_data(obj, acc, mag)
            acc = reshape(acc, 3, 1);
            mag = reshape(mag, 3, 1);
            obj.acc_data = acc;
            acc_n = norm(obj.acc_data);
            acc_norm_sigma = sqrt(sum(diag(obj.Ra) .* ((acc/acc_n).^2))) * obj.EKF_SIGMA_99;
            acc_norm_dev = abs(acc_n-1000);
            
            if(acc_norm_dev > acc_norm_sigma)
                if(obj.mag_buff_iter == 2)
                    % shift registers
                    obj.mag_data(:,1) = obj.mag_data(:,2);
                end
                obj.mag_buff_iter = 2;
            else
                obj.mag_buff_iter = 1;
            end

            obj.mag_data(:, obj.mag_buff_iter) = mag;

        end
        
        function q = eul_to_quat(obj, phi, theta, psi)
            q = zeros(4,1);
            q(1) =  cos(phi/2) * cos(theta/2) * cos(psi/2) + sin(phi/2) * sin(theta/2) * sin(psi/2);
            q(2) =  sin(phi/2) * cos(theta/2) * cos(psi/2) - cos(phi/2) * sin(theta/2) * sin(psi/2);
            q(3) =  cos(phi/2) * sin(theta/2) * cos(psi/2) + sin(phi/2) * cos(theta/2) * sin(psi/2);
            q(4) =  cos(phi/2) * cos(theta/2) * sin(psi/2) - sin(phi/2) * sin(theta/2) * cos(psi/2);
        end
        
        function qp = Hamilton_prod(obj, q1,q2)
            qp = zeros(4,1);
            qp(1) = q1(1) * q2(1) - q1(2) * q2(2) - q1(3) * q2(3) - q1(4) * q2(4);
            qp(2) = q1(1) * q2(2) + q1(2) * q2(1) + q1(3) * q2(4) - q1(4) * q2(3);
            qp(3) = q1(1) * q2(3) - q1(2) * q2(4) + q1(3) * q2(1) + q1(4) * q2(2);
            qp(4) = q1(1) * q2(4) + q1(2) * q2(3) - q1(3) * q2(2) + q1(4) * q2(1);
        end

        function [wRb] = rotMatrixQuaternions(obj)
            %rotMatrixQuaternions(q) given the quaternion q, return the associated
            %rotation matrix from body to world
            q = obj.X_att(1:4);
            wRb = [q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2, 2*q(3)*q(2) - 2*q(4)*q(1), 2*q(3)*q(1) + 2*q(4)*q(2);
                   2*q(4)*q(1) + 2*q(3)*q(2), q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2, -2*q(2)*q(1) + 2*q(4)*q(3);
                   -2*q(3)*q(1) + 2*q(4)*q(2), 2*q(2)*q(1) + 2*q(4)*q(3), q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2];
        end

        function [z, Rz] = TRIAD(obj)
            [a_n, Ra_n] = norm_acc(obj);
            [m_n, Rm_n] = norm_mag(obj, obj.mag_buff_iter);

            mD = sum(a_n.*m_n);
            Zm_num = (a_n(2)*m_n(3) - a_n(3)*m_n(2));
            mN = sqrt(1 - mD.^2);
            z = [a_n; Zm_num/mN];

            % uncert propagation matrices
            J_ZA = [eye(3,3);
                    Zm_num*mD*m_n(1)/mN^3, ...
                    m_n(3)/mN + Zm_num*mD*m_n(2)/mN^3, ...
                    -m_n(2)/mN + Zm_num*mD*m_n(3)/mN^3];
            J_ZM = [zeros(3,3);
                    Zm_num*mD*a_n(1)/mN^3, ...
                    -a_n(3)/mN + Zm_num*mD*a_n(2)/mN^3, ...
                    a_n(2)/mN + Zm_num*mD*a_n(3)/mN^3];

            Rz = J_ZA*Ra_n*J_ZA' + J_ZM*Rm_n*J_ZM';
            
        end
        
        function predict_att(obj)
            [v1, Rm_n1] = norm_mag(obj, 1);
            [v2, Rm_n2] = norm_mag(obj, 2);

            Jmag1 = [v2(1), v2(2), v2(3);
                     0, v2(3), - v2(2);
                     - v2(3), 0, v2(1);
                     v2(2), - v2(1), 0 ];

            Jmag2 = [v1(1), v1(2), v1(3);
                     0, v1(3), v1(2); 
                     v1(3), 0, - v1(1);
                     - v1(2), v1(1), 0 ];
            
            q_rot = [1 + dot(v1,v2); cross(v1,v2)];
            Rq_rot = Jmag1*Rm_n1*Jmag1' + Jmag2*Rm_n2*Jmag2';
            
            Jn = J_normalization(q_rot);
            q_rot = q_rot / norm(q_rot);
            Rq_rot = Jn*Rq_rot*Jn';
            
            att = obj.X_att;
            Jqr = [att(1), - att(2), - att(3), - att(4);
                   att(2), att(1), - att(4), att(3);
                   att(3), att(4), att(1), - att(2);
                   att(4), - att(3), att(2), att(1)];
            Jatt = [q_rot(1), - q_rot(2), - q_rot(3), - q_rot(4);
                    q_rot(2), q_rot(1), q_rot(4), - q_rot(3);
                    q_rot(3), - q_rot(4), q_rot(1), q_rot(2);
                    q_rot(4), q_rot(3), - q_rot(2), q_rot(1)];
            
            obj.X_att = obj.Hamilton_prod(att, q_rot);
            obj.X_att = obj.X_att / norm(obj.X_att);
            obj.P_att = Jatt*obj.P_att*Jatt' + Jqr*Rq_rot*Jqr';

        end

        function update_att(obj)
            
            % increment previous P_att
            scale = (1 + 3*obj.EKF_MAX_GYRO*obj.EKF_DT/2)^2;
            for i = 1:length(obj.P_att)
                obj.P_att(i,i) = obj.P_att(i,i)*scale;
            end

            [Z, Rz] = obj.TRIAD();
            
            % Predicted measurements
            Zpred = [-2*obj.X_att(3)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(2);
                    2*obj.X_att(2)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(3);
                    obj.X_att(1)^2 - obj.X_att(2)^2 - obj.X_att(3)^2 + obj.X_att(4)^2;
                    2*obj.X_att(4)*obj.X_att(1) + 2*obj.X_att(3)*obj.X_att(2)];
    
            % linearized measurement mapping
            J_H = 2*...
              [-obj.X_att(3), obj.X_att(4), -obj.X_att(1), obj.X_att(2);
                obj.X_att(2), obj.X_att(1), obj.X_att(4), obj.X_att(3);
                obj.X_att(1), -obj.X_att(2), -obj.X_att(3), obj.X_att(4);
                obj.X_att(4), obj.X_att(3), obj.X_att(2), obj.X_att(1)];
        
            Innovation_att = Z - Zpred;

            % Kalmann steps
            S_att = J_H*obj.P_att*J_H' + Rz;
            W_att = obj.P_att*J_H'/S_att;
            obj.X_att = obj.X_att + W_att*Innovation_att;
            obj.P_att = (eye(4) - W_att*J_H) * obj.P_att;
            
            obj.X_att = obj.X_att/norm(obj.X_att);
        end

    end
end