classdef EKF3 < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties %(Hidden = true)
        % state and uncert. matrices
        X_att = zeros(7,1);
        P_att = eye(7);
        X_pos = zeros(7,1);
        P_pos = eye(7);

        % sensor config
        Ra;
        Rm;
        Rg;
        Rgb;
        Ru;
        hard_iron;
        soft_iron;
        acc_bias;
        acc_scale;

        % sensor data
        acc = zeros(3,1);
        mag = zeros(3,1);
        gyro = zeros(3,1);
        uwb = zeros(3,2);
        imu_t = 0;
        uwb_t = 0;

        % ext acc
        ext_acc = zeros(3,1);
        Ra_ext = eye(3);
        acc_err = 0;
        acc_det = 0;
        threshold_acc = 0.05 * 9.807;
        ca_const = 0.97; % process cut-off freq
        ca = 0.97/2;

        % data management
        uwb_buff_iter = 1; %points to last insterted value
        G_ACC_VAL = 9.807;
        alpha = 0.5;
        imu_step = true;

    end

    methods

        function obj = EKF3(ra, rm, rg, rgb, ru, hi, si, ab, as)
            %EKF Construct an instance of this class
            %   Detailed explanation goes here
            obj.Ra = ra;
            obj.Rm = rm;
            obj.Rg = rg;
            obj.Rgb = rgb;
            obj.Ru = ru;
            obj.hard_iron = hi;
            obj.soft_iron = si;
            obj.acc_bias = ab;
            obj.acc_scale = as;

            if ~all(obj.ext_acc)
                obj.ext_acc = normrnd(0,0.1,3,1);
            end
        end

        function q = get_att(obj)
            q = obj.X_att(1:4);
        end

        function g_b = get_g_b(obj)
            g_b = obj.X_att(5:7);
        end

        function p = get_pos(obj)
            p = obj.X_pos(1:2);
        end

        function v = get_vel(obj)
            v = obj.X_pos(3:4);
        end
        
        function a_d = get_acc_det(obj)
            a_d = obj.acc_det;
        end

        function a_ext = get_ext_acc(obj)
            a_ext = obj.ext_acc;
        end

        function init_att(obj, a, m, bg, t)
            obj.acc = (reshape(a, 3, 1) - obj.acc_bias) .* obj.acc_scale;
            obj.mag = obj.soft_iron' * (reshape(m, 3, 1) - obj.hard_iron);
            %obj.gyro = reshape(g, 3, 1);
            obj.imu_t = t;

            [a_n, Ra_n] = norm_acc(obj);
%             [aG, RaG] = obj.func_aG(true);
            [m_n, Rm_n] = obj.norm_mag();

            mD = a_n'*m_n;
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
            obj.P_att(5:7,5:7) = obj.Rgb;%/1000;



        end
        
        function init_pos(obj, u, t)
            obj.uwb_t = t;
            obj.uwb(:,1) = reshape(u, 3, 1);
            obj.uwb_buff_iter = 1; %points to last insterted value

            obj.X_pos = [(reshape(u(1:2), 2, 1)); 0; 0; 0; 0; 0];
            tmp = diag(obj.Ru);
            obj.P_pos = diag([tmp(1:2); tmp(1:2)*2; diag(obj.Ra)]);
        end

        function step_imu(obj, a, m, g, t)
            if(obj.imu_step)
                obj.acc = (reshape(a, 3, 1) - obj.acc_bias) .* obj.acc_scale;
                obj.mag = obj.soft_iron' * (reshape(m, 3, 1) - obj.hard_iron);
                obj.gyro = reshape(g, 3, 1);
    
                obj.predict_att(t);
                obj.update_att();
                obj.predict_pos(t);
    
                obj.imu_t = t;
                obj.imu_step = false;
            end

        end

        function step_uwb(obj, u, t)
            % check data correctness
            if u(1) ~= 0 && abs(u(1)) < 10000 && u(1)-obj.X_pos(1) < 10 && ...
               u(2) ~= 0 && abs(u(2)) < 10000 && u(2)-obj.X_pos(2) < 10
                
                %update iterator
                if obj.uwb_buff_iter == 1
                    obj.uwb_buff_iter = 2;
                else
                    obj.uwb_buff_iter = 1;
                end

                %save new data
                obj.uwb(:,obj.uwb_buff_iter) = reshape(u, 3, 1);

                obj.update_pos(t);
                obj.uwb_t = t;
                obj.imu_step = true;
            end    

        end

    end

    methods(Hidden = true)
    
        function [J_N] = J_normalization(obj, vector)
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

        function [aG, RaG] = func_aG(obj, init)
            % split_acc: given acc readings, acc bias and correspective uncertainties,
            %            split the two contributions of gravity and body acc anc
            %            compute corrispective uncertainties
            
            g = obj.G_ACC_VAL;
            mod = sqrt(max(g^2 - obj.acc(1)^2 - obj.acc(2)^2, 0));
            
            if init
                aZg = mod;
            else
                % estimate acc z comp from previous step
                wRb = obj.rotMatrixQuaternions();
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
            end
            
            
            % gravity vector
            aG = [obj.acc(1); obj.acc(2); aZg] / g; %normalized
            
            % jacobians to propagate uncertainties
            JaG_a = [1,0,0;
                     0,1,0;
                     -obj.acc(1)/mod, -obj.acc(2)/mod, 0] / g;
            
            % propagate uncertainties
            RaG = JaG_a*obj.Ra*JaG_a';
            
        end
        
        function [aW, RaW] = func_aW(obj)
            % split_acc: given acc readings, acc bias and correspective uncertainties,
            %            split the two contributions of gravity and body acc anc
            %            compute corrispective uncertainties
            
            wRb = obj.rotMatrixQuaternions();
            aW = wRb * obj.acc;
            aW(3) = aW(3) - obj.G_ACC_VAL; 
            
            RaW = wRb*obj.Ra*wRb';
            
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

        function [m_n, Rm_n] = norm_mag(obj)
            m_n = obj.mag ./ norm(obj.mag);
            Rm_n = obj.soft_iron*obj.Rm*obj.soft_iron';
            J = obj.J_normalization(obj.mag);
            Rm_n = J*Rm_n*J';
