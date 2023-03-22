classdef EKF_dyn < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties %(Hidden = true)
        % state and uncert. matrices
        X_att = zeros(7,1);
        P_att = eye(7);
        X_pos = zeros(4,1);
        P_pos = eye(4);

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

        % data management
        uwb_buff_iter = 1; %points to last insterted value
        G_ACC_VAL = 9.807;
        alpha = 0.1;

    end

    methods

        function obj = EKF_dyn(ra, rm, rg, rgb, ru, hi, si, ab, as)
            %EKF Construct an instance of this class
            %   Detailed explanation goes here
            obj.Ra = ra; % acc unc
            obj.Rm = rm; % mag unc
            obj.Rg = rg; % gyro unc
            obj.Rgb = rgb; % gyro bias unc
            obj.Ru = ru; % uwb unc
            obj.hard_iron = hi; % magnetometer hard iron
            obj.soft_iron = si; % magnetometer sof iron
            obj.acc_bias = ab; % accelerometer bias
            obj.acc_scale = as; % accelerometer scale

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


        function init_att(obj, a, m, bg, t)
            % init attitude state of the filter
            % input: acc, mag, gyro_bias, sensor reading instant

            % save sensors values
            obj.acc = (reshape(a, 3, 1) - obj.acc_bias) .* obj.acc_scale;
            obj.mag = obj.soft_iron' * (reshape(m, 3, 1) - obj.hard_iron);
            %obj.gyro = reshape(g, 3, 1);
            obj.imu_t = t;
            
            % TRIAD meas
            [a_n, Ra_n] = norm_acc(obj);
