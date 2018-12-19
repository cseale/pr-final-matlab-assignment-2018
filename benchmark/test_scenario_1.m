clc;
clear all;
close all;

trn_set = prnist([0:9],[1:1000]);
trn_feats = my_rep(trn_set);

w = scalem([],'variance')*pcam([],0.9); %define
mapping = trn_feats*w; %mapping
new_trn = mapping(trn_feats); %mapped dataset
clsf = knnc(new_trn,3); % trained classifier

err = nist_eval('my_rep', mapping*clsf, 100);