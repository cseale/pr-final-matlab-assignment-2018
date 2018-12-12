clc;
clear all;
close all;

trn_set = prnist([0:9],[1:1000]);
trn_feats = my_rep(trn_set);
w = knn(trn_feats,3);

err = nist_eval('my_rep', w, 100);