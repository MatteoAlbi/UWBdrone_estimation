function [wRb] = rotMatrixQuaternions(q)
%rotMatrixQuaternions(q) given the quaternion q, return the associated
%rotation matrix from body to world
wRb = [q(1)^2 + q(2)^2 - q(3)^2 - q(4)^2, 2*q(3)*q(2) - 2*q(4)*q(1), 2*q(3)*q(1) + 2*q(4)*q(2);
       2*q(4)*q(1) + 2*q(3)*q(2), q(1)^2 - q(2)^2 + q(3)^2 - q(4)^2, -2*q(2)*q(1) + 2*q(4)*q(3);
       -2*q(3)*q(1) + 2*q(4)*q(2), 2*q(2)*q(1) + 2*q(4)*q(3), q(1)^2 - q(2)^2 - q(3)^2 + q(4)^2];
end