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

% load data file
a = prnist([0:9],[1:40:1000]);

% take first image
a1 = a(1);
% resize image, pad the end with zeros if needed
a1 = a1*im_box(0,1)
a1 = a1*im_resize([32 32])
% convert to matrix
i = data2im(a1);

% first count from top and zero out rows where there are no non-zero value
[sel_top, ind_top] = max(i, [], 1);
results_top = sel_top .* ind_top;

% distance profile from bottom
[sel_bottom, ind_bottom] = max(flip(i), [], 1);
results_bottom = sel_bottom .* ind_bottom;

% distance profile from left
[sel_left, ind_left] = max(i, [], 2);
results_left = (sel_left .* ind_left)';

% distance profile from right
[sel_right, ind_right] = max(flip(i, 2), [], 2);
results_right = (sel_right .* ind_right)';

% create resulting distance profile
dist_profile = [results_top results_left results_bottom results_right];

plot(dist_profile)



