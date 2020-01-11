function [x1, x2, y] = getModel(u, n_op, x1_0, x2_0, y0, alfa1, alfa2, beta1, beta2)
%%funkcja zwraca model całego procesu w oparciu o wektor sygnału u
    n = length(u);
    
    x1 = zeros(n, 1);
    x2 = zeros(n, 1);
    y = zeros(n, 1);

    x1(1:n_op, 1) = x1_0;
    x2(1:n_op, 1) = x2_0;
    y(2:n_op, 1) = y0;

    for k = n_op+1 : n
        x1(k, 1) = -alfa1 * x1(k-1, 1) + x2(k-1, 1) + beta1 * g1(u(k - n_op, 1));
        x2(k, 1) = -alfa2 * x1(k-1, 1) + beta2 * g1(u(k - n_op, 1));
        y(k, 1) = g2(x1(k, 1));
    end
end

