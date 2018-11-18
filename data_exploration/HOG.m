%% HOG

% Hog is sensible to image orientation -> we need to find a way to rotate
% images.

images = prnist([7],[1]);



for i=1:length(images)
    im = data2im(images(i));
    [hog1, visualization] = extractHOGFeatures(im);
    figure(i);
    subplot(1,2,1);
    imshow(im);
    subplot(1,2,2);
    plot(visualization);
end


img = data2im(images);
% Extract HOG features and HOG visualization
[hog_4x4, vis4x4] = extractHOGFeatures(img,'CellSize',[2 2]);
[hog_4x4, vis4x4] = extractHOGFeatures(img,'CellSize',[4 4]);

% Show the original image
figure; 
subplot(2,2,1:2); imshow(img);

% Visualize the HOG features
subplot(2,2,3);  
plot(vis4x4); 
title({'CellSize = [2 2]'; ['Length = ' num2str(length(hog_4x4))]});

subplot(2,2,4);
plot(vis4x4); 
title({'CellSize = [4 4]'; ['Length = ' num2str(length(hog_4x4))]});


%% HOG 2
cellSize = [4 4];
hogFeatureSize = length(hog_4x4);

images = prnist([1],[1:10]);


numImages = length(images);
trainingFeatures = zeros(numImages, hogFeatureSize, 'single');

for i = 1:numImages
    img = data2im(images(i));    
    
    trainingFeatures(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);  
end

trainingLabels = zeros(numImages, 1);








%% perform image conversion and visualize HOGs
clear;
close all;
clc;
prwaitbar off;

a = prnist([0:3],[1]);
figure(1)
show(a);

%preproc = im_box([],0,1)*im_rotate*im_resize([],[128 128])*im_box([],1,0);
preproc = im_box([],0,1)*im_resize([],[32 32])*im_box([],1,0);
a = a*preproc;
pr_a = prdataset(a);

figure(2);
%show(a);

%features = im_features(a, a, 'all');

for i=1:length(a)
    im = data2im(a(i));help 
    [hog_4x4, vis4x4] = extractHOGFeatures(im,'CellSize',[4 4]);
    figure(i);
    subplot(1,2,1);
    imshow(im);
    subplot(1,2,2);
    plot(vis4x4);
end

%% test with the classifier, following https://it.mathworks.com/help/vision/examples/digit-classification-using-hog-features.html
clear;
close all;
clc;
prwaitbar off;

a = prnist([0:4],[1:2]);
%figure(1)
%show(a);

%preproc = im_box([],0,1)*im_rotate*im_resize([],[128 128])*im_box([],1,0);
preproc = im_box([],0,1)*im_resize([],[32 32])*im_box([],1,0);
a = a*preproc;
pr_a = prdataset(a);

[hog_4x4, vis4x4] = extractHOGFeatures(data2im(a(1)),'CellSize',[4 4]);
cellSize = [4 4];
hogFeatureSize = length(hog_4x4);

% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.

numImages = length(a);
trainingFeatures = zeros(numImages, hogFeatureSize, 'single');

for i = 1:numImages
    img = data2im(a(i));    
    trainingFeatures(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);  
end

trainingLabels = getfield(struct(pr_a), "nlab")-1;

for i=1:10
    subplot(4,3,i); plot(trainingFeatures(i, :));
    title(trainingLabels(i));
end

