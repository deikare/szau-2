clear; %%skrypt reprezentujacy dzialanie GPC i NPL
close all;
consts;

N_NO = 20;
Nu_NO = 2;
lambda_NO = 3;

N_GPC = 20;
Nu_GPC = 2;
lambda_GPC = 150;

N_NPL = 20;
Nu_NPL = 2;
lambda_NPL = 3;

i = 1;
shift = 200;
generator = rng(seed);
Yzad = zeros(1, n);
Yzad(1:n) = 0.15;
Yzad(201:n) = -0.8;
Yzad(401:n) = -0.05;
Yzad(601:n) = -1.4;
Yzad(801:n) = 0.1;
Yzad(1001:n) = -0.7;
Yzad(1201:n) = 0.18;
Yzad(1401:n) = -0.3;

Yzad_kryt = zeros(1, n) + 0.1;


kKryt = 18;
TKryt = 12;
[Ypid_kryt, Upid_kryt] = PID(kKryt, 9999999999, 0, 1, 5, Yzad_kryt, alfa1, alfa2, beta1, beta2, umin, umax);
[Ypid, Upid] = PID(0.6 * kKryt, TKryt / 2, TKryt / 8, 1, 5, Yzad, alfa1, alfa2, beta1, beta2, umin, umax);
[Ygpc, Ugpc] = GPC(Yzad, alfa1, alfa2, beta1, beta2, umin, umax, N_GPC, Nu_GPC, lambda_GPC); 
[Ynpl, Unpl] = NPL(Yzad, alfa1, alfa2, beta1, beta2, umin, umax, N_NPL, Nu_NPL, lambda_NPL); 
[Yno, Uno] = NO(Yzad, alfa1, alfa2, beta1, beta2, umin, umax, N_NO, Nu_NO, lambda_NO);

controllerPlotter(Ygpc, Ugpc, Yzad, 'y GPC', 'GPC', 'wykresy\GPC_nastrojone', umin, umax);
controllerPlotter(Ynpl, Unpl, Yzad, 'y NPL', 'NPL', 'wykresy\NPL_nastrojone', umin, umax);
controllerPlotter(Ypid_kryt, Upid_kryt, Yzad_kryt, 'y PID', 'PID', 'wykresy\PID_oscylacje', umin, umax);
controllerPlotter(Ypid, Upid, Yzad, 'y PID', 'PID', 'wykresy\PID_nastrojony', umin, umax);
controllerPlotter(Yno, Uno, Yzad, 'y NO', 'NO', 'wykresy\NO', umin, umax);

fig = figure;
stairs(Ygpc);
hold on;
stairs(Ynpl);
% stairs(Ypid);
stairs(Yno);
stairs(Yzad, '--');
title('y zbiorcze porównanie');
ylabel('y');
xlabel('k');
legend('GPC', 'NPL', 'NO', 'Yzad', 'Location', 'southeast');
hold off;

print(fig, 'wykresy/zbiorcza_y', '-dsvg');

fig = figure;
stairs(Ugpc);
hold on;
stairs(Unpl);
% stairs(Upid);
stairs(Uno);
title('u zbiorcze porównanie');
ylabel('u');
xlabel('k');
legend('GPC', 'NPL', 'NO', 'Location', 'southeast');
hold off;

print(fig, 'wykresy/zbiorcza_u', '-dsvg');


