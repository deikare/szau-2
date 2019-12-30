clear;
close all;

n = 2000; %liczba probek
n_op = 5; %%numer opoznienia;
umin = -1;
umax = 1;
x1_0 = 0;
x2_0 = 0;
y0 = 0;
u0 = 0;
shift = 50; %5okres zmian sterowania
seed = 20;

alfa1 = -1.272717;
alfa2 = 0.332871;
beta1 = 0.0284;
beta2 = 0.019723;

U = init_u(n, n_op, umin, umax, u0, shift, seed);

x1 = zeros(n, 1);
x2 = zeros(n, 1);
y = zeros(n, 1);

x1(1:n_op, 1) = x1_0;
x2(1:n_op, 1) = x2_0;
y(2:n_op, 1) = y0;

for k = n_op+1 : n
    x1(k, 1) = -alfa1 * x1(k-1, 1) + x2(k-1, 1) + beta1 * g1(U(k - n_op, 1));
    x2(k, 1) = -alfa2 * x1(k-1, 1) + beta2 * g1(U(k - n_op, 1));
    y(k, 1) = g2(x1(k, 1));
end

fh = figure;
fh.WindowState = 'maximized';
tiledlayout(2, 2);

nexttile;
stairs(1:n, U);
title('U');

nexttile;
stairs(1:n, x1);
title('x1');

nexttile;
stairs(1:n, x2);
title('x2');

nexttile;
stairs(1:n, y);
title('y');

[ustat, ystat] = char_stat(umin, umax, alfa1, alfa2, beta1, beta2);

fh = figure;
fh.WindowState = 'maximized';
plot(ustat, ystat);
xlabel('u');
ylabel('y');
% for i = 1 : 50
%     figure;
%     Uakt = init_u(n, n_op, umin, umax, u0, shift, i);
%     stairs(1:n, Uakt);
%     title(['U, seed=', num2str(i)]);
% end