%             Rm_n = obj.Rm/norm(obj.mag)^2;
        end
        
        function [z, Rz] = TRIAD(obj)
            % Split acc contributions
%             [aG, RaG] = obj.func_aG(false);

%             [a_n, Ra_n] = obj.norm_acc();
            %-- ext acc compensation
            % detection
            obj.acc_err = abs(norm(obj.acc) - obj.G_ACC_VAL);
            if obj.acc_err > obj.threshold_acc
                obj.acc_det = 1;
                obj.ca = obj.ca_const;
            else
                obj.acc_det = 0;
                obj.ca = obj.ca_const/2;
            end
            % compensation
            a_corr = obj.acc - obj.ca * obj.X_pos(5:7);
            % covariance matrix
            W = diag(obj.ext_acc) / sum(abs(obj.ext_acc));
            E_ext_acc = obj.ca^2 * obj.P_pos(5:7,5:7) + ...
                        abs(norm(obj.acc)^2 - obj.G_ACC_VAL) * W;
            Ra_corr = obj.Ra + E_ext_acc;
            % normalization
            a_n = a_corr/norm(a_corr);
%             J_N = obj.J_normalization(a_corr);
%             Ra_n = J_N*Ra_corr*J_N';
            Ra_n = Ra_corr/norm(a_corr)^2;

            [m_n, Rm_n] = obj.norm_mag();

            mD = a_n'*m_n;
            if mD > 1
                disp("warning");
            end
            Zm_num1 = (a_n(2)*m_n(3) - a_n(3)*m_n(2));
%             Zm_num2 = m_n(1) - mD*a_n(1);
            mN = sqrt(1 - mD.^2);
            z = [a_n; Zm_num1/mN];% Zm_num2/mN];%atan2(Zm_num1, Zm_num2)];
%             obj.triad = z;
            
%             tmp = Zm_num1^2 + Zm_num2^2;
%             tmp2 = Zm_num2 + Zm_num1^2/Zm_num2;
            % uncert propagation matrices
            J_ZA = [eye(3,3);
                    Zm_num1*mD*m_n(1)/mN^3, ...
                    Zm_num1*mD*m_n(2)/mN^3 + m_n(3)/mN, ...
                    Zm_num1*mD*m_n(3)/mN^3 - m_n(2)/mN];
%                     Zm_num2*mD*m_n(1)/mN^3 - (mD+a_n(1)*m_n(1))/mN, ...
%                     Zm_num2*mD*m_n(2)/mN^3 -     a_n(1)*m_n(2) /mN, ...
%                     Zm_num2*mD*m_n(3)/mN^3 -     a_n(1)*m_n(3) /mN];
%                     (mD+a_n(1)*m_n(1))*Zm_num1/tmp, ...
%                         a_n(1)*m_n(2) *Zm_num1/tmp + m_n(3)/tmp2, ...
%                         a_n(1)*m_n(3) *Zm_num1/tmp - m_n(2)/tmp2];

            J_ZM = [zeros(3,3);
                    Zm_num1*mD*a_n(1)/mN^3, ...
                    Zm_num1*mD*a_n(2)/mN^3 - a_n(3)/mN, ...
                    Zm_num1*mD*a_n(3)/mN^3 + a_n(2)/mN];
%                     Zm_num2*mD*a_n(1)/mN^3 - (a_n(1)^2 - 1) /mN, ...
%                     Zm_num2*mD*a_n(1)/mN^3 -  a_n(1)*a_n(2) /mN, ...
%                     Zm_num2*mD*a_n(1)/mN^3 -  a_n(1)*a_n(3) /mN];
%                     (a_n(1)^2 - 1)*Zm_num1/tmp, ...
%                      a_n(1)*a_n(2)*Zm_num1/tmp - a_n(3)/tmp2, ...
%                      a_n(1)*a_n(3)*Zm_num1/tmp + a_n(2)/tmp2];

            Rz = J_ZA*Ra_n*J_ZA' + J_ZM*Rm_n*J_ZM';
        end
        
        function predict_att(obj, t)
            dt = t - obj.imu_t;

            % quaternion rotation matrix
            omega_no_bias = obj.gyro - obj.X_att(5:7);
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
                        J_Gatt*obj.Rg*J_Gatt' + ...
                        J_Batt*obj.Rgb*J_Batt';

            obj.X_att(1:4) = obj.X_att(1:4)/norm(obj.X_att(1:4));
%             J_n = J_normalization(obj.X_att(1:4));
%             obj.P_att(1:4,1:4) = J_n*obj.P_att(1:4,1:4)*J_n';

        end

        function update_att(obj)
            
            [z,Rz] = obj.TRIAD();

            % Predicted measurements
            Zpred = [-2*obj.X_att(3)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(2);
                    2*obj.X_att(2)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(3);
                    obj.X_att(1)^2 - obj.X_att(2)^2 - obj.X_att(3)^2 + obj.X_att(4)^2;
                    2*obj.X_att(4)*obj.X_att(1) + 2*obj.X_att(3)*obj.X_att(2)];
%                     obj.X_att(1)^2 + obj.X_att(2)^2 - obj.X_att(3)^2 - obj.X_att(4)^2];
    
            % linearized measurement mapping
%             J_H = zeros(5,7);
            J_H = zeros(4,7);
            J_H(:,1:4) = 2*...
              [-obj.X_att(3), obj.X_att(4), -obj.X_att(1), obj.X_att(2);
                obj.X_att(2), obj.X_att(1), obj.X_att(4), obj.X_att(3);
                obj.X_att(1), -obj.X_att(2), -obj.X_att(3), obj.X_att(4);
                obj.X_att(4), obj.X_att(3), obj.X_att(2), obj.X_att(1)];
%                 obj.X_att(1), obj.X_att(2), -obj.X_att(3), -obj.X_att(4)];
        
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
        
        function predict_pos(obj, t)
            dt = t - obj.imu_t;
%             [aW, RaW] = obj.func_aW();
            

            % state function matrices
            A = [1, 0, dt, 0;
                 0, 1, 0,  dt;
                 0, 0, 1,  0;
                 0, 0, 0,  1];
            B = [dt^2/2, 0, 0;
                 0,      dt^2/2, 0;
                 dt,     0, 0;
                 0,      dt, 0];
            A = [A, B; zeros(3,4), eye(3)];
            
            obj.X_pos = A*obj.X_pos;% + B*obj.ext_acc(1:2);
            obj.P_pos = A*obj.P_pos*A' + [zeros(4,7); zeros(3,4), obj.Ra];% + B*obj.Ra_ext(1:2,1:2)*B';

        end

        function update_pos(obj, t)
            dt = t - obj.uwb_t;

            if obj.uwb_buff_iter == 1
                z = obj.uwb(1:2, 1);
                Rz = obj.Ru(1:2,1:2);
                H = [eye(2), zeros(2,5)];
            else
                z = [obj.uwb(1:2, 2); (obj.uwb(1:2, 2) - obj.uwb(1:2, 1)) / dt];
                tmp = diag(obj.Ru(1:2,1:2));
                Rz = diag([tmp; tmp*2/dt^2]);
                H = [eye(4), zeros(4,3)];
            end

            % ext acc estimation
            wRb = obj.rotMatrixQuaternions();
            aG = wRb' * [0;0;obj.G_ACC_VAL];
            z = [z; obj.acc - aG];


            J_wRb = 2 * obj.G_ACC_VAL*...
              [-obj.X_att(3), obj.X_att(4), -obj.X_att(1), obj.X_att(2);
                obj.X_att(2), obj.X_att(1), obj.X_att(4), obj.X_att(3);
                obj.X_att(1), -obj.X_att(2), -obj.X_att(3), obj.X_att(4)];
            obj.Ra_ext = J_wRb*obj.P_att(1:4,1:4)*J_wRb' + obj.Ra;

            Innovation_pos = z - H * obj.X_pos;

            S_pos = H * obj.P_pos * H' + Rz;
            W_pos = obj.P_pos * H' / S_pos;
            obj.X_pos = obj.X_pos + W_pos * Innovation_pos;
            obj.P_pos = (eye(7) - W_pos * H) * obj.P_pos;

        end
    end
end