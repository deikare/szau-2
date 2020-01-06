clear;
close all;
dane_ucz = readmatrix('dane.txt');
u_ucz = dane_ucz(:, 1);
y_ucz = dane_ucz(:, 2);

dane_wer = readmatrix('dane_weryfikujace.txt');
u_wer = dane_wer(:, 1);
y_wer = dane_wer(:, 2);

p = length(u_ucz);
n = 4;

nB = 5;
tau = 6;
nA = 2;

u0 = 0;
y0 = 0;

M = zeros(p, n);

M(:, 1) = circshift(u_ucz, nB);
M(1:nB, 1) = u0;
M(:, 2) = circshift(M(:, 1), 1);
M(1:tau, 2) = u0;
M(:, 3) = circshift(y_ucz, 1);
M(1,3) = y0;
M(:, 4) = circshift(y_ucz, nA);
M(1:nA, 4) = y0;

W = M \ y_ucz;
y_mod = M * W;

M_wer = zeros(p, n);

M_wer(:, 1) = circshift(u_wer, nB);
M_wer(1:nB, 1) = u0;
M_wer(:, 2) = circshift(M_wer(:, 1), 1);
M_wer(1:tau, 2) = u0;
M_wer(:, 3) = circshift(y_wer, 1);
M_wer(1,3) = y0;
M_wer(:, 4) = circshift(y_wer, nA);
M(1:nA, 4) = y0;

y_mod_wer = M_wer * W;

figure;
stairs(1:length(y_ucz), y_ucz);
hold on;
stairs(1:length(y_mod), y_mod);
hold off;

figure;
stairs(1:length(y_wer), y_wer);
hold on;
stairs(1:length(y_mod_wer), y_mod_wer);
hold off;

error = 0;
for i = 1 : p
    error = error + (y_mod(i) - y_ucz(i)) ^ 2;
end
disp(error);

error = 0;
for i = 1 : p
    error = error + (y_mod_wer(i) - y_wer(i)) ^ 2;
end
disp(error);
% M(:, 1) = circshift(M(:, 1), nB);
% M(1 : nB, 1) = u0;
% M(:, 3 : 4) = y_ucz;
% 
% M(:, 1) = circshift(M(:, 1), nB);
% M(1:nB, 1) =