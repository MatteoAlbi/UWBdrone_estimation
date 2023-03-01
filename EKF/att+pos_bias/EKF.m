classdef EKF < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties %(Hidden = true)
        % state and uncert. matrices
        X_att = zeros(7,1);
        P_att = zeros(7);

        % sensor config
        Ra;
        Rm;
        Rg;
        Rgb;
        soft_iron;

        % sensor data
        acc = zeros(3,1);
        mag = zeros(3,2);
        gyro = zeros(3,1);
        dt = 0;

        % data management
        EKF_SIGMA_99 = 3;
        mag_buff_iter = 1;
        G_ACC_VAL = 1000;
        alpha = 1;
%         X_pos = zeros(7,1);
%         P_pos = eye(7);
%         % state function matrices
%         A = zeros(4,4);
%         B = zeros(4,2);
        % measurement matrix
%         H

    end

    methods

        function obj = EKF(ra, rm, rg, rgb, si)
            %EKF Construct an instance of this class
            %   Detailed explanation goes here
            obj.Ra = ra;
            obj.Rm = rm;
            obj.Rg = rg;
            obj.Rgb = rgb;
            obj.soft_iron = si;
        end

        function x_att = get_att(obj)
            x_att = obj.X_att;
        end
        
        function init_att(obj, acc, mag, bg)
%             obj.elab_data(acc, mag);
            obj.acc = reshape(acc, 3, 1);
            obj.mag = reshape(mag, 3, 1);

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

            obj.X_att(1:4) = obj.eul_to_quat(phi, theta, psi);
            obj.X_att(5:7) = bg;
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
            obj.P_att(1:4,1:4) = Jeul*Reul*Jeul';
            obj.P_att(5:7,5:7) = obj.Rgb/1000;

        end
        
        function step(obj, g, dt, a, m)
            obj.elab_data(a, m, g, dt);
            obj.predict_att();
            obj.update_att();

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

        function [wRb] = rotMatrixQuaternions(obj)
            %rotMatrixQuaternions(q) given the quaternion q, return the associated
            %rotation matrix from body to world
            q = obj.X_att(1:4);
            wRb = [q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2, 2*q(3)*q(2) - 2*q(4)*q(1), 2*q(3)*q(1) + 2*q(4)*q(2);
                   2*q(4)*q(1) + 2*q(3)*q(2), q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2, -2*q(2)*q(1) + 2*q(4)*q(3);
                   -2*q(3)*q(1) + 2*q(4)*q(2), 2*q(2)*q(1) + 2*q(4)*q(3), q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2];
        end

        function [aG, RaG] = func_aG(obj, a, Ra, Rba)
            % split_acc: given acc readings, acc bias and correspective uncertainties,
            %            split the two contributions of gravity and body acc anc
            %            compute corrispective uncertainties
            
            g = 9.807;
%             a_nobias = a - obj.X_pos(5:7);
            a_nobias = a;
            mod = sqrt(max(g^2-a_nobias(1)^2-a_nobias(2)^2,0));
            
            % estimate acc z comp from previous step
            wRb = rotMatrixQuaternions(obj.X_att(1:4));
            aG_prev = wRb'*[0;0;g];
            
            %aZ_sign = sign(aG_prev(3));
            %aZg = mod*aZ_sign;
            
            % compute gravity z comp as closest to previous step
            tmp1 = mod;
            tmp2 = -mod;
            if aG_prev(3) - tmp1 < aG_prev(3) - tmp2
                aZg = tmp1;
            else
                aZg = tmp2;
            end
            
            
            % gravity vector
            aG = [a_nobias(1); a_nobias(2); aZg] / g; %normalized
            
            % jacobians to propagate uncertainties
            JaG_a = [1,0,0;
                     0,1,0;
                     -a_nobias(1)/mod, -a_nobias(2)/mod, 0] / g;
            JaG_ba = [-1,0,0;
                      0,-1,0;
                      a_nobias(1)/mod, a_nobias(2)/mod, 0] / g;
            
            % propagate uncertainties
            RaG = JaG_a*Ra*JaG_a' + JaG_ba*Rba*JaG_ba';
            
        end
        
        function q = eul_to_quat(obj, phi, theta, psi)
            q = zeros(4,1);
            q(1) =  cos(phi/2) * cos(theta/2) * cos(psi/2) + sin(phi/2) * sin(theta/2) * sin(psi/2);
            q(2) =  sin(phi/2) * cos(theta/2) * cos(psi/2) - cos(phi/2) * sin(theta/2) * sin(psi/2);
            q(3) =  cos(phi/2) * sin(theta/2) * cos(psi/2) + sin(phi/2) * cos(theta/2) * sin(psi/2);
            q(4) =  cos(phi/2) * cos(theta/2) * sin(psi/2) - sin(phi/2) * sin(theta/2) * cos(psi/2);
        end
        
        function [qp, Rqp] = Hamilton_prod(obj, q1, q2, Rq1, Rq2)
            Jq2 = [q1(1), - q1(2), - q1(3), - q1(4);
                   q1(2), q1(1), - q1(4), q1(3);
                   q1(3), q1(4), q1(1), - q1(2);
                   q1(4), - q1(3), q1(2), q1(1)];
            Jq1 = [q2(1), - q2(2), - q2(3), - q2(4);
                    q2(2), q2(1), q2(4), - q2(3);
                    q2(3), - q2(4), q2(1), q2(2);
                    q2(4), q2(3), - q2(2), q2(1)];
            Rqp = Jq1*Rq1*Jq1' + Jq2*Rq2*Jq2';

            qp = zeros(4,1);
            qp(1) = q1(1) * q2(1) - q1(2) * q2(2) - q1(3) * q2(3) - q1(4) * q2(4);
            qp(2) = q1(1) * q2(2) + q1(2) * q2(1) + q1(3) * q2(4) - q1(4) * q2(3);
            qp(3) = q1(1) * q2(3) - q1(2) * q2(4) + q1(3) * q2(1) + q1(4) * q2(2);
            qp(4) = q1(1) * q2(4) + q1(2) * q2(3) - q1(3) * q2(2) + q1(4) * q2(1);
        end

        function [a_n, Ra_n] = norm_acc(obj)
            a_n = obj.acc ./ norm(obj.acc);
