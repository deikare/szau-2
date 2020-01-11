function dataPlotter(u_ucz, y_ucz, u_wer, y_wer, directory, filename) 
%%funkcja wyświetlająca podział na zbiory uczący i weryfikujący oraz
%%zapisująca ten wykres do pliku
    fig = figure;
    tiledlayout(2,1);

    nexttile;
    stairs(1:length(u_ucz), u_ucz);
    hold on;
    stairs(1:length(y_ucz), y_ucz);
    title('dane uczące');
    xlabel('k');
    ylabel('u/y');
    legend('u', 'y', 'Location', 'southeast');
    hold off;

    nexttile;
    stairs(1:length(u_wer), u_wer);
    hold on;
    stairs(1:length(y_wer), y_wer);
    title('dane weryfikujące');
    xlabel('k');
    ylabel('u/y');
    legend('u', 'y', 'Location', 'southeast');
    hold off;
    
    print(fig, ['wykresy/', directory, '/', filename], '-dsvg');
end

