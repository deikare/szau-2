% if isunix
%     system('wine sieci.exe');
% elseif ispc
%     disp('some random BS'); %%wstawić kod dla windowsa
% end
% disp('ready');
% fileID = fopen('testfile.txt', 'a');
% fprintf(fileID, 'new\n');
% fclose(fileID);
% 
% 
% handle = findobj('Type', 'figure');
% print(handle, 'wykres', '-dsvg');

clear;
model;
save('wagi.mat', 'w1', 'w10', 'w2', 'w20');
for i = 1 : 10
    figure;
end
handle = findobj('Type', 'figure');