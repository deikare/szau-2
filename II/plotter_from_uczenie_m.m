function plotter_from_uczenie_m(farx, foe, krok, ng, dirname, filename)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    fig = figure; semilogy(farx,'b'); hold on; semilogy(foe,'r'); xlabel('Iteracje'); ylabel('Earx, Eoe'); legend('Earx','Eoe'); title('Uczenie predyktora OE');
    print(fig, ['wykresy/', dirname, '/predyktory_', filename], '-dsvg');
    fig = figure; subplot(2,1,1); semilogy(krok); xlabel('Iteracje'); ylabel('Krok');
    subplot(2,1,2); semilogy(ng); xlabel('Iteracje'); ylabel('Norma gradientu');
    print(fig, ['wykresy/', dirname, '/normy_', filename], '-dsvg');
end