%             [aG, RaG] = obj.func_aG(true);
            [m_n, Rm_n] = obj.norm_mag();

            mD = a_n'*m_n;
            Zm_num1 = (a_n(2)*m_n(3) - a_n(3)*m_n(2));
            Zm_num2 = m_n(1) - mD*a_n(1);
            tmp = Zm_num1^2 + Zm_num2^2;
            
            % eul angles from triad meas
            phi = atan2(a_n(2), a_n(3));
            theta = asin(a_n(1));
            psi = atan2(Zm_num1, Zm_num2);
            
            % uncertainty propagation
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

            % convert from eul to quat
            [obj.X_att(1:4), obj.P_att(1:4,1:4)]  = obj.eul_to_quat([phi, theta, psi], Reul);
            obj.X_att(5:7) = bg;
            obj.P_att(5:7,5:7) = obj.Rgb;

        end
        
        function init_pos(obj, u, t)
            % init position state of the filter

            obj.uwb_t = t;
            obj.uwb(:,1) = reshape(u, 3, 1);
            obj.uwb_buff_iter = 1; %points to last insterted value
            
            % init pos = uwb, vel = 0
            obj.X_pos = [(reshape(u(1:2), 2, 1)); 0; 0];
            tmp = diag(obj.Ru);
            obj.P_pos = diag([tmp(1:2); tmp(1:2)*2]);
        end

        function step_imu(obj, a, m, g, t)
            % save sensor values
            obj.acc = (reshape(a, 3, 1) - obj.acc_bias) .* obj.acc_scale;
            obj.mag = obj.soft_iron' * (reshape(m, 3, 1) - obj.hard_iron);
            obj.gyro = reshape(g, 3, 1);
            
            % kalman steps
            obj.predict_att(t);
            obj.update_att();
            obj.predict_pos(t);
            
            % update imu data time instant
            obj.imu_t = t;

        end

        function step_uwb(obj, u, t)
            % check data correctness: 
            %   not perfectly zero
            %   less than arbitrary big value
            %   cap position variation between current state and measure [m]
            if u(1) ~= 0 && abs(u(1)) < 10000 && u(1)-obj.X_pos(1) < 9 && ...
               u(2) ~= 0 && abs(u(2)) < 10000 && u(2)-obj.X_pos(2) < 9
                
                %update iterator
                if obj.uwb_buff_iter == 1
                    obj.uwb_buff_iter = 2;
                else
                    obj.uwb_buff_iter = 1;
                end

                %save new data
                obj.uwb(:,obj.uwb_buff_iter) = reshape(u, 3, 1);
                % kalman step
                obj.update_pos(t);
                % update uwb data time instant
                obj.uwb_t = t;

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
            %rotMatrixQuaternions(q) given the att state, return the associated
            %rotation matrix from body to world
            q = obj.X_att(1:4);
            wRb = [q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2, 2*q(3)*q(2) - 2*q(4)*q(1), 2*q(3)*q(1) + 2*q(4)*q(2);
                   2*q(4)*q(1) + 2*q(3)*q(2), q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2, -2*q(2)*q(1) + 2*q(4)*q(3);
                   -2*q(3)*q(1) + 2*q(4)*q(2), 2*q(2)*q(1) + 2*q(4)*q(3), q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2];
        end

        function [aG, RaG] = func_aG(obj, init)
            % given acc readings, compute the gravity
            % acceleration contribution exploting the quadcopter dynamics
            % return: gravity acceleration normalized in body ref frame and
            % its uncertainty

            g = obj.G_ACC_VAL;
            mod = sqrt(max(g^2 - obj.acc(1)^2 - obj.acc(2)^2, 0));
            
            if init
                aZg = mod;
            else
                % estimate acc z comp from previous step
                wRb = obj.rotMatrixQuaternions();
                aG_prev = wRb'*[0;0;g];
                
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
            % given acc readings, compute the external
            % acceleration contribution exploting the quadcopter dynamics
            % return: external acceleration in world ref frame and
            % its uncertainty

            wRb = obj.rotMatrixQuaternions();
            aW = wRb * obj.acc;
            aW(3) = aW(3) - obj.G_ACC_VAL; 
            
            RaW = wRb*obj.Ra*wRb';
            
        end

        function [q, Rq] = eul_to_quat(obj, eul, Reul)
            % conversion from euler angles to quaternions
            % input: euler angles XYZ (roll, pitch, yaw)
            % return: quaternion and its uncertainty
            phi = eul(1);
            theta = eul(2);
            psi = eul(3);

            q = zeros(4,1);
            q(1) =  cos(phi/2) * cos(theta/2) * cos(psi/2) + sin(phi/2) * sin(theta/2) * sin(psi/2);
            q(2) =  sin(phi/2) * cos(theta/2) * cos(psi/2) - cos(phi/2) * sin(theta/2) * sin(psi/2);
            q(3) =  cos(phi/2) * sin(theta/2) * cos(psi/2) + sin(phi/2) * cos(theta/2) * sin(psi/2);
            q(4) =  cos(phi/2) * cos(theta/2) * sin(psi/2) - sin(phi/2) * sin(theta/2) * cos(psi/2);

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

            Rq = Jeul*Reul*Jeul';
        end
        
        function [qp, Rqp] = Hamilton_prod(obj, q1, q2, Rq1, Rq2)
            % hamilton product qp = q1*q2
            % input: quaternions to multiply and their uncertainty
            % return: product quaternion and its uncertainty

            % hamilton product
            qp = zeros(4,1);
            qp(1) = q1(1) * q2(1) - q1(2) * q2(2) - q1(3) * q2(3) - q1(4) * q2(4);
            qp(2) = q1(1) * q2(2) + q1(2) * q2(1) + q1(3) * q2(4) - q1(4) * q2(3);
            qp(3) = q1(1) * q2(3) - q1(2) * q2(4) + q1(3) * q2(1) + q1(4) * q2(2);
            qp(4) = q1(1) * q2(4) + q1(2) * q2(3) - q1(3) * q2(2) + q1(4) * q2(1);

            % uncertainty propagation
            Jq2 = [q1(1), - q1(2), - q1(3), - q1(4);
                   q1(2), q1(1), - q1(4), q1(3);
                   q1(3), q1(4), q1(1), - q1(2);
                   q1(4), - q1(3), q1(2), q1(1)];
            Jq1 = [q2(1), - q2(2), - q2(3), - q2(4);
                    q2(2), q2(1), q2(4), - q2(3);
                    q2(3), - q2(4), q2(1), q2(2);
                    q2(4), q2(3), - q2(2), q2(1)];
            Rqp = Jq1*Rq1*Jq1' + Jq2*Rq2*Jq2';
            
        end

        function [a_n, Ra_n] = norm_acc(obj)
            % return: normalized acc (saved value) and its uncertainty
            a_n = obj.acc ./ norm(obj.acc);
%             J = J_normalization(obj.acc);
%             Ra_n = J*obj.Ra*J';
            Ra_n = obj.Ra/obj.G_ACC_VAL^2;
        end

        function [m_n, Rm_n] = norm_mag(obj)
            % return: normalized mag (saved value) and its uncertainty
            m_n = obj.mag ./ norm(obj.mag);
            Rm_n = obj.soft_iron*obj.Rm*obj.soft_iron';
            J = obj.J_normalization(obj.mag);
            Rm_n = J*Rm_n*J';
%             Rm_n = obj.Rm/norm(obj.mag)^2;
        end
        
        function [z, Rz] = TRIAD(obj)
            % return: triad measurement and its unceratinty

            % Split acc contributions
            [aG, RaG] = obj.func_aG(false);
            % normalized mag readings 
            [m_n, Rm_n] = obj.norm_mag();
            
            % compute measures
            mD = a_n'*m_n;
            Zm_num1 = (a_n(2)*m_n(3) - a_n(3)*m_n(2));
