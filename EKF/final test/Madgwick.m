classdef Madgwick < handle
    %Madgwick Implements Madgwick filter for attitude estimation
    %   Code inspired by https://github.com/bjohnsonfl/Madgwick_Filter/blob/master/madgwickFilter.c

    properties (Hidden = true)
        q_est % estimated attitude
        beta % gyro error parameter
        gamma % gyro bias error parameter
        w_bias % estimated gyro bias
    end

    methods
        function obj = Madgwick(q, Rg, gamma)
            %Madgwick Construct an instance of this class
            %   Detailed explanation goes here
            obj.q_est = q;
            obj.w_bias = zeros(3,1);
            obj.beta = sqrt(3/4) * mean(sqrt(diag(Rg))); % eq 50
            obj.gamma = sqrt(3/4) * gamma; % eq 51
            
        end

        function q = get_q(obj)
            q = obj.q_est;
        end

        function bg = get_bias(obj)
            bg = obj.w_bias;
        end

        function q_est = imu_filter(obj, a, w, m, dt)
            %imu_filter Perform filtering step using Madgwick filter
            %   Detailed explanation goes here

            q = obj.q_est; % prev estimation
            % accelerometer
            q_a = [0; a]; % eq 24
            q_a = q_a / norm(q_a);
            % magnetometer
            q_m = [0; m]; % eq 28
            q_m = q_m / norm(q_m);

            % correct magnetometer distortions
            h = quatmultiply(quatmultiply(q', q_m'), quatconj(q'))'; % eq 45
            b = [norm(h(2:3)); 0 ; h(4)]; % eq 46

            % -- Gradient
            % minimization for acc
            F_g = [ 2*(q(2)*q(4) - q(1)*q(3)) - q_a(2);
                    2*(q(1)*q(2) + q(3)*q(4)) - q_a(3);
                    2*(0.5 - q(2)^2 - q(3)^2) - q_a(4)]; % eq 25
            J_g = [ -q(3), q(4), -q(1), q(2);
                    q(2), q(1), q(4), q(3);
                    0, -2*q(2), -2*q(3), 0] * 2; % eq 26
            %  minimization for magnetometer
            F_b = [ 2*b(1)*(0.5-q(3)^2-q(4)^2) + 2*b(3)*(q(2)*q(4)-q(1)*q(3)) - q_m(2);
                    2*b(1)*(q(2)*q(3)-q(1)*q(4)) + 2*b(3)*(q(1)*q(2)+q(3)*q(4)) - q_m(3);
                    2*b(1)*(q(1)*q(3)+q(2)*q(4)) + 2*b(3)*(0.5-q(2)^2-q(3)^2) - q_m(4)]; % eq 29            
            J_b = [ -b(3)*q(3), b(3)*q(4), -2*b(1)*q(3)-b(3)*q(1), -2*b(1)*q(4)+b(3)*q(2);
                    -b(1)*q(4)+b(3)*q(2), b(1)*q(3)+b(3)*q(1), b(1)*q(2)+b(3)*q(4), -b(1)*q(1)+b(3)*q(3);
                    b(1)*q(3), b(1)*q(4)-2*b(3)*q(2), b(1)*q(1)-2*b(3)*q(3), b(1)*q(2)]*2;% eq 30
            % Gradientquat_mult
            F_gb = [F_g; F_b]; % eq 31
            J_gb = [J_g; J_b]; % eq 32 note: incorrect to take transpose, shape doesn't match
            grad = J_gb'*F_gb; % eq 34 with MARG
            % angular rate from grad
            q_dot_eps = grad / norm(grad); % eq 44

            % correct gyro bias
            w_eps = 2 * quatmultiply(quatconj(q'), q_dot_eps')'; % eq 47
            % integration (eq 48) discarding first element (w_c(1) = 0 always)
            obj.w_bias = obj.w_bias + w_eps(2:4) * dt; 
            w_c = w - obj.gamma .* obj.w_bias; % eq 49, corrected gyro
            % angular rate from gyro
            q_dot_w = 0.5 * quatmultiply(q', [0; w_c]')'; % eq 12
            
            % fusion
            q_dot = q_dot_w - obj.beta * q_dot_eps; % eq 43

            % integration
            q_est = q + q_dot * dt; % eq 42
            q_est = q_est / norm(q_est);

            obj.q_est = q_est;

        end
    end

end