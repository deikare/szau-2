%%skrypt pokazujacy regulator P wchodzacy w oscylacje krytyczne
clear;
consts;
i = 1;
shift = 200;
n = 1600;

kKryt = 18;
TKryt = 12;

Yzad = zeros(1, n) + 0.1;

[Y, U] = PID(kKryt, 9999999999, 0, 1, 5, Yzad, alfa1, alfa2, beta1, beta2, umin, umax);

fig = figure;
tiledlayout(2, 1);

nexttile;
stairs(1 : length(Y), Y);
hold on;
stairs(1 : length(Yzad), Yzad, '--');
legend('PID', 'Yzad', 'Location', 'southeast');
title('y');
xlabel('k');
ylabel('y');
hold off;

nexttile;
stairs(1 : length(U), U);
hold on;
title('u');
xlabel('k');
ylabel('u');
ylim([umin umax]);
hold off;

print(fig, 'wykresy/zad4/PID_oscylacje', '-dsvg');


