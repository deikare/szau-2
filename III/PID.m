function [Y, U] = PID(K, Ti, Td, Tp, n_op, Yzad, alfa1, alfa2, beta1, beta2, umin, umax)
%%regulator PID
%%obliczenie nastaw regulatora dyskretnego
    r2 = K * Td / Tp;
    r1 = K * (Tp / (2 * Ti) - 2 * Td / Tp - 1);
    r0 = K * (1 + Tp / (2 * Ti) + Td / Tp);
    
    Uop = zeros(n_op, 1);
    E = zeros(3, 1);
    upop = 0;
    
    n = length(Yzad);
    
    x1(1) = 0; 
    x2(1) = 0; 
    Y(1) = 0;
    U(1) = 0;
    for k = 2 : n
        %%prawo regulacji
        Uop(1) = r2 * E(3) + r1 * E(2) + r0 * E(1) + upop;
        if Uop(1) > umax %%przyciecie sterowania o ograniczenia
            Uop(1) = umax;
        elseif Uop(1) < umin
            Uop(1) = umin;
        end
        U(k) = Uop(n_op);
        x1(k) = -alfa1 * x1(k-1) + x2(k-1) + beta1 * g1(U(k));
        x2(k) = -alfa2 * x1(k-1) + beta2 * g1(U(k));
        Y(k) = g2(x1(k));
        %%przesuniecie uchybow oraz sterowan (sterowania sa przesuwane
        %%przez opoznienie = 5)
        E = circshift(E, 1);
        E(1) = Yzad(k) - Y(k);
        Uop = circshift(Uop, 1);
        upop = U(k);
    end
end

