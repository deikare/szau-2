function [ustat, ystat] = char_stat(umin, umax, alfa1, alfa2, beta1, beta2)
%%funkcja obliczajaca charakterystyke statyczna
    ustat = umin : 0.01 : umax;
    n = length(ustat);
    ystat = zeros(n, 1);
    ustat = ustat';
    for i = 1 : n
        ystat(i, 1) = g2(((beta1+beta2)*g1(ustat(i, 1)))/(1+alfa1+alfa2));
    end
end

