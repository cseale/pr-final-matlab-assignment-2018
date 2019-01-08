%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Generate Dataset
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;

D = '../custom_images';
S = dir(fullfile(D,'digit*.png')); % pattern to match filenames.

images = {};
labels = [];

for k = 1:numel(S)
    F = fullfile(D,S(k).name);
    I = imread(F);
    I = rgb2gray(I);
    I = imbinarize(I);
    I = remove_white_space(I);
    I = I == 0;
    
    % generate squares
    l = size(I,1);
    w = size(I,2);
    len = round(abs((l - w)/2));
    
    if (l > w) 
        I = padarray(I,[0 len],0,'both');
    else
        I = padarray(I,[len 0],0,'both');
    end
    I = imresize(I, [24 24])
    images = [images; I]; % optional, save data.
    labels = [labels; S(k).name(1:7)];
end

load('trn_feats_4x4_bic.mat')

live_tst = prdataset(im2obj(images), labels);
live_tst_feats = my_rep(live_tst);

confmat(live_tst_feats*mapping*clsf)
testc(live_tst_feats*mapping*clsf)



