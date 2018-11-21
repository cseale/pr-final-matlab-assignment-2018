% distance_profile.m
% author: Colm Seale
% 
% Exploration of Distance Profiles
% From each side of the image, count the distance to the first non-zero
% value in the matrix, from top, bottom, left and right
%
% See
% https://www.researchgate.net/publication/267367611_Comparative_Recognition_of_Handwritten_Gurmukhi_Numerals_Using_Different_Feature_Sets_and_Classifiers
% for details
clear;
close all;

% Exploration of Distance Profile
addpath('../feature_extraction/');

% load data file
a = prnist([0:9]);

% resize image, pad the end with zeros if needed
a = a*im_box(0,1)
a = a*im_resize([32 32])
% convert to matrix
img = data2im(a);
% calculate the distance profile for all images
dist_profile =  cell2mat(arrayfun(@(x) distance_profile(cell2mat(x)), img, 'un',0)');

% convert to pr dataset
b = prdataset(dist_profile, getlab(a));

[test, train, idx_test, idx_train] = gendat(b, 24, 1);

prcrossval(b, svc, 10, 1);

% w = svc(train);
% 
% testc(train, w);
% confmat(w(test));


