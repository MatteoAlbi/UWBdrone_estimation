classdef EKF < handle
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here

    properties
        % state and uncert. matrices
        X_att = zeros(4,1);
        P_att = zeros(4);
        ext_acc = zeros(3,1);
        Eacc = zeros(3);
        triad = zeros(5,1);
%         att_buff_dim = 5;
%         att_buff = zeros(4, 5);
%         att_buff_iter = 1;
        prev_att = zeros(4,1);
        prev_p_att = zeros(4);
        iter = 0;
        % sensor config
        Ra;
        Rm;
        soft_iron;
        ca;
        % sensor data
        acc_data = zeros(3,1);
        mag_data = zeros(3,2);
        
        % constant
        CA = 0.8;
        EKF_SIGMA_99 = 5;
        EKF_MAX_GYRO = 1000;
        EKF_DT = 0.005;
        G = 1000;

        % acc detection
        mag_buff_iter = ones(1,8);
    end

    methods

        function obj = EKF(ra, rm, si, ca)
            %EKF Construct an instance of this class
            %   Detailed explanation goes here
            obj.Ra = ra;
            obj.Rm = rm;
            obj.soft_iron = si;
            obj.CA = ca;
        end

        function x_att = get_att(obj)
            x_att = obj.X_att;
        end

        function ext_acc = get_ext_acc(obj)
            ext_acc = obj.ext_acc;
        end

        function acc_det = get_acc_det(obj)
            acc_det = min(obj.mag_buff_iter) - 1;
        end

        function triad = get_triad(obj)
            triad = obj.triad;
        end

        function init_att(obj, acc, mag)
            obj.elab_data(acc, mag);

            [a_n, Ra_n] = norm_acc(obj);
            [m_n, Rm_n] = norm_mag(obj, min(obj.mag_buff_iter));

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

            obj.prev_att = obj.X_att;
            obj.prev_p_att = obj.P_att;
            
            % ext acc
            wRb = obj.rotMatrixQuaternions();
            obj.ext_acc = obj.acc_data - obj.G * wRb(3,:)';

%             obj.att_buff(:, obj.att_buff_iter) = obj.X_att;
%             obj.att_buff_iter = obj.att_buff_iter +1;
        end

        function step(obj, acc, mag)
            obj.elab_data(acc, mag);

            obj.update_att();
            
%             obj.predict_att();
            if min(obj.mag_buff_iter) == 2
                obj.predict_att();
            else
%                 obj.update_att();
            end
%             obj.predict_att();
%             if obj.iter < 50 
%                 obj.update_att();
%             end

%             if(obj.att_buff_iter < obj.att_buff_dim)
%                 obj.att_buff_iter = obj.att_buff_iter +1;
%                 obj.att_buff(:, obj.att_buff_iter) = obj.X_att;
%             else
%                 obj.att_buff(:,1:4) = obj.att_buff(:,2:5);
%                 obj.att_buff(:, obj.att_buff_iter) = obj.X_att;
%             end

            obj.iter = obj.iter +1;

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
            acc = obj.acc_data - obj.ext_acc .* obj.ca;
            a_n = acc ./ norm(acc);
            Ra_n = (obj.Ra+obj.Eacc) ./ norm(acc)^2;
%             a_n = obj.acc_data ./ norm(obj.acc_data);
%             J = J_normalization(obj.acc_data);
%             Ra_n = J*(obj.Ra+obj.Eacc)*J';
            
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
                if(min(obj.mag_buff_iter) == 2)
                    % shift registers
                    obj.mag_data(:,1) = obj.mag_data(:,2);
                end
                obj.mag_buff_iter = [obj.mag_buff_iter(2:5), 2];
                
            else
                obj.mag_buff_iter = [obj.mag_buff_iter(2:5), 1];
            end

            if(min(obj.mag_buff_iter) == 2)
                obj.ca = obj.CA;
            else
                obj.ca = obj.CA / 2;
            end

            obj.mag_data(:, min(obj.mag_buff_iter)) = mag;

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

        function [wRb] = rotMatrixQuaternions(obj)
            %rotMatrixQuaternions(q) given the quaternion q, return the associated
            %rotation matrix from body to world
            q = obj.X_att(1:4);
            wRb = [q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2, 2*q(3)*q(2) - 2*q(4)*q(1), 2*q(3)*q(1) + 2*q(4)*q(2);
                   2*q(4)*q(1) + 2*q(3)*q(2), q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2, -2*q(2)*q(1) + 2*q(4)*q(3);
                   -2*q(3)*q(1) + 2*q(4)*q(2), 2*q(2)*q(1) + 2*q(4)*q(3), q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2];
        end

        function [z, Rz] = TRIAD(obj)
            % modify acc reading using ext acc estimation
            W = diag(obj.ext_acc) / sum(abs(obj.ext_acc));
            obj.Eacc = (obj.ca^2*norm(obj.ext_acc)^2 + ...
                   abs(norm(obj.acc_data)^2 - obj.G)) * W;

            [a_n, Ra_n] = norm_acc(obj);
            [m_n, Rm_n] = norm_mag(obj, min(obj.mag_buff_iter));

            mD = sum(a_n.*m_n);
            Zm_num1 = (a_n(2)*m_n(3) - a_n(3)*m_n(2));
            Zm_num2 = m_n(1) - mD*a_n(1);
            mN = sqrt(1 - mD.^2);
            z = [a_n; Zm_num1/mN; Zm_num2/mN];%atan2(Zm_num1, Zm_num2)];
            obj.triad = z;% Zm_num2/mN];
            
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
                    Zm_num2*mD*a_n(2)/mN^3 -  a_n(1)*a_n(2) /mN, ...
                    Zm_num2*mD*a_n(3)/mN^3 -  a_n(1)*a_n(3) /mN];
