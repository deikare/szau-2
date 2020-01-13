%%skrypt symulujacy dzialanie obu regulatorow 
clear;
consts;
i = 1;
shift = 200;
n = 1600;
Yzad = zeros(1, n);
Yzad(1:n) = 0.15;
Yzad(201:n) = -0.8;
Yzad(401:n) = -0.05;
Yzad(601:n) = -1.4;
Yzad(801:n) = 0.1;
Yzad(1001:n) = -0.7;
Yzad(1201:n) = 0.18;
Yzad(1401:n) = -0.3;

kKryt = 18;
TKryt = 12;
[Ypid, Upid] = PID(0.6 * kKryt, TKryt / 2, TKryt / 8, 1, 5, Yzad, alfa1, alfa2, beta1, beta2, umin, umax);
[YNo, UNo] = NO(Yzad, alfa1, alfa2, beta1, beta2, umin, umax);


fig = figure;
tiledlayout(2,1);
nexttile;
stairs(1 : length(Ypid), Ypid);
hold on;
% stairs(1 : length(YNo), YNo);
stairs(1 : length(Yzad), Yzad, '--');
title('y');
legend('Pid', 'Yzad', 'Location', 'southeast');
xlabel('k');
ylabel('y');
hold off;

nexttile;
stairs(1 : length(Upid), Upid);
hold on;
% stairs(1 : length(UNo), UNo);
% legend('Pid', 'NO', 'Location', 'southeast');
title('u');
xlabel('k');
ylabel('u');
ylim([umin umax]);
hold off;

print(fig, 'wykresy/zad4/PID_nastrojony', '-dsvg');

fig = figure;
tiledlayout(2,1);
nexttile;
stairs(1 : length(YNo), YNo);
hold on;
% stairs(1 : length(YNo), YNo);
stairs(1 : length(Yzad), Yzad, '--');
title('y');
legend('NO', 'Yzad', 'Location', 'southeast');
xlabel('k');
ylabel('y');
hold off;

nexttile;
stairs(1 : length(UNo), UNo);
hold on;
% stairs(1 : length(UNo), UNo);
% legend('Pid', 'NO', 'Location', 'southeast');
title('u');
xlabel('k');
ylabel('u');
ylim([umin umax]);
hold off;

print(fig, 'wykresy/zad5/NO', '-dsvg');