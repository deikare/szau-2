function result = errorKwadratowy(y, yest)
%%funkcja obliczająca błąd średniokwadratowy dwóch wektorów
    result = 0;
    n = length(y);
    for i = 1 : n
        result = result + power(y(i) - yest(i), 2);
    end
end

