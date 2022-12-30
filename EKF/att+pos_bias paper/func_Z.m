function [Z,Rz] = func_Z(q,a,Ra,ba,Rba,m,Rm)
g = 9.807;
a_nobias = a - ba;
tmp = sqrt(g^2-a_nobias(1)^2-a_nobias(2)^2);

% estimate acc z sign
wRb = rotMatrixQuaternions(q);
aG_prev = wRb'*[0;0;g];
aZ_sign = sign(aG_prev(3));

% compute gravity z comp
aZg = aZ_sign * tmp;

% gravity vector
an = [a_nobias(1); a_nobias(2); aZg] / g; %normalized

% TRIAD algorithm
mD = an'*m;
mN = sqrt(1 - mD.^2);
Z = [an(1); 
     an(2);
     (m(1) - an(1) * mD) / mN;
     (m(2) - an(2) * mD) / mN];

% jacobians to propagate uncertainties
Ja = [1/g,0,0;
      0,1/g,0;
      m(1)-m(3)*];

end