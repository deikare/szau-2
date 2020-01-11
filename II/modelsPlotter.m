function modelsPlotter(y_ucz, y_ucz_siec, y_wer, y_wer_siec, dirname, filename, additional_title)
    fig = figure;
%     fig.WindowState = 'maximized';

    tiledlayout(2,1);

    nexttile;
    stairs(1:length(y_ucz), y_ucz);
    hold on;
    stairs(1:length(y_ucz_siec), y_ucz_siec);
%     title(['dane uczace, K = ', num2str(K)]);
    title(['dane uczace', additional_title]);
    xlabel('k');
    ylabel('y');
    legend('dane', 'model', 'Location', 'southeast');
    hold off;

    nexttile;
    stairs(1:length(y_wer), y_wer);
    hold on;
    stairs(1:length(y_wer_siec), y_wer_siec);
    title('dane weryfikujace');
    xlabel('k');
    ylabel('y');
    legend('dane', 'model', 'Location', 'southeast');
    hold off;
    
    print(fig, ['wykresy/', dirname, '/', filename], '-dsvg');
end

