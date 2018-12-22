clc;
clear all;
close all;

trn = prnist([0:9],[1:10]);
tst = prnist([0:9],[11:1000]);


transformations = [0, .1, .2, .3, .4, .5, .6, .7, .8, 1, 2, 4];
i = 1;
folds = 10;
iters = 10;
err = [];

tst_feats = my_rep(tst);
clsf = knnc([], 3);

for t = transformations
    output = transform_images(trn, t, t);
    trn_feats = my_rep(output);
    err(i) = prcrossval(tst_feats,clsf,folds,iters);
    i = i + 1;
end
