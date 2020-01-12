function y = funkcja(x)
    global w2 w1 w20 w10
    y = w2*tanh(w1*x+w10)+w20;
end