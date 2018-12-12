%% test scenario 2

clear;
close all;
clc;
prwaitbar on;

imgs=randi([1 1000], 1,10)

digits = prnist([0:9], imgs);
preproc = im_box([],0,1)*im_resize([],[24 24], 'bicubic')*im_box([],1,0);
design_set = digits*preproc;

% this is done once to get the length of the generated features
cellSize = [8 8];
[hog, vis] = extractHOGFeatures(data2im(design_set(1)),'CellSize',cellSize);
hogFeatureSize = length(hog);

% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.
numImages = length(design_set);
features = zeros(numImages, hogFeatureSize);
for i = 1:numImages
    img = data2im(design_set(i));    
    features(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);  
end

labels = getlabels(digits);
a = prdataset(features, labels);

%[err,b] = prcrossval(a,svc,50, 2);

hog_svc_sc2 = svc(a);