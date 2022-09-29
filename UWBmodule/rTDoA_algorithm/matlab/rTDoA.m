function [x_t, dt_new] = rTDoA(ts)

%time_const = 15.65e-12; %double(1/(63.8976 * 1000000000) );
time_const = 1;

t6_rx1 = double(ts(1,1)) * time_const;
t1_rx1 = double(ts(2,1)) * time_const;
t2_rx1 = double(ts(3,1)) * time_const;
t3_rx1 = double(ts(4,1)) * time_const;
t4_rx1 = double(ts(5,1)) * time_const;
t5_rx1 = double(ts(6,1)) * time_const;

t6_rx2 = double(ts(1,2)) * time_const;
t1_rx2 = double(ts(2,2)) * time_const;
t2_rx2 = double(ts(3,2)) * time_const;
t3_rx2 = double(ts(4,2)) * time_const;
t4_rx2 = double(ts(5,2)) * time_const;
t5_rx2 = double(ts(6,2)) * time_const; 

t6_tx1 = double(ts(1,3)) * time_const;
t1_tx1 = double(ts(2,3)) * time_const;
t2_tx1 = double(ts(3,3)) * time_const;
t3_tx1 = double(ts(4,3)) * time_const;
t4_tx1 = double(ts(5,3)) * time_const;
t5_tx1 = double(ts(6,3)) * time_const;

t6_tx2 = double(ts(1,4)) * time_const;
t1_tx2 = double(ts(2,4)) * time_const;
t2_tx2 = double(ts(3,4)) * time_const;
t3_tx2 = double(ts(4,4)) * time_const;
t4_tx2 = double(ts(5,4)) * time_const;
t5_tx2 = double(ts(6,4)) * time_const; 

% A_n6  = [3.00; 9.35; 3.15];
% A_n1 = [0.00; 7.19; 2.15];
% A_n2 = [0.00; 3.62; 3.15];
% A_n3 = [0.00; 0.00; 2.15];
% A_n4 = [4.79; 1.85; 3.15];
% A_n5 = [4.79; 5.45; 2.15];

A_n1 = [0.00; 0.00; 5.68];
A_n2 = [5.65; 0.00; 5.74];
A_n3 = [3.05; 4.95; 6.26];
A_n4 = [8.01; 7.35; 7.03];
A_n5 = [13.22; 4.95; 6.22];
A_n6 = [2.92; 11.05; 6.68];

A_n = [A_n6 A_n1 A_n2 A_n3 A_n4 A_n5];
c = 299702547;
n = length(A_n);

TOF_MA = sqrt(sum((A_n6*ones(1,6) - A_n).^2,1))/c;      % ToF anchor/master  

%real measurements
toa_tx = double([t6_tx1,t6_tx2; t1_tx1, t1_tx2; t2_tx1,t2_tx2; t3_tx1,t3_tx2; t4_tx1,t4_tx2; t5_tx1,t5_tx2]);
toa_rx = double([t6_rx1,t6_rx2; t1_rx1,t1_rx2; t2_rx1,t2_rx2; t3_rx1,t3_rx2; t4_rx1,t4_rx2; t5_rx1,t5_rx2]);
%Drift tag
dt_new = (toa_rx(:,2)-toa_rx(:,1))./(toa_tx(:,2)-toa_tx(:,1));

% tmp_rx(:,1) = toa_rx(:,1) - toa_rx(1,1);
% tmp_rx(:,2) = toa_rx(:,2) - toa_rx(1,2);
% 
% tmp_tx(:,1) = toa_tx(:,1).*dt - toa_tx(1,1)*dt(1);
% tmp_tx(:,2) = toa_tx(:,2).*dt - toa_tx(1,2)*dt(1);
% 
% % tdoa = ((tmp_rx(:,2) - tmp_tx(:,2)) + (tmp_rx(:,1) - tmp_tx(:,1)))/2;
%  tdoa = tmp_rx(:,2) - tmp_tx(:,2);
% tdoa(1)=[];
% D = c*tdoa;

tmp_rx = zeros(6,6);
tmp_rx(:,1) = toa_rx(:,1) - toa_rx(1,1) - (toa_tx(:,1).*dt_new - toa_tx(1,1)*dt_new(1));
tmp_rx(:,2) = toa_rx(:,2) - toa_rx(1,2) - (toa_tx(:,2).*dt_new - toa_tx(1,2)*dt_new(1));

%% TDoA
%     tdoa = tmp_rx(:,2) - tmp_tx(:,2);
tdoa = tmp_rx(:,2);
tdoa(1)=[];

D = c*tdoa;

%------Trilateration linear equations system-------------------
A = 2*[(A_n6(1)-A_n(1,2:n)'), (A_n6(2)-A_n(2,2:n)'),(A_n6(3)-A_n(3,2:n)'), D];
b = D.^2 + norm(A_n6)^2 - sum((A_n(:,2:n)'.^2),2);
x_t0 = pinv(A)*b;

%-----Non linear correction (Taylor Expansion)-----------------
x_t_0 = [x_t0(1); x_t0(2); x_t0(3)];
f = zeros(n-1,1);
del_f = zeros(n-1,3);

for ii=2:n
    norm1 = norm(x_t_0-A_n(:,ii));
    norm2 = norm(x_t_0-A_n(:,1));
    f(ii-1)=norm1-norm2;
    del_f(ii-1,1) = (x_t_0(1)-A_n(1,ii))*norm1^-1 - (x_t_0(1)-A_n(1,1))*norm2^-1;
    del_f(ii-1,2) = (x_t_0(2)-A_n(2,ii))*norm1^-1 - (x_t_0(2)-A_n(2,1))*norm2^-1;
    del_f(ii-1,3) = (x_t_0(3)-A_n(3,ii))*norm1^-1 - (x_t_0(3)-A_n(3,1))*norm2^-1;
end

x_t = pinv(del_f)*(D-f) + x_t_0; %+ [-1.324327660849931;-5.148878398647230;0]
% sprintf("TDoA: %d %d %d %d %d  POS: %d %d %d",tdoa(1),tdoa(2),tdoa(3),tdoa(4),tdoa(5),x_t(1),x_t(2),x_t(3))