clc;
clear all;
close all;

trn = prnist([0:9],[1]);
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
    w = trn_feats*clsf;
    err(i) = tst_feats*w*testc;
    i = i + 1;
end

save('transformation_err_curves.mat')


plot(transformations(1:end-1), err(1:end-1))
title('Error Curve for Transformation')
xlabel('Transformation')
ylabel('Classification Error')