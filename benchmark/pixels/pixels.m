%% initial analysis
clc;
clear;
close all;

a = prnist([0:9],[1:500]);
fprintf("Dataset loaded.");

a = a*im_box(0,1);
a = a*im_resize([32 32]);

b = prdataset(getdata(a), getlab(a));

[test, train, idx_test, idx_train] = gendat(b, ones(10, 1) * 100, 1);

fprintf("Feature extracted. \n");

w = scalem([],'variance')*pcam([],1); %pca
fprintf("PCA Mapping Created. \n");

fprintf("start crossvalidation. \n");

classifiers = {qdc([], .2, .1)};

folds = 10;
iters = 10;
i = 0;
err = [];

best_err = 1;
best_err_pca = 1;
for c = 1:length(classifiers)
    %no pca
    err(c) = prcrossval(train,classifiers(c),folds,iters);
    if (err(c) < best_err) 
        best_err = err(c);
        best_classifier = classifiers(c);
    end
    
    % pca
    err_pca(c) = prcrossval(train,w*classifiers(c),folds,iters);
    if (err_pca(c) < best_err_pca) 
        best_err_pca = err_pca(c);
        best_classifier_pca = w*classifiers(c);
    end
    
    fprintf("finished crossval. \n");
end

fprintf("all done. \n");

save('pixels_errors.mat')

%%%%%%%%%%
% Pick Best One
%%%%%%%%%%
w = qdc(train, .2, .1);
testc(test, w);
confmat(w(test));

