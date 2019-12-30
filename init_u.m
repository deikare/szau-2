function U = init_u(n, n_op, umin, umax, u0, shift, seed)
%%funkcja inicjalizujaca wektor sterowan
    generator = rng(seed);
    h = umax - umin;
    U = zeros(n, 1);
    if n_op >= 1
        U(1 : n_op, 1) = u0;
    end
    i = n_op + 1;
    while i <= n
        U(i:i+shift, 1) = umin + h * rand;
        i = i + shift + 1;
    end
    U = U(1:n, 1);
end

