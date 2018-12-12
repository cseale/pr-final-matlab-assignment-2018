clc;
clear all;
close all;

errors=[];
im_chosen=[];

for i=1:10
    imgs=randi([1 1000], 1,10);
    im_chosen=[im_chosen; imgs];
    trn_set = prnist([0:9], imgs);
    trn_feats = my_rep2(trn_set);
    w = svc(trn_feats);
    err = nist_eval('my_rep2', w, 100);
    errors=[errors err];
end
