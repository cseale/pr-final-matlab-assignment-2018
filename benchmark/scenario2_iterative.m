clc;
clear all;
close all;

errors=[];
transformation_limit = .5;

for i=1:10
    imgs=randi([1 1000], 1,10);
    fprintf('select random images');
    trn_set = prnist([0:9], imgs);
    trn_set = transform_images(trn_set, transformation_limit, transformation_limit);
    fprintf('augment dataset');
    trn_feats = my_rep(trn_set);
    fprintf('Feature extracted.');
    w = scalem([],'variance')*pcam([],0.8); %define
    mapping = trn_feats*w; %mapping
    new_trn = mapping(trn_feats); %mapped dataset
    [clsf, k, e] = knnc(new_trn, 3); % trained classifier
    fprintf("Classifier trainied");
    err = nist_eval('my_rep', mapping*clsf, 100);
    errors=[errors err];
    fprintf("Evaluation Completed");
end

mean(errors)
std(errors)

save('scenario2iterative.mat');

fprintf('all done');
