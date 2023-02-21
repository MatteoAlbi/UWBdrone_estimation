classdef EKF < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties (Hidden = true)
        % state and uncert. matrices
        X_att
        P_att
%         X_pos = zeros(7,1);
%         P_pos = eye(7);
%         % state function matrices
%         A = zeros(4,4);
%         B = zeros(4,2);
        % measurement matrix
        H

    end

    methods

        function obj = EKF(pose, bg, att_unc, bias_unc)
            %EKF Construct an instance of this class
            %   Detailed explanation goes here
%             obj.A = [1, 0, dt, 0;
%                      0, 1, 0,  dt;
%                      0, 0, 1,  0;
%                      0, 0, 0,  1];
%             obj.B = [dt^2/2, 0;
%                      0,      dt^2/2;
%                      dt,     0;
%                      0,      dt];
            obj.X_att = zeros(7,1);
            obj.X_att(1:4) = pose;
            obj.X_att(5:7) = bg;
            obj.P_att = diag([ones(1,4)*att_unc, ones(1,3)*bias_unc]);
%             obj.X_pos(1:2) = p;
%             obj.P_pos(3:4) = v;
            obj.H = [eye(4), zeros(4,3)];
        end

        function x_att = get_att(obj)
            x_att = obj.X_att;
        end

        function predict_att(obj, omega_bar, Rg, Rbg, dt)
            % quaternion rotation matrix
            omega_no_bias = omega_bar(:) - obj.X_att(5:7);
            S_omega = [0, -omega_no_bias(1), -omega_no_bias(2), -omega_no_bias(3);
                0, 0, omega_no_bias(3), -omega_no_bias(2);
                0, 0, 0, omega_no_bias(1);
                zeros(1,4)];
            S_omega = S_omega - S_omega';
            
            % quaternion prediction
            obj.X_att(1:4) = (S_omega*dt/2 + eye(4))*obj.X_att(1:4);
            obj.X_att(5:7) = obj.X_att(5:7);

            % Covariance of the prediction
            Gatt = [-obj.X_att(2), -obj.X_att(3), -obj.X_att(4);
                    obj.X_att(1), -obj.X_att(4), obj.X_att(3);
                    obj.X_att(4), obj.X_att(1), -obj.X_att(2);
                    -obj.X_att(3), obj.X_att(2), obj.X_att(1)]*dt/2;
        
            J_Gatt = [ Gatt;
                    zeros(3,3)];
            J_Batt = [ 
                    zeros(4,3);
                    %-Gatt;
                    eye(3,3)];
            J_Xatt = [ S_omega*dt/2 + eye(4), -Gatt;
                    zeros(3,4),eye(3,3)];
        
            obj.P_att = J_Xatt*obj.P_att*J_Xatt' + ...
                        J_Gatt*Rg*J_Gatt' + ...
                        J_Batt*Rbg*J_Batt';

            obj.X_att(1:4) = obj.X_att(1:4)/norm(obj.X_att(1:4));
%             J_n = J_normalization(obj.X_att(1:4));
%             obj.P_att(1:4,1:4) = J_n*obj.P_att(1:4,1:4)*J_n';

        end

        function update_att(obj, a_bar, m_bar, Ra, Rm, Rba)
            % Split acc contributions
            [aG, RaG] = obj.func_aG(a_bar, Ra, Rba);

            % Magnetomter + Accelerometer measurements
            % Normalization
            m_bar_mod = norm(m_bar);
            m_n = m_bar/m_bar_mod;
            J_M = J_normalization(m_bar);
            Rmn = J_M*Rm*J_M'; 

            % TRIAD algorithm
            mD = sum(aG.*m_n);
            mN = sqrt(1 - mD.^2);
            Zm_num = (aG(2)*m_n(3) - aG(3)*m_n(2));
            Zm = Zm_num/mN;
            Z_bar = [aG;Zm];

            % uncert propagation matrices
            J_ZA = [eye(3,3);
                    Zm_num*mD*m_n(1)/mN^3, ...
                    m_n(3)/mN + Zm_num*mD*m_n(2)/mN^3, ...
                    -m_n(2)/mN + Zm_num*mD*m_n(3)/mN^3];
            J_ZM = [zeros(3,3);
                    Zm_num*mD*aG(1)/mN^3, ...
                    -aG(3)/mN + Zm_num*mD*aG(2)/mN^3, ...
                    aG(2)/mN + Zm_num*mD*aG(3)/mN^3];
            
            % Z uncert
            Rz = J_ZA*RaG*J_ZA' + J_ZM*Rmn*J_ZM';

            % Predicted measurements
            Zpred = [-2*obj.X_att(3)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(2);
                    2*obj.X_att(2)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(3);
                    obj.X_att(1)^2 - obj.X_att(2)^2 - obj.X_att(3)^2 + obj.X_att(4)^2;
                    2*obj.X_att(4)*obj.X_att(1) + 2*obj.X_att(3)*obj.X_att(2)];
    
            % linearized measurement mapping
            J_H = zeros(4,7);
            J_H(1:4,1:4) = 2*...
              [-obj.X_att(3), obj.X_att(4), -obj.X_att(1), obj.X_att(2);
                obj.X_att(2), obj.X_att(1), obj.X_att(4), obj.X_att(3);
                obj.X_att(1), -obj.X_att(2), -obj.X_att(3), obj.X_att(4);
                obj.X_att(4), obj.X_att(3), obj.X_att(2), obj.X_att(1)];
        
            Innovation_att = Z_bar - Zpred;

            % Kalmann steps
            S_att = J_H*obj.P_att*J_H' + Rz;
            W_att = obj.P_att*J_H'/S_att;
            obj.X_att = obj.X_att + W_att*Innovation_att;
            obj.P_att = (eye(7) - W_att*J_H) * obj.P_att;
            
            obj.X_att(1:4) = obj.X_att(1:4)/norm(obj.X_att(1:4));
%             J_n = J_normalization(obj.X_att(1:4));
%             obj.P_att(1:4,1:4) = J_n*obj.P_att(1:4,1:4)*J_n';
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

    end
end