%                     (a_n(1)^2 - 1)*Zm_num1/tmp, ...
%                      a_n(1)*a_n(2)*Zm_num1/tmp - a_n(3)/tmp2, ...
%                      a_n(1)*a_n(3)*Zm_num1/tmp + a_n(2)/tmp2];

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
            
            q_rot = [(1 + dot(v1,v2))/4; cross(v1,v2)];
            Rq_rot = Jmag1*Rm_n1*Jmag1' + Jmag2*Rm_n2*Jmag2';
            
            Jn = J_normalization(q_rot);
            q_rot = q_rot / norm(q_rot);
            Rq_rot = Jn*Rq_rot*Jn';

            [obj.X_att, obj.P_att] = obj.Hamilton_prod(obj.X_att, q_rot, obj.P_att, Rq_rot);
            
%             % obtain rotating quat
%             q_prev_con = obj.prev_att .* [1;-1;-1;-1];
%             [qd, Rqd] = obj.Hamilton_prod(q_prev_con, obj.X_att, obj.prev_p_att, obj.P_att);
%             % reduce rotation angle and normalize
%             qd(1) = qd(1)/2;
%             qd = qd / norm(qd);
%             
%             %save current attitude
%             tmp_q = obj.X_att;
%             tmp_p = obj.P_att;
%             
%             % predict next
%             [obj.X_att, obj.P_att] = obj.Hamilton_prod(tmp_q, qd, tmp_p, Rqd);
%             
%             % update prev attitude
%             obj.prev_att = tmp_q;
%             obj.prev_p_att = tmp_p;

%             rate = obj.att_buff(:,2:5) - obj.att_buff(:,1:4);
%             rate_mean = mean(rate,2);
%             rate_dev = std(rate, 0, 2);
%             obj.X_att = obj.X_att + rate_mean;
%             obj.P_att = obj.P_att + diag(rate_dev);

        end

        function update_att(obj)
            
            % increment previous P_att
%             scale = (1 + 3*obj.EKF_MAX_GYRO*obj.EKF_DT/2)^2;
            scale = 100;
            for i = 1:length(obj.P_att)
                obj.P_att(i,i) = obj.P_att(i,i)*scale;
            end
%             obj.P_att = eye(4);

            [Z, Rz] = obj.TRIAD();
            
            % Predicted measurements
            tmp = 2*obj.X_att(4)*obj.X_att(1) + 2*obj.X_att(3)*obj.X_att(2);
            tmp2 = obj.X_att(1)^2+obj.X_att(2)^2 - obj.X_att(3)^2-obj.X_att(4)^2;
            
            Zpred = [-2*obj.X_att(3)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(2);
                    2*obj.X_att(2)*obj.X_att(1) + 2*obj.X_att(4)*obj.X_att(3);
                    obj.X_att(1)^2 - obj.X_att(2)^2 - obj.X_att(3)^2 + obj.X_att(4)^2;
                    tmp;tmp2];
%                     atan2(tmp, tmp2) ];
    
            % linearized measurement mapping
%             tmp3 = tmp2 + tmp^2/tmp2;
%             tmp4 = tmp2^2 + tmp^2;

            J_H = 2*...
              [-obj.X_att(3), obj.X_att(4), -obj.X_att(1), obj.X_att(2);
                obj.X_att(2), obj.X_att(1), obj.X_att(4), obj.X_att(3);
                obj.X_att(1), -obj.X_att(2), -obj.X_att(3), obj.X_att(4);
                obj.X_att(4), obj.X_att(3), obj.X_att(2), obj.X_att(1);%];
                obj.X_att(1), obj.X_att(2), -obj.X_att(3), -obj.X_att(4)];
%                 2*(obj.X_att(4)/tmp3 - obj.X_att(1)*tmp/tmp4), ...
%                 2*(obj.X_att(4)/tmp3 - obj.X_att(2)*tmp/tmp4), ...
%                 2*(obj.X_att(4)/tmp3 + obj.X_att(3)*tmp/tmp4), ...
%                 2*(obj.X_att(4)/tmp3 + obj.X_att(4)*tmp/tmp4) ];
        
            Innovation_att = Z - Zpred;

            % Kalmann steps
            S_att = J_H*obj.P_att*J_H' + Rz;
            tmp_M = obj.P_att*J_H';
%             [Q,R] = qr(tmp_M);
            W_att = mrdivide(tmp_M,S_att);
            obj.X_att = obj.X_att + W_att*Innovation_att;
            obj.P_att = (eye(4) - W_att*J_H) * obj.P_att;
            
            obj.X_att = obj.X_att/norm(obj.X_att);
            
            % ext acc
            wRb = obj.rotMatrixQuaternions();
            obj.ext_acc = obj.acc_data - obj.G * wRb(3,:)';
        end

    end
end