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

% Exploration of Water Resevoir method
addpath('../feature_extraction/');

% load data file
a = prnist([0:9],[1:40:1000]);

% take first image
a1 = a(1);
% resize image, pad the end with zeros if needed
a1 = a1*im_box(0,1)
a1 = a1*im_resize([32 32])
% convert to matrix
i = data2im(a1);
% calculate the distance profile
dist_profile = distance_profile(i);

plot(dist_profile)



