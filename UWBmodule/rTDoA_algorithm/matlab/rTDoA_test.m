load s1_p_history.mat;
load s1_rx_history.mat;
load s1_tx_history.mat;

row  = 200;
time_const =  1/(63.8976 * 1000000000);

ts = [  toa_rx_history.a6_rx1(row) toa_rx_history.a6_rx2(row) toa_tx_history.a6_tx1(row) toa_tx_history.a6_tx2(row);
        toa_rx_history.a1_rx1(row) toa_rx_history.a1_rx2(row) toa_tx_history.a1_tx1(row) toa_tx_history.a1_tx2(row);
        toa_rx_history.a2_rx1(row) toa_rx_history.a2_rx2(row) toa_tx_history.a2_tx1(row) toa_tx_history.a2_tx2(row);
        toa_rx_history.a3_rx1(row) toa_rx_history.a3_rx2(row) toa_tx_history.a3_tx1(row) toa_tx_history.a3_tx2(row);
        toa_rx_history.a4_rx1(row) toa_rx_history.a4_rx2(row) toa_tx_history.a4_tx1(row) toa_tx_history.a4_tx2(row);
        toa_rx_history.a5_rx1(row) toa_rx_history.a5_rx2(row) toa_tx_history.a5_tx1(row) toa_tx_history.a5_tx2(row) ];
disp(ts);

tmp = ts/time_const;
format long;
for i = 1:6
    for j = 1:4
        fprintf('%15.f ',tmp(i,j));
    end   
    disp(';')

end

[x_t, dt] = rTDoA(ts);
disp(x_t_history(row,:));
disp(x_t');
