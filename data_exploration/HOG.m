%% HOG visualization

% Hog is sensible to image orientation -> we need to find a way to rotate
% images.

image = prnist([0],[1]);
preproc = im_box([],0,1)*im_resize([],[24 24])*im_box([],1,0);
image = image*preproc;

img = data2im(image);
% Extract HOG features and HOG visualization
[hog2x2, vis2x2] = extractHOGFeatures(img,'CellSize',[2 2]);
[hog4x4, vis4x4] = extractHOGFeatures(img,'CellSize',[8 8]);

% Show the original image
figure; 
subplot(2,2,1:2); imshow(img);

% Visualize the HOG features
subplot(2,2,3);  
plot(vis2x2); 
title({'CellSize = [2 2]'; ['Length = ' num2str(length(hog2x2))]});

subplot(2,2,4);
plot(vis4x4); 
title({'CellSize = [4 4]'; ['Length = ' num2str(length(hog4x4))]});



%% Test svc classifier
clear;
close all;
clc;
prwaitbar off;

digits = prnist([0:9],[1:20]);

preproc = im_box([],0,1)*im_resize([],[32 32])*im_box([],1,0);
a = digits*preproc;

% this is done once to get the length of the generated features
cellSize = [4 4]; % [2 2] seems to yield the best result (still to verify) but it takes too much for the training
[hog, vis] = extractHOGFeatures(data2im(a(1)),'CellSize',cellSize);
hogFeatureSize = length(hog);

% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.
numImages = length(a);
trainingFeatures = zeros(numImages, hogFeatureSize);

for i = 1:numImages
    img = data2im(a(i));    
    trainingFeatures(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);  
end

trainingLabels = getlabels(digits);
pr_a = prdataset(trainingFeatures, trainingLabels);

w = svc(pr_a);

%create test set
test_digits = prnist([0:9],[21])*preproc;
show(test_digits);
numTestImages = length(test_digits);
testFeatures = zeros(numTestImages, hogFeatureSize);

for i = 1:numTestImages
    img = data2im(test_digits(i));    
    testFeatures(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);  
end
testLabels = getlabels(test_digits);
pr_tst = prdataset(testFeatures, testLabels);

res = w(pr_tst);

testLabels'
labeld(res)