clear;
close all;
% load('zad2_alg_ucz=2_tr_ucz=2_tr_sym=2.mat');
% load('uczenie_zad2_ARX.mat');
load('zad2_alg_ucz=2_tr_ucz=2_tr_sym=2_n=400.mat');
% load('zad2_alg_ucz=2_tr_ucz=2_tr_sym=2_n=200.mat');


errors_container_OE = [];

dane_ucz = readmatrix('dane.txt');
u_ucz = dane_ucz(:, 1)';
y_ucz = dane_ucz(:, 2)';

dane_wer = readmatrix('dane_weryfikujace.txt');
u_wer = dane_wer(:, 1)';
y_wer = dane_wer(:, 2)';

tryb_sym = 2;


i = 1;
for container = containerZad2
    temp_errors_container = [];
    j = 1;
    for value = container.values
        temp_errors_container(j).error_ucz = value.errors.error_ucz;
        temp_errors_container(j).error_wer = value.errors.error_wer;
        temp_errors_container(j).wagi = value.wagi;
        temp_errors_container(j).wyjscie_uczenie_m = value.wyjscia_uczenie_m;
        j = j + 1;
    end
    T = struct2table(temp_errors_container);
    sortedT = sortrows(T, 'error_wer');

    sortedStruct = table2struct(sortedT);
    sortedTable = struct2table(sortedStruct);

    errors_container_OE(i).error_ucz = sortedStruct(1).error_ucz;
    errors_container_OE(i).error_wer = sortedStruct(1).error_wer;
    errors_container_OE(i).wagi = sortedStruct(1).wagi;
    errors_container_OE(i).wyjscie_uczenie_m = sortedStruct(1).wyjscie_uczenie_m;
    errors_container_OE(i).K = container.K;
    
    y_ucz_siec = getFuzzyModel(u_ucz, sortedStruct(1).wagi.w1, sortedStruct(1).wagi.w10, sortedStruct(1).wagi.w2, sortedStruct(1).wagi.w20, tryb_sym, y_ucz);
    y_wer_siec = getFuzzyModel(u_wer, sortedStruct(1).wagi.w1, sortedStruct(1).wagi.w10, sortedStruct(1).wagi.w2, sortedStruct(1).wagi.w20, tryb_sym, y_wer);
    napis = [', K = ', num2str(errors_container_OE(i).K)];
    modelsPlotter(y_ucz, y_ucz_siec, y_wer, y_wer_siec, 'zad2', ['sygnalyY_K=', num2str(container.K)], napis);
    ifYeqX_Plotter(y_ucz, y_ucz_siec, 'zad2', ['porownanie_ucz_K=', num2str(container.K)], 'uczace', napis);
    ifYeqX_Plotter(y_wer, y_wer_siec, 'zad2', ['porownanie_wer_K=', num2str(container.K)], 'weryfikujace', napis);
    i = i + 1;
end

best_neural_model = errors_container_OE(9);
plotter_from_uczenie_m(best_neural_model.wyjscie_uczenie_m.farx, best_neural_model.wyjscie_uczenie_m.foe, best_neural_model.wyjscie_uczenie_m.krok, best_neural_model.wyjscie_uczenie_m.ng, 'zad3', ['wyniki_K=', num2str(best_neural_model.K)]);

y_ucz_siec = getFuzzyModel(u_ucz, best_neural_model.wagi.w1, best_neural_model.wagi.w10, best_neural_model.wagi.w2, best_neural_model.wagi.w20, tryb_sym, y_ucz);
y_wer_siec = getFuzzyModel(u_wer, best_neural_model.wagi.w1, best_neural_model.wagi.w10, best_neural_model.wagi.w2, best_neural_model.wagi.w20, tryb_sym, y_wer);
napis = [', K = ', num2str(best_neural_model.K)];
modelsPlotter(y_ucz, y_ucz_siec, y_wer, y_wer_siec, 'zad4', ['sygnalyY_K=', num2str(best_neural_model.K)], napis);
ifYeqX_Plotter(y_ucz, y_ucz_siec, 'zad4', ['porownanie_ucz_K=', num2str(best_neural_model.K)], 'uczace', napis);
ifYeqX_Plotter(y_wer, y_wer_siec, 'zad4', ['porownanie_wer_K=', num2str(best_neural_model.K)], 'weryfikujace', napis);

errorsTable = struct2table(errors_container_OE);
sortedTable = sortrows(errorsTable, 'error_wer');
errors_container_OE = table2struct(sortedTable);