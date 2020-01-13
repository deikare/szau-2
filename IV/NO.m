function [y, u] = NO(yzad, alpha1, alpha2, beta1, beta2, umin, umax)
% clear variables
    global w2 w1 w20 w10
% model;
    load('model.mat');

%     alpha1 = -1.272717;
%     alpha2 = 0.332871;
%     beta1 = 0.028400;
%     beta2 = 0.019723;

    na = 2;
    nb = 6;
    tau = 5;

    delta = 0.00001;

    N = 20;
    Nu = 2;
    lambda = 3;

    n = length(yzad);

    u = zeros(n+N,1);
    du = zeros(n+N,1);
%     umin = -1;
%     umax = 1;

    x1 = zeros(n,1);
    x2 = zeros(n,1);

    y = zeros(n+N,1);
    ym = zeros(n,1);
    A = 0;
    b = 0;
    X = zeros(Nu, 1);
%     yzad = zeros(n,1);
%     yzad(50:n,1) = -0.3;
%     yzad(250:n,1) = 0.1;
%     yzad(500:n,1) = -1.1;
%     yzad(750:n,1) = -0.5;

    M = zeros(N,Nu);
    s = zeros(N,1);
    yO = zeros(N, 1);
    
    % load('daneucz');     %trzeba tu za�adowa� nasze dane ucz�ce
    dane_ucz = readmatrix('dane.txt');
    x_ucz = dane_ucz(:, 1)';
    y_ucz = dane_ucz(:, 2)';

    a = zeros(na,1);
    b = zeros(nb,1);
    b(5) = (funkcja([x_ucz(2)+delta x_ucz(2) y_ucz(6) y_ucz(5)]')-funkcja([x_ucz(2) x_ucz(1) y_ucz(6) y_ucz(5)]'))/delta;
    b(6) = (funkcja([x_ucz(2) x_ucz(2)+delta y_ucz(6) y_ucz(5)]')-funkcja([x_ucz(2) x_ucz(1) y_ucz(6) y_ucz(5)]'))/delta;
    a(1) = -(funkcja([x_ucz(2) x_ucz(2) y_ucz(6)+delta y_ucz(5)]')-funkcja([x_ucz(2) x_ucz(1) y_ucz(6) y_ucz(5)]'))/delta;
    a(2) = -(funkcja([x_ucz(2) x_ucz(2) y_ucz(6) y_ucz(5)+delta]')-funkcja([x_ucz(2) x_ucz(1) y_ucz(6) y_ucz(5)]'))/delta;


    for j=1:N
        s(j) = 0;
        for i = 1:min(j,nb)
            s(j) = s(j) + b(i);
        end
        for i = 1:min(j-1,na)
            s(j) = s(j) - a(i)*s(j-i);
        end
    end 

    for i = 1 : N
        for j = 1 : Nu
            if (i-j+1)>0
                M(i,j)=s(i-j+1);
            end
        end
    end

    K = (M'*M + lambda*eye(Nu,Nu))^-1*M';
    
    Umin_w = zeros(Nu, 1);
    Umax_w = zeros(Nu, 1);

    for k=tau+2:n
        k
        x1(k) = -alpha1*x1(k-1)+x2(k-1)+beta1*g1(u(k-5));
        x2(k) = -alpha2*x1(k-1)+beta2*g1(u(k-5));
        y(k)= g2(x1(k));

        qk = [u(k-5) u(k-6) y(k-1) y(k-2)]';
        ym(k) = w20 + w2*tanh(w10+w1*qk);
        dk = y(k)-ym(k);
        
        Umin_w(:) = umin - u(k-1);
        Umax_w(:) = umax - u(k-1);
        
        for p = 1:N
            qk = [u(min(k-5+p,k-1)) u(min(k-6+p,k-1)) y(k-1+p) y(k-2+p)]';
            y(k+p) = w20 + w2*tanh(w10+w1*qk) + dk;
            yO(p) = y(k+p);
        end
        
        Yzad = yzad(k) * ones(N, 1);
        u0 = zeros(Nu, 1) + u(k-1);
        fun = @(x) ((Yzad -yO - M * x)') * (Yzad -yO - M * x) + lambda * (x') * x;
        
        
        du(k:k+Nu-1) = fmincon(fun, u0, [0 0], 0, [0 0], 0, Umin_w, Umax_w);
        

%         du(k:k+Nu-1) = K*(yzad(k)*ones(N,1)-y(k+1:k+N));
        u(k) = u(k-1) + du(k);
        u(k) = min(u(k), umax);
        u(k) = max(u(k), umin);
    end
    y = y(1:n);
    u = u(1:n);
end

