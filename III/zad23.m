clear; %%skrypt reprezentujacy dzialanie GPC i NPL
close all;
consts;
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

fig = figure;
tiledlayout(2,1);
nexttile;
stairs(1 : length(Ygpc), Ygpc);
hold on;
stairs(1 : length(Ynpl), Ynpl);
stairs(1 : length(Yzad), Yzad, '--');
legend('GPC', 'NPL', 'Yzad', 'Location', 'southeast');
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

print(fig, 'wykresy/NPL_GPC_nastrojone', '-dsvg');