%             J = J_normalization(obj.acc);
%             Ra_n = J*obj.Ra*J';
            Ra_n = obj.Ra/obj.G_ACC_VAL^2;
        end

        function [m_n, Rm_n] = norm_mag(obj, iter)
            m_n = obj.mag(:,iter) ./ norm(obj.mag(:,iter));
%             Rm_n = obj.soft_iron*obj.Rm*obj.soft_iron';
%             J = J_normalization(obj.mag(:,iter));
%             Rm_n = J*Rm_n*J';
            Rm_n = obj.Rm/norm(obj.mag(:,iter))^2;
        end

        function elab_data(obj, acc, mag, gyro, dt)
            acc = reshape(acc, 3, 1);
            mag = reshape(mag, 3, 1);
            gyro = reshape(gyro, 3, 1);

            obj.acc = acc;
            obj.gyro = gyro;
            obj.dt = dt;

%             acc_n = norm(obj.acc);
%             acc_norm_sigma = sqrt(sum(diag(obj.Ra) .* ((acc/acc_n).^2))) * obj.EKF_SIGMA_99;
%             acc_norm_dev = abs(acc_n-1000);
%             
%             if(acc_norm_dev > acc_norm_sigma)
%                 if(obj.mag_buff_iter == 2)
%                     % shift registers
%                     obj.mag(:,1) = obj.mag(:,2);
%                 end
%                 obj.mag_buff_iter = 2;
%             else
%                 obj.mag_buff_iter = 1;
%             end

            obj.mag(:, obj.mag_buff_iter) = mag;

        end
        
        function [z, Rz] = TRIAD(obj)
            [a_n, Ra_n] = norm_acc(obj);
            [m_n, Rm_n] = norm_mag(obj, obj.mag_buff_iter);

            mD = sum(a_n.*m_n);
            Zm_num1 = (a_n(2)*m_n(3) - a_n(3)*m_n(2));
            Zm_num2 = m_n(1) - mD*a_n(1);
            mN = sqrt(1 - mD.^2);
            z = [a_n; Zm_num1/mN; Zm_num2/mN];%atan2(Zm_num1, Zm_num2)];
%             obj.triad = z;
            
%             tmp = Zm_num1^2 + Zm_num2^2;
%             tmp2 = Zm_num2 + Zm_num1^2/Zm_num2;
            % uncert propagation matrices
            J_ZA = [eye(3,3);
                    Zm_num1*mD*m_n(1)/mN^3, ...
                    Zm_num1*mD*m_n(2)/mN^3 + m_n(3)/mN, ...
                    Zm_num1*mD*m_n(3)/mN^3 - m_n(2)/mN;
                    Zm_num2*mD*m_n(1)/mN^3 - (mD+a_n(1)*m_n(1))/mN, ...
                    Zm_num2*mD*m_n(2)/mN^3 -     a_n(1)*m_n(2) /mN, ...
                    Zm_num2*mD*m_n(3)/mN^3 -     a_n(1)*m_n(3) /mN];
