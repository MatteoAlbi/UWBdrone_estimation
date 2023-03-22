function [aW, Jx, Ju, aTrust] = func_aW(q, a, ba, dt, A)
% split_acc: given acc readings, acc bias and correspective uncertainties,
%            split the two contributions of gravity and body acc anc
%            compute corrispective uncertainties

a_nobias = a - ba;
g = 9.807;
tmp = sqrt(g^2-a_nobias(1)^2-a_nobias(2)^2);

% estimate acc z comp 
wRb = rotMatrixQuaternions(q);
aG_prev = wRb'*[0;0;g];
aZ_sign = sign(aG_prev(3));

% compute gravity z comp
aZg = aZ_sign * tmp;

% body acc in world frame
aTrust = aZg - a_nobias(3);
aW = wRb*[0;0;-aTrust];

% jacobians to propagate uncertainties
J_block1 = [a_nobias(1)/tmp*wRb(1,3), a_nobias(2)/tmp*wRb(1,3), wRb(1,3);
            a_nobias(1)/tmp*wRb(2,3), a_nobias(2)/tmp*wRb(2,3), wRb(2,3)];
J_block2 = [-q(3),-q(4),-q(1),-q(2);
            q(2),q(1),-q(4),-q(3)]*2*aTrust;

Jx_block = [J_block1*(-dt^2/2);
            J_block1*(-dt)];
Jx = [A, Jx_block;
      zeros(3,4), eye(3)];

Ju = [[J_block1,J_block2]*dt^2/2;
      [J_block1,J_block2]*dt;
      zeros(3,7)];

end