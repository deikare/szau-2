clear;
close all;
consts;
i = 1;
shift = 200;
Yzad = zeros(1, n);
while i < n
    Yzad(i:i+shift) = -1.6 + 1.8 * rand();
    i = i + shift + 1;
end

% kKryt = 18;
% TKryt = 12;
% [Y, U] = PID(0.6 * kKryt, TKryt / 2, TKryt / 8, 1, 5, Yzad, alfa1, alfa2, beta1, beta2, umin, umax);
[Ygpc, Ugpc] = GPC(Yzad, alfa1, alfa2, beta1, beta2, umin, umax); 
[Ynpl, Unpl] = NPL(Yzad, alfa1, alfa2, beta1, beta2, umin, umax); 

figure;
tiledlayout(2,1);
nexttile;
stairs(1 : length(Ygpc), Ygpc);
hold on;
stairs(1 : length(Ynpl), Ynpl);
stairs(1 : length(Yzad), Yzad, '--');
legend('GPC', 'NPL', 'Location', 'southeast');
title('y');
ylabel('y');
xlabel('k');
hold off;

nexttile;
stairs(1 : length(Ugpc), Ugpc);
hold on;
stairs(1 : length(Unpl), Unpl);
legend('GPC', 'NPL', 'Location', 'southeast');
title('u');
ylabel('u');
xlabel('k');
hold off;
