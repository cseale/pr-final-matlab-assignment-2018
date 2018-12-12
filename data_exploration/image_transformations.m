clear;
close all;

% load data file
samples = prnist([0:9],[1:100:1000]);

post = transform_images(samples);
