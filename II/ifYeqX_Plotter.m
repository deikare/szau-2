function [outputArg1,outputArg2] = ifYeqX_Plotter(y, y_neuron, dirname, filename)
    [y_sorted, sort_dir] = sort(y);
    y_neuron = y_neuron(sort_dir);
    
    figure;
    plot(y_sorted, y_ucz_siec, 'r*');
    hold on;
    fplot(@(x) x, [-1000 10000], 'Color', 'b', 'LineWidth', 1);
    xlim([min(y_sorted), max(y_sorted)]);
    ylim([min(y_neuron), max(y_neuron)]);
    xlabel('y uczące');
    ylabel('y z sieci neuronowej'); 
    title('dane uczące');
    hold off;
end

