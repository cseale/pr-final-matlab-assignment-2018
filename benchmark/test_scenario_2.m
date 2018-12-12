clc;
clear all;
close all;

trn_set = prnist([0:9], [31:40]);
trn_feats = my_rep2(trn_set);
w = svc(trn_feats);

err = nist_eval('my_rep2', w, 100);