function eul = quat_to_eul(q)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
eul = [ atan2(2*q(2)*q(1)+2*q(4)*q(3), q(1)^2-q(2)^2-q(3)^2+q(4)^2);
        asin(2*q(1)*q(3)-2*q(2)*q(4));
        atan2(2*q(4)*q(1)+2*q(3)*q(2), q(1)^2+q(2)^2-q(3)^2-q(4)^2) ]*180/pi;

end