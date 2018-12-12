clc;
clear all;
close all;

trn_set = prnist([0:9], [1:10]);
trn_set = transform_images(trn_set);
show(trn_set);
pause;
trn_feats = my_rep2(trn_set);
w = svc(trn_feats);

err = nist_eval('my_rep2', w, 100);