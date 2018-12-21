%% initial analysis
clear all;
close all;
clc; 

load 'Hog4x4_bicubic.mat';
Hog4x4_bic = a;
load 'Hog4x4_noBicubic.mat';
Hog4x4_noBic = a;
load 'Hog8x8_bicubic.mat';
Hog8x8_bic = a;
load 'Hog8x8_noBicubic.mat';
Hog8x8_noBic = a;

clsf = parzenc;
folds = 10;
iters = 5;
w = scalem([],'variance')*pcam([],0.9); %pca

%no pca
[err4x4_bic,b_4x4_bic] = prcrossval(Hog4x4_bic,clsf,folds,iters);
[err4x4_noBic,b_4x4_noBic] = prcrossval(Hog4x4_noBic,clsf,folds,iters);
[err8x8_bic,b_8x8_bic] = prcrossval(Hog8x8_bic,clsf,folds,iters);
[err8x8_noBic,b_8x8_noBic] = prcrossval(Hog8x8_noBic,clsf,folds,iters);

% pca
[err4x4_bic_pca,b_4x4_bic_pca] = prcrossval(Hog4x4_bic,w*clsf,folds,iters);
[err4x4_noBic_pca,b_4x4_noBic_pca] = prcrossval(Hog4x4_noBic,w*clsf,folds,iters);
[err8x8_bic_pca,b_8x8_bic_pca] = prcrossval(Hog8x8_bic,w*clsf,folds,iters);
[err8x8_noBic_pca,b_8x8_noBic_pca] = prcrossval(Hog8x8_noBic,w*clsf,folds,iters);
