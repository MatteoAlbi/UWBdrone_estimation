function [aG, RaG] = func_aG(q, a, ba, Ra, Rba)
% split_acc: given acc readings, acc bias and correspective uncertainties,
%            split the two contributions of gravity and body acc anc
%            compute corrispective uncertainties

g = 9.807;
a_nobias = a - ba;
tmp = sqrt(g^2-a_nobias(1)^2-a_nobias(2)^2);

% estimate acc z comp 
wRb = rotMatrixQuaternions(q);
aG_prev = wRb'*[0;0;g];
aZ_sign = sign(aG_prev(3));

% compute gravity z comp
aZg = aZ_sign * tmp;

% gravity vector
aG = [a_nobias(1); a_nobias(2); aZg]/g; %normalized

% jacobians to propagate uncertainties
JaG_a = [1,0,0;
         0,1,0;
         -a_nobias(1)/tmp, -a_nobias(2)/tmp, 0]/g;
JaG_ba = [-1,0,0;
          0,-1,0;
          a_nobias(1)/tmp, a_nobias(2)/tmp, 0]/g;

% propagate uncertainties
RaG = JaG_a*Ra*JaG_a' + JaG_ba*Rba*JaG_ba';

end