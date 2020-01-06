function Yest = getFuzzyModel(U, w1, w10, w2, w20, tryb, Y)
%%funkcja obliczająca wyjście sieci neuronowej
%%tryb=2 == OE, w innym przypadku ARX
    na = 2;
    nb = 6;
    tau = 5;

    n = length(U);
    Yest = zeros(1, n);

    for i = 1: nb
        Yest(1,i) = Y(i);
    end
    
    if tryb == 2 %%rekurencyjny
        for i = nb+1:n
            Yest(1,i) = w20 + w2*tanh(w10 + w1*[flip(U(i-nb:i-tau)) flip(Yest(i-na:i-1))]');
        end
    else
        for i=nb+1:n
            Yest(1,i) = w20 + w2*tanh(w10 + w1*[flip(U(i-nb:i-tau)) flip(Y(i-na:i-1))]');
        end
    end


end