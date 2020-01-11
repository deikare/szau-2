function container = uczenieZad2(u_ucz, y_ucz, u_wer, y_wer, settings_filename, nB, tau, nA, n, tol, algorytm_uczacy, tryb_uczenia, ilosc_prob, K_wektor, tryb_symulacji)
    container = [];
    j = 1;
    
%     container.tryb_uczenia = tryb_uczenia;
%     container.algorytm_uczacy = algorytm_uczacy;
    for K = K_wektor
%         if K >= 15
%             ilosc_prob = 1;
%         end
        uczenie_results = [];
        
%         errors_to_save = zeros(1, 2);
        
        saveSettings(settings_filename, nB, tau, nA, K, n, tol, algorytm_uczacy, tryb_uczenia);
        for i = 1: ilosc_prob
            if isunix
                system('wine sieci.exe');
            elseif ispc
                system('start /wait sieci.exe');
            end

            save('temp_storage.mat');
            uczenie;
            load('temp_storage.mat');
            model;

            uczenie_results(i).wyjscia_uczenie_m.Earx = Earx;
            uczenie_results(i).wyjscia_uczenie_m.Eoe = Eoe;
            uczenie_results(i).wyjscia_uczenie_m.farx = farx;
            uczenie_results(i).wyjscia_uczenie_m.foe = foe;
            uczenie_results(i).wyjscia_uczenie_m.krok = krok;
            uczenie_results(i).wyjscia_uczenie_m.ng = ng;
            uczenie_results(i).wagi.w1 = w1;
            uczenie_results(i).wagi.w10 = w10;
            uczenie_results(i).wagi.w2 = w2;
            uczenie_results(i).wagi.w20 = w20;
            
            if (tryb_uczenia == 2)
                uczenie_results(i).tryb_uczenia = 'OE';
            else
                uczenie_results(i).tryb_uczenia = 'ARX';
            end
            if (algorytm_uczacy == 1)
                uczenie_results(i).algorytm_uczacy = 'najszybszy_spadek';
            else
                uczenie_results(i).algorytm_uczacy = 'BFGS';
            end
            
            wektor_bledow = zeros(1, 2);

            clear Earx;
            clear Eoe;
            clear farx;
            clear foe;
            clear krok;
            clear ng;
            close all;

            y_ucz_siec = getFuzzyModel(u_ucz, w1, w10, w2, w20, tryb_symulacji, y_ucz);
            y_wer_siec = getFuzzyModel(u_wer, w1, w10, w2, w20, tryb_symulacji, y_wer);

%             wektor_bledow(1, 1) = errorKwadratowy(y_ucz, y_ucz_siec);
%             wektor_bledow(1, 2) = errorKwadratowy(y_wer, y_wer_siec);
            
            uczenie_results(i).errors.error_ucz = errorKwadratowy(y_ucz, y_ucz_siec);
            uczenie_results(i).errors.error_wer = errorKwadratowy(y_wer, y_wer_siec);
        end
        container(j).values = uczenie_results;
        container(j).K = K;
        j = j+1;
    end
end

