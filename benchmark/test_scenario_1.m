clc;
clear all;
close all;

trn_set = prnist([0:9],[1:1000]);
trn_feats = my_rep(trn_set);
fprintf("Features extracted.\n");
w = scalem([],'variance')*pcam([],0.8); %define (0.8 is the best value)
mapping = trn_feats*w; %mapping
new_trn = mapping(trn_feats); %mapped dataset
clsf = knnc(new_trn, 3); % trained classifier
fprintf("Classifier trained.\n");
err = nist_eval('my_rep', mapping*clsf, 100);
fprintf("Done.\n");

% clsf = knnc(trn_feats, 3);
% err = nist_eval('my_rep', clsf, 100);

%save('trn_feats_4x4_bic', 'trn_feats')