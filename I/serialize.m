function serialize(filepath, u, y)
    fileID = fopen(filepath, 'w');
    n = length(u);

    for i = 1 : n
        fprintf(fileID, '%f\t', u(i));
        fprintf(fileID, '%f\n', y(i));
    end

    fclose(fileID);
end


    