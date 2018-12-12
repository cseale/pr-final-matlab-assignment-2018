clc;
clear all;
close all;

trn_set = prnist([0:9], [1:10]);
trn_set = transform_images(trn_set);
trn_feats = my_rep2(trn_set);
w = knnc(trn_feats, 3);
err = nist_eval('my_rep2', w, 100);



% 16.10 with transform(.5, .5), 4 4, knnc3 [31:40]
% 18.10 without transform(.5, .5), 4 4, knnc3 [31:40]

% 14.5 with transform(.5, .5), 4 4, knnc3 [1:10]
% 14.5 with transform(.7, .7), 4 4, knnc3 [1:10]
% 14.5 with transform(1, 1), 4 4, knnc3 [1:10]