%                     (mD+a_n(1)*m_n(1))*Zm_num1/tmp, ...
%                         a_n(1)*m_n(2) *Zm_num1/tmp + m_n(3)/tmp2, ...
%                         a_n(1)*m_n(3) *Zm_num1/tmp - m_n(2)/tmp2];

            J_ZM = [zeros(3,3);
                    Zm_num1*mD*a_n(1)/mN^3, ...
                    Zm_num1*mD*a_n(2)/mN^3 - a_n(3)/mN, ...
                    Zm_num1*mD*a_n(3)/mN^3 + a_n(2)/mN;
                    Zm_num2*mD*a_n(1)/mN^3 - (a_n(1)^2 - 1) /mN, ...
                    Zm_num2*mD*a_n(1)/mN^3 -  a_n(1)*a_n(2) /mN, ...
                    Zm_num2*mD*a_n(1)/mN^3 -  a_n(1)*a_n(3) /mN];
%                     (a_n(1)^2 - 1)*Zm_num1/tmp, ...
%                      a_n(1)*a_n(2)*Zm_num1/tmp - a_n(3)/tmp2, ...
%                      a_n(1)*a_n(3)*Zm_num1/tmp + a_n(2)/tmp2];

            Rz = J_ZA*Ra_n*J_ZA' + J_ZM*Rm_n*J_ZM';
        end
        
        function predict_att(obj)
            % quaternion rotation matrix
            omega_no_bias = obj.gyro(:) - obj.X_att(5:7);
            S_omega = [0, -omega_no_bias(1), -omega_no_bias(2), -omega_no_bias(3);
                0, 0, omega_no_bias(3), -omega_no_bias(2);
                0, 0, 0, omega_no_bias(1);
                zeros(1,4)];
            S_omega = S_omega - S_omega';
            
            % quaternion prediction
            obj.X_att(1:4) = (S_omega*obj.dt/2 + eye(4))*obj.X_att(1:4);
            obj.X_att(5:7) = obj.X_att(5:7);

            % Covariance of the prediction
            Gatt = [-obj.X_att(2), -obj.X_att(3), -obj.X_att(4);
                    obj.X_att(1), -obj.X_att(4), obj.X_att(3);
                    obj.X_att(4), obj.X_att(1), -obj.X_att(2);
                    -obj.X_att(3), obj.X_att(2), obj.X_att(1)]*obj.dt/2;
        
            J_Gatt = [ Gatt;
                    zeros(3,3)];
            J_Batt = [ 
                    zeros(4,3);
                    %-Gatt;
                    eye(3,3)];
            J_Xatt = [ S_omega*obj.dt/2 + eye(4), -Gatt;
                    zeros(3,4),eye(3,3)];
        
            obj.P_att = J_Xatt*obj.P_att*J_Xatt' + ...
                        J_Gatt*obj.Rg*J_Gatt' + ...
                        J_Batt*obj.Rgb*J_Batt';

            obj.X_att(1:4) = obj.X_att(1:4)/norm(obj.X_att(1:4));
%             J_n = J_normalization(obj.X_att(1:4));
%             obj.P_att(1:4,1:4) = J_n*obj.P_att(1:4,1:4)*J_n';

        end

        function update_att(obj)
            % Split acc contributions
%             [aG, RaG] = obj.func_aG(a_bar, Ra, Rba);

            [z,Rz] = obj.TRIAD();

            % Predicted measurements
            Zpred = [-2*obj.X_att(3)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(2);
                    2*obj.X_att(2)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(3);
                    obj.X_att(1)^2 - obj.X_att(2)^2 - obj.X_att(3)^2 + obj.X_att(4)^2;
                    2*obj.X_att(4)*obj.X_att(1) + 2*obj.X_att(3)*obj.X_att(2);
                    obj.X_att(1)^2 + obj.X_att(2)^2 - obj.X_att(3)^2 - obj.X_att(4)^2];
    
            % linearized measurement mapping
            J_H = zeros(5,7);
            J_H(1:5,1:4) = 2*...
              [-obj.X_att(3), obj.X_att(4), -obj.X_att(1), obj.X_att(2);
                obj.X_att(2), obj.X_att(1), obj.X_att(4), obj.X_att(3);
                obj.X_att(1), -obj.X_att(2), -obj.X_att(3), obj.X_att(4);
                obj.X_att(4), obj.X_att(3), obj.X_att(2), obj.X_att(1);
                obj.X_att(1), obj.X_att(2), -obj.X_att(3), -obj.X_att(4)];
        
            Innovation_att = z - Zpred;

            prev_bg = obj.X_att(5:7);

            % Kalmann steps
            S_att = J_H*obj.P_att*J_H' + Rz;
            W_att = obj.P_att*J_H'/S_att;
            obj.X_att = obj.X_att + W_att*Innovation_att;
            obj.P_att = (eye(7) - W_att*J_H) * obj.P_att;
            
            obj.X_att(1:4) = obj.X_att(1:4)/norm(obj.X_att(1:4));
            obj.X_att(5:7) = obj.alpha*obj.X_att(5:7) + (1-obj.alpha)*prev_bg;
        end

    end
end