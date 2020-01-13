function [outputArg1,outputArg2] = ifYeqX_Plotter(y, y_neuron, dirname, filename, figtitle, additional_title)
%%funkcja drukujaca porownanie wyjscia modelu z danymi i zapisujaca ten
%%wykres do pliku

    [y_sorted, sort_dir] = sort(y);
    y_neuron = y_neuron(sort_dir);
    
    fig = figure;
%     fig.WindowState = 'maximized';

    plot(y_sorted, y_neuron, 'r*');
    hold on;
    fplot(@(x) x, [-1000 10000], 'Color', 'b', 'LineWidth', 1);
    xlim([min(y_sorted), max(y_sorted)]);
    ylim([min(y_neuron), max(y_neuron)]);
    xlabel('y dane');
    ylabel('y z modelu'); 
    title(['dane ', figtitle, additional_title]);
    hold off;
    
    print(fig, ['wykresy/', dirname, '/', filename], '-dsvg');
end

