clear;
close all;
nB = 5;
tau = 6;
nA = 2;
n = 50;
tol = 0.00001;
algorytm_uczacy = 2;
tryb_uczenia = 1;
tryb_symulacji = 1;
K_wektor = 1 : 10;
ilosc_prob = 10;

dane_ucz = readmatrix('dane.txt');
u_ucz = dane_ucz(:, 1)';
y_ucz = dane_ucz(:, 2)';

dane_wer = readmatrix('dane_weryfikujace.txt');
u_wer = dane_wer(:, 1)';
y_wer = dane_wer(:, 2)';

containerZad2 = uczenieZad2(u_ucz, y_ucz, u_wer, y_wer, 'ustawienia.txt', nB, tau, nA, n, tol, algorytm_uczacy, tryb_uczenia, ilosc_prob, K_wektor, tryb_symulacji);

% container = [];
% j = 1;
% for K = K_wektor
%     if K >= 15
%         ilosc_prob = 1;
%     end
%     wektor_bledow = zeros(ilosc_prob, 2);
%     errors_to_save = zeros(1, 2);
%     uczenie_results = [];
%     for i = 1: ilosc_prob
%         saveSettings('ustawienia.txt', nB, tau, nA, K, n, tol, algorytm_uczacy, tryb_uczenia);
%         
%         if isunix
%             system('wine sieci.exe');
%         elseif ispc
%             disp('some random BS'); %%wstawić kod dla windowsa
%         end
%         
%         save('temp_storage.mat');
%         uczenie;
%         load('temp_storage.mat');
%         model;
%         
%         uczenie_results(i).Earx = Earx;
%         uczenie_results(i).Eoe = Eoe;
%         uczenie_results(i).farx = farx;
%         uczenie_results(i).foe = foe;
%         uczenie_results(i).krok = krok;
%         uczenie_results(i).ng = ng;
%         uczenie_results(i).w1 = w1;
%         uczenie_results(i).w10 = w10;
%         uczenie_results(i).w2 = w2;
%         uczenie_results(i).w20 = w20;
%         
%         clear Earx;
%         clear Eoe;
%         clear farx;
%         clear foe;
%         clear krok;
%         clear ng;
%         close all;
%         
%         y_ucz_siec = getFuzzyModel(u_ucz, w1, w10, w2, w20, tryb_uczenia, y_ucz);
%         y_wer_siec = getFuzzyModel(u_wer, w1, w10, w2, w20, tryb_uczenia, y_wer);
%         
% %         figure;
% %         tiledlayout(2,1)
% % 
% %         nexttile;
% %         stairs(1:length(y_ucz), y_ucz);
% %         hold on;
% %         stairs(1:length(y_ucz_siec), y_ucz_siec);
% %         title('dane uczace');
% %         xlabel('t');
% %         ylabel('y');
% %         legend('model', 'model neuronowy', 'Location', 'southeast');
% %         hold off;
% % 
% %         nexttile;
% %         stairs(1:length(y_wer), y_wer);
% %         hold on;
% %         stairs(1:length(y_wer_siec), y_wer_siec);
% %         title('dane weryfikujace');
% %         xlabel('t');
% %         ylabel('y');
% %         legend('model', 'model neuronowy', 'Location', 'southeast');
% %         hold off;
%         
%         wektor_bledow(i, 1) = errorKwadratowy(y_ucz, y_ucz_siec);
%         wektor_bledow(i, 2) = errorKwadratowy(y_wer, y_wer_siec);
%         
% %         [y_ucz_sorted, sort_dir] = sort(y_ucz);
% %         y_ucz_siec = y_ucz_siec(sort_dir);
% % 
% %         [y_wer_sorted, sort_dir] = sort(y_wer);
% %         y_wer_siec = y_wer_siec(sort_dir);
% % 
% %         figure;
% %         plot(y_ucz_sorted, y_ucz_siec, 'r*');
% %         hold on;
% %         fplot(@(x) x, [-1000 10000], 'Color', 'b', 'LineWidth', 1);
% %         xlim([min(y_ucz_sorted), max(y_ucz_sorted)]);
% %         ylim([min(y_ucz_siec), max(y_ucz_siec)]);
% %         xlabel('y uczące');
% %         ylabel('y z sieci neuronowej'); 
% %         title('dane uczące');
% %         hold off;
% % 
% % 
% %         figure;
% %         plot(y_wer_sorted, y_wer_siec, 'r*');
% %         hold on;
% %         fplot(@(x) x, [-1000 10000], 'Color', 'b', 'LineWidth', 1);
% %         xlim([min(y_wer_sorted), max(y_wer_sorted)]);
% %         ylim([min(y_wer_siec), max(y_wer_siec)]);
% %         xlabel('y weryfikujące');
% %         ylabel('y z sieci neuronowej'); 
% %         title('dane weryfikujące');
% %         hold off;
%     end
%     
% %     min_error_wer = min(wektor_bledow(:, 2));
% %     index = find(wektor_bledow(:, 2) == min_error_wer, 1);
% %     errors_to_save(1, 1) = wektor_bledow(index, 1);
% %     errors_to_save(1, 2) = min_error_wer;
%     
% %     container(j).errors_to_save = errors_to_save;
% %     container(j).uczenie_results = uczenie_results(index);
%     container(j).wektor_bledow = wektor_bledow;
%     container(j).uczenie_results = uczenie_results;
%     j = j+1;
% end

save('uczenie_zad2_ARX.mat', 'containerZad2');
