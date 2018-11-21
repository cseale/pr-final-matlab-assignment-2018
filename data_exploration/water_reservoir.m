% water resevoir method
% author: Colm Seale

% Exploration of Water Resevoir method
addpath('../feature_extraction/');

clear;
close all;

% load data file
a = prnist([0:9],[1:40:1000]);

% take first image
a9 = a(250);
% resize image, pad the end with zeros if needed
a9 = a9*im_box(0,1)
a9 = a9*im_resize([32 32])
% convert to matrix
i = data2im(a9);

% one option, drop fall algorithm where we similuate one moving region
% moving in a direaction, repeat until images converge
