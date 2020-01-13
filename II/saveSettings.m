function saveSettings(filename, nB, tau, nA, K, n, tol, algorytm_uczacy, tryb_uczenia)
%%funkcja zapisujaca ustawienia pliku sieci.exe do pliku ustawienia.txt
    fileID = fopen(filename, 'w');
    fprintf(fileID, "%d %d %d %d %d %d %d %d", nB, tau, nA, K, n, tol, algorytm_uczacy, tryb_uczenia);
    fclose(fileID);
end

