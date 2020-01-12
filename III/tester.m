clear;
close all;
consts;
i = 1;
shift = 200;
Yzad = zeros(1, n);
generator = rng(seed);
Yzad(1:n) = 0.15;
Yzad(200:n) = -0.8;
Yzad(400:n) = -0.05;
Yzad(600:n) = -1.4;
Yzad(800:n) = 0.1;
Yzad(1000:n) = -0.7;
Yzad(1200:n) = 0.18;
Yzad(1400:n) = -0.3;

% while i < n
%     Yzad(i:i+shift) = -1.6 + 1.8 * rand();
%     i = i + shift + 1;
% end
% Yzad = Yzad(1:n);

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
ylim([umin umax]);
hold off;


