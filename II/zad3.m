clear;
load('uczenie_zad2.mat');

errors_container_OE = [];

i = 1;
for container = containerZad2
    temp_errors_container = [];
    j = 1;
    for value = container.values
        temp_errors_container(j).error_ucz = value.errors.error_ucz;
        temp_errors_container(j).error_wer = value.errors.error_wer;
        temp_errors_container(j).wagi = value.wagi;
        j = j + 1;
    end
    T = struct2table(temp_errors_container);
    sortedT = sortrows(T, 'error_wer');
%     sortedArray = table2array(sortedT);
%     errors_container_OE(i, :) = sortedArray(1, :);
    i = i + 1;
end

clear containerZad2;

load('uczenie_zad2_ARX.mat');

errors_container_ARX = [];

i = 1;
for container = containerZad2
    temp_errors_container = [];
    j = 1;
    for value = container.values
        temp_errors_container(j).error_ucz = value.errors.error_ucz;
        temp_errors_container(j).error_wer = value.errors.error_wer;
        temp_errors_container(j).wagi = value.wagi;
        j = j + 1;
    end
    T = struct2table(temp_errors_container);
    sortedT = sortrows(T, 'error_wer');
%     sortedArray = table2array(sortedT);
%     errors_container_ARX(i, :) = sortedArray(1, :);
    i = i + 1;
end
