function saveSettings(filename, nB, tau, nA, K, n, tol, algorytm_uczacy, tryb_uczenia)
    fileID = fopen(filename, 'w');
    fprintf(fileID, "%d %d %d %d %d %d %d %d", nB, tau, nA, K, n, tol, algorytm_uczacy, tryb_uczenia);
    fclose(fileID);
end

