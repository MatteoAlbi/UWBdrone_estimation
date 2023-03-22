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