function charStatPlotter(u, y, directory, filename)
%%funkcja wyświetlająca charakterystykę statyczną i zapisująca ją do pliku
    fh = figure;
    plot(u, y);
    title('charakterystyka statyczna');
    xlabel('u');
    ylabel('y');
end

