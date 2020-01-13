clear;
%%skrypt pelniacy role zadania 8
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

%obliczenie macierzy M
M(:, 1) = circshift(u_ucz, nB);
M(1:nB, 1) = u0;
M(:, 2) = circshift(M(:, 1), 1);
M(1:tau, 2) = u0;
M(:, 3) = circshift(y_ucz, 1);
M(1,3) = y0;
M(:, 4) = circshift(y_ucz, nA);
M(1:nA, 4) = y0;

% znalezienie wektora W bedacego wspolczynnikami modelu z MNK
W = M \ y_ucz;
y_mod_ucz = 0;

%%obliczenie wyjscia modelu na danych uczacych
for k = 1 : p
    uk_5 = M(k, 1);
    uk_6 = M(k, 2);
%     yk_1 = 0;
%     yk_2 = 0;
    
    if k-1 < 1
        yk_1 = y_ucz(1);
    else
        yk_1 = y_mod_ucz(k-1);
%         yk_1 = y_ucz(k-1);
    end
    
    if k-2<1
        yk_2 = y_ucz(k);
    else
        yk_2 = y_mod_ucz(k-2);
%         yk_2 = y_ucz(k-2);
    end
    
    X = [uk_5 uk_6 yk_1 yk_2];
%     disp(X);

    
    y_mod_ucz(k) = X * W;
end

y_mod_wer = 0;
M_wer = zeros(p, n);

M_wer(:, 1) = circshift(u_wer, nB);
M_wer(1:nB, 1) = u0;
M_wer(:, 2) = circshift(M_wer(:, 1), 1);
M_wer(1:tau, 2) = u0;
M_wer(:, 3) = circshift(y_wer, 1);
M_wer(1,3) = y0;
M_wer(:, 4) = circshift(y_wer, nA);
M_wer(1:nA, 4) = y0;

%%obliczenie wyjscia modelu na danych weryfikujacych
for k = 1 : p
    uk_5 = M_wer(k, 1);
    uk_6 = M_wer(k, 2);
%     yk_1 = 0;
%     yk_2 = 0;
    
    if k-1 < 1
        yk_1 = y_wer(1);
    else
        yk_1 = y_mod_wer(k-1);
%         yk_1 = y_wer(k-1);
    end
    
    if k-2<1
        yk_2 = y_wer(k);
    else
        yk_2 = y_mod_wer(k-2);
%         yk_2 = y_wer(k-2);
    end
    
    X = [uk_5 uk_6 yk_1 yk_2];
%     disp(X);
    
    y_mod_wer(k) = X * W;
end

%%obliczenie bledow uczacych i weryfikujacych
error_ucz = 0;
for i = 1 : p
    error_ucz = error_ucz + (y_mod_ucz(i) - y_ucz(i)) ^ 2;
end
disp(error_ucz);

error_wer = 0;
for i = 1 : p
    error_wer = error_wer + (y_mod_wer(i) - y_wer(i)) ^ 2;
end
disp(error_wer);
%%wykresy reprezentujace wyniki
napis = '';
modelsPlotter(y_ucz, y_mod_ucz, y_wer, y_mod_wer, 'zad8', 'sygnalyY', [', błąd uczący = ', num2str(error_ucz), ', weryfikujący = ', num2str(error_wer)]);
ifYeqX_Plotter(y_ucz, y_mod_ucz, 'zad8', 'porownanie_ucz', 'uczace', napis);
ifYeqX_Plotter(y_wer, y_mod_wer, 'zad8','porownanie_wer', 'weryfikujace', napis);
