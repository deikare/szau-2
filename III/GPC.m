function [y, u] = GPC(yzad, alpha1, alpha2, beta1, beta2, umin, umax, N, Nu, lambda)
%%regulator GPC
    load('model.mat');

    na = 2;
    nb = 6;
    tau = 5;

    delta = 0.00001;

%     N = 20;
%     Nu = 2;
%     lambda = 150;

    n = length(yzad);
    n0 = 10;

    u = zeros(n+N,1);
    du = zeros(n+N,1);

    x1 = zeros(n,1);
    x2 = zeros(n,1);

    y = zeros(n+N,1);
    ym = zeros(n,1);
    y0 = zeros(N,1);

    % load('daneucz');     %trzeba tu za�adowa� nasze dane ucz�ce
    dane_ucz = readmatrix('dane.txt');
    x_ucz = dane_ucz(:, 1)';
    y_ucz = dane_ucz(:, 2)';

    M = zeros(N,Nu);
    s = zeros(N,1);
%%obliczanie wspolczynnikow modelu zlinearyzowanego
    a = zeros(na,1);
    b = zeros(nb,1);
    b(5) = (funkcja([x_ucz(2)+delta x_ucz(2) y_ucz(6) y_ucz(5)]')-funkcja([x_ucz(2) x_ucz(1) y_ucz(6) y_ucz(5)]'))/delta;
    b(6) = (funkcja([x_ucz(2) x_ucz(2)+delta y_ucz(6) y_ucz(5)]')-funkcja([x_ucz(2) x_ucz(1) y_ucz(6) y_ucz(5)]'))/delta;
    a(1) = -(funkcja([x_ucz(2) x_ucz(2) y_ucz(6)+delta y_ucz(5)]')-funkcja([x_ucz(2) x_ucz(1) y_ucz(6) y_ucz(5)]'))/delta;
    a(2) = -(funkcja([x_ucz(2) x_ucz(2) y_ucz(6) y_ucz(5)+delta]')-funkcja([x_ucz(2) x_ucz(1) y_ucz(6) y_ucz(5)]'))/delta;

%%obliczanie wspolczynnikow odpowiedzi skokowych
    for j=1:N
        s(j) = 0;
        for i = 1:min(j,nb)
            s(j) = s(j) + b(i);
        end
        for i = 1:min(j-1,na)
            s(j) = s(j) - a(i)*s(j-i);
        end
    end 
%%obliczenie macierzy M
    for i = 1 : N
        for j = 1 : Nu
            if (i-j+1)>0
                M(i,j)=s(i-j+1);
            end
        end
    end

    K = (M'*M + lambda*eye(Nu,Nu))^-1*M';
%%regulacja
    for k=tau+2:n
        k
        x1(k) = -alpha1*x1(k-1)+x2(k-1)+beta1*g1(u(k-5));
        x2(k) = -alpha2*x1(k-1)+beta2*g1(u(k-5));
        y(k)= g2(x1(k)); %%pomiar y

        ym(k) = b(5)*u(k-5)+b(6)*u(k-6)-a(1)*y(k-1)-a(2)*y(k-2); %%obliczenie z modelu
        dk = y(k)-ym(k); %%szum

        for p = 1:N %%obliczenie odpowiedzi skokowej
            y(k+p) = b(5)*u(min(k-tau+p,k-1)) + b(6)*u(min(k-tau-1+p,k-1)) - a(1)*y(k-1+p) - a(2)*y(k-2+p) + dk;
        end
        %%prawo regulacji
        du(k:k+Nu-1) = K*(yzad(k)*ones(N,1)-y(k+1:k+N));
        u(k) = u(k-1) + du(k);
        u(k) = min(u(k), umax);
        u(k) = max(u(k), umin);
    end
    %%przyciecie wektorow wyjsciowych do odpowiednich dlugosci
    y = y(1:n);
    u = u(1:n);
end

