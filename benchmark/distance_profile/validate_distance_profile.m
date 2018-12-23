%% initial analysis
clc;
clear;
close all;

a = prnist([0:9],[1:50]);
fprintf("Dataset loaded.");

a = a*im_box(0,1);
a = a*im_resize([32 32]);
% convert to matrix
img = data2im(a);
% calculate the distance profile for all images
dist_profile =  cell2mat(arrayfun(@(x) distance_profile(cell2mat(x)), img, 'un',0)');
% convert to pr dataset
b = prdataset(dist_profile, getlab(a));
fprintf("Feature extracted. \n");

w = scalem([],'variance')*pcam([],0.9); %pca
fprintf("PCA Mapping Created. \n");

% classifiers = [parzenc, knnc([], 3), knnc([], 5), fisherc, qdc]
classifiers = {knnc([], 1), knnc([], 3), parzenc, fisherc, qdc, svc};

fprintf("start crossvalidation. \n");%% initial analysis
clc;
clear;
close all;

a = prnist([0:9],[1:50]);
fprintf("Dataset loaded.");

a = a*im_box(0,1);
a = a*im_resize([32 32]);
% convert to matrix
img = data2im(a);
% calculate the distance profile for all images
dist_profile =  cell2mat(arrayfun(@(x) distance_profile(cell2mat(x)), img, 'un',0)');
% convert to pr dataset
b = prdataset(dist_profile, getlab(a));
fprintf("Feature extracted. \n");

w = scalem([],'variance')*pcam([],0.9); %pca
fprintf("PCA Mapping Created. \n");

% classifiers = [parzenc, knnc([], 3), knnc([], 5), fisherc, qdc]
classifiers = {knnc([], 1), knnc([], 3), parzenc, fisherc, qdc, svc};

fprintf("start crossvalidation. \n");

folds = 10;
iters = 10;
i = 0;
err = [];
for c = 1:length(classifiers)
    %no pca
    err(c) = prcrossval(b,classifiers(c),folds,iters);
    % pca
    err_pca(c) = prcrossval(b,w*classifiers(c),folds,iters);
    fprintf("finished crossval. \n");
end

fprintf("all done. \n");



folds = 10;
iters = 10;
i = 0;
err = [];
for c = 1:length(classifiers)
    %no pca
    err(c) = prcrossval(b,classifiers(c),folds,iters);
    % pca
    err_pca(c) = prcrossval(b,w*classifiers(c),folds,iters);
    fprintf("finished crossval. \n");
end

fprintf("all done. \n");

save('distance_profiles_errors.mat')

