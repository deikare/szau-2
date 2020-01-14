function controllerPlotter(Y, U, Yzad, title_, legend_, filepath, umin, umax)
%%funkcja plotujaca wykresy pojedynczego regulatora
    fig = figure;
    tiledlayout(2,1);
    nexttile;
    stairs(1 : length(Y), Y);
    hold on;
    stairs(1 : length(Yzad), Yzad, '--');
    legend(legend_, 'Yzad', 'Location', 'southeast');
    title(title_);
    ylabel('y');
    xlabel('k');
    hold off;

    nexttile;
    stairs(1 : length(U), U);
    hold on;
    title('u');
    ylabel('u');
    xlabel('k');
    ylim([umin umax]);
    hold off;

    print(fig, filepath, '-dsvg');
end