%             Zm_num2 = m_n(1) - mD*a_n(1); %fifth measure
            mN = sqrt(1 - mD.^2);
            z = [a_n; Zm_num1/mN];% Zm_num2/mN];
            
            % uncert propagation matrices
            J_ZA = [eye(3,3);
                    Zm_num1*mD*m_n(1)/mN^3, ...
                    Zm_num1*mD*m_n(2)/mN^3 + m_n(3)/mN, ...
                    Zm_num1*mD*m_n(3)/mN^3 - m_n(2)/mN];
%                     Zm_num2*mD*m_n(1)/mN^3 - (mD+a_n(1)*m_n(1))/mN, ...
%                     Zm_num2*mD*m_n(2)/mN^3 -     a_n(1)*m_n(2) /mN, ...
%                     Zm_num2*mD*m_n(3)/mN^3 -     a_n(1)*m_n(3) /mN];  % fifth measurement


            J_ZM = [zeros(3,3);
                    Zm_num1*mD*a_n(1)/mN^3, ...
                    Zm_num1*mD*a_n(2)/mN^3 - a_n(3)/mN, ...
                    Zm_num1*mD*a_n(3)/mN^3 + a_n(2)/mN];
%                     Zm_num2*mD*a_n(1)/mN^3 - (a_n(1)^2 - 1) /mN, ...
%                     Zm_num2*mD*a_n(1)/mN^3 -  a_n(1)*a_n(2) /mN, ...
%                     Zm_num2*mD*a_n(1)/mN^3 -  a_n(1)*a_n(3) /mN];  % fifth measurement

            Rz = J_ZA*Ra_n*J_ZA' + J_ZM*Rm_n*J_ZM';
        end
        
        function predict_att(obj, t)
            % attitude prediction step

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

        end

        function update_att(obj)
            % attitude update step
            
            [z,Rz] = obj.TRIAD();

            % Predicted measurements
            Zpred = [-2*obj.X_att(3)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(2);
                    2*obj.X_att(2)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(3);
                    obj.X_att(1)^2 - obj.X_att(2)^2 - obj.X_att(3)^2 + obj.X_att(4)^2;
                    2*obj.X_att(4)*obj.X_att(1) + 2*obj.X_att(3)*obj.X_att(2)];
%                     obj.X_att(1)^2 + obj.X_att(2)^2 - obj.X_att(3)^2 - obj.X_att(4)^2]; % fifth measurement
    
            % linearized measurement mapping
%             J_H = zeros(5,7);
            J_H = zeros(4,7);
            J_H(:,1:4) = 2*...
              [-obj.X_att(3), obj.X_att(4), -obj.X_att(1), obj.X_att(2);
                obj.X_att(2), obj.X_att(1), obj.X_att(4), obj.X_att(3);
                obj.X_att(1), -obj.X_att(2), -obj.X_att(3), obj.X_att(4);
                obj.X_att(4), obj.X_att(3), obj.X_att(2), obj.X_att(1)];
%                 obj.X_att(1), obj.X_att(2), -obj.X_att(3), -obj.X_att(4)]; % fifth measurement
        
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
            % position prediction step 

            dt = t - obj.imu_t;

            % split acc contributions
            [aW, RaW] = obj.func_aW();

            % state function matrices
            A = [1, 0, dt, 0;
                 0, 1, 0,  dt;
                 0, 0, 1,  0;
                 0, 0, 0,  1];
            B = [dt^2/2, 0;
                 0,      dt^2/2;
                 dt,     0;
                 0,      dt];
            
            obj.X_pos = A*obj.X_pos + B*aW(1:2);
            obj.P_pos = A*obj.P_pos*A' + B*RaW(1:2,1:2)*B';

        end

        function update_pos(obj, t)
            % position update step

            dt = t - obj.uwb_t;
            
            % update depending on number of uwb data available
            if obj.uwb_buff_iter == 1 % pos
                z = obj.uwb(1:2, 1);
                Rz = obj.Ru(1:2,1:2);
                H = [eye(2), zeros(2)];
            else % pos+vel
                z = [obj.uwb(1:2, 2); (obj.uwb(1:2, 2) - obj.uwb(1:2, 1)) / dt];
                tmp = diag(obj.Ru(1:2,1:2));
                Rz = diag([tmp; tmp*2/dt^2]);
                H = eye(4);
            end

            Innovation_pos = z - H * obj.X_pos;

            S_pos = H * obj.P_pos * H' + Rz;
            W_pos = obj.P_pos * H' / S_pos;
            obj.X_pos = obj.X_pos + W_pos * Innovation_pos;
            obj.P_pos = (eye(4) - W_pos * H) * obj.P_pos;

        end
    end
end