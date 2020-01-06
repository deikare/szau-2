function modelsPlotter(y_ucz, y_ucz_siec, y_wer, y_wer_siec, dirname, filename)
    fig = figure;
    tiledlayout(2,1);

    nexttile;
    stairs(1:length(y_ucz), y_ucz);
    hold on;
    stairs(1:length(y_ucz_siec), y_ucz_siec);
    title('dane uczace');
    xlabel('t');
    ylabel('y');
    legend('model', 'model neuronowy', 'Location', 'southeast');
    hold off;

    nexttile;
    stairs(1:length(y_wer), y_wer);
    hold on;
    stairs(1:length(y_wer_siec), y_wer_siec);
    title('dane weryfikujace');
    xlabel('t');
    ylabel('y');
    legend('model', 'model neuronowy', 'Location', 'southeast');
    hold off;
end

