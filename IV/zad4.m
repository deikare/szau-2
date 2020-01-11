clear;
consts;
i = 1;
shift = 200;
% Yzad = zeros(1, n);
while i < n
    Yzad(i:i+shift) = -1.6 + 1.8 * rand();
    i = i + shift + 1;
end

kKryt = 18;
TKryt = 12;
[Y, U] = PID(0.6 * kKryt, TKryt / 2, TKryt / 8, 1, 5, Yzad, alfa1, alfa2, beta1, beta2, umin, umax);


figure;
tiledlayout(2,1);
nexttile;
stairs(1 : length(Y), Y);
hold on;
stairs(1 : length(Yzad), Yzad, '--');

nexttile;
stairs(1 : length(U), U);