clear;
consts;
i = 1;
shift = 200;
n = 1600;
Yzad = zeros(1, n);
Yzad(1:n) = 0.15;
Yzad(200:n) = -0.8;
Yzad(400:n) = -0.05;
Yzad(600:n) = -1.4;
Yzad(800:n) = 0.1;
Yzad(1000:n) = -0.7;
Yzad(1200:n) = 0.18;
Yzad(1400:n) = -0.3;

kKryt = 18;
TKryt = 12;
[Y, U] = PID(0.6 * kKryt, TKryt / 2, TKryt / 8, 1, 5, Yzad, alfa1, alfa2, beta1, beta2, umin, umax);
[YNo, UNo] = NO(Yzad, alfa1, alfa2, beta1, beta2, umin, umax);


figure;
tiledlayout(2,1);
nexttile;
stairs(1 : length(Y), Y);
hold on;
stairs(1 : length(YNo), YNo);
stairs(1 : length(Yzad), Yzad, '--');
title('y');
legend('Pid', 'NO', 'Location', 'southeast');
xlabel('k');
ylabel('y');
hold off;

nexttile;
stairs(1 : length(U), U);
hold on;
stairs(1 : length(UNo), UNo);
legend('Pid', 'NO', 'Location', 'southeast');
title('u');
xlabel('k');
ylabel('u');
ylim([umin umax]);
hold off;

