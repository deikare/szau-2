function charStatPlotter(u, y, directory, filename)
%%funkcja wyświetlająca charakterystykę statyczną i zapisująca ją do pliku
    fig = figure;
    plot(u, y);
    title('charakterystyka statyczna');
    xlabel('u');
    ylabel('y');
    
    print(fig, ['wykresy/', directory, '/', filename], '-dsvg');
end

