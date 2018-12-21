clc;
clear all;
close all;

trn_set = prnist([0:9],[1:1000]);
trn_feats = my_rep(trn_set);
fprintf("Feature extracted.");
w = scalem([],'variance')*pcam([],0.9); %define
mapping = trn_feats*w; %mapping
new_trn = mapping(trn_feats); %mapped dataset
[clsf, k, e] = knnc(new_trn); % trained classifier

err = nist_eval('my_rep', mapping*clsf, 100);

% clsf = knnc(trn_feats, 3);
% fprintf("Classifier trained.");
% err = nist_eval('my_rep', clsf, 100);
fprintf("Done.");

save('trn_feats_4x4_bic', 'trn_feats')