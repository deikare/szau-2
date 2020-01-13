%%skrypt uczacy modele neuronowe dla zadania 5

clear;
close all;
nB = 5;
tau = 6;
nA = 2;
n = 400;
tol = 0.00001;
algorytm_uczacy = 1;
tryb_uczenia = 2;
tryb_symulacji = 2;
K_wektor = 9;
ilosc_prob = 10;

dane_ucz = readmatrix('dane.txt');
u_ucz = dane_ucz(:, 1)';
y_ucz = dane_ucz(:, 2)';

dane_wer = readmatrix('dane_weryfikujace.txt');
u_wer = dane_wer(:, 1)';
y_wer = dane_wer(:, 2)';

containerZad5 = uczenieZad2(u_ucz, y_ucz, u_wer, y_wer, 'ustawienia.txt', nB, tau, nA, n, tol, algorytm_uczacy, tryb_uczenia, ilosc_prob, K_wektor, tryb_symulacji);
%%serializacja wyniku uczenia, dalej przetwarzac bedzie skrypt zad5b.m
save(['zad5_alg_ucz=', num2str(algorytm_uczacy), '_tr_ucz=', num2str(tryb_uczenia), '_tr_sym=', num2str(tryb_symulacji), '_n=', num2str(n), '.mat'], 'containerZad5');

