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

digits = prnist([0:9],[1:190]);

preproc = im_box([],0,1)*im_resize([],[32 32], 'bicubic')*im_box([],1,0);
a = digits*preproc;


features = im_features(a, a, 'all');


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
test_digits = prnist([0:9],[191:200])*preproc;
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

confmat(res);
testc(pr_tst, w)


%% TEST svc with HOG features -> error: 0.0460
clear;
close all;
clc;
prwaitbar on;

digits = prnist([0:9], [1:100]);
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

[w, frac] = pcam(a, 700);
a_pca = a*w;

[SvcERR,SvcCERR,SvcNLAB_OUT] = prcrossval(a_pca,svc,10, 1); %0.05 without PCA, 0.0260 with PCA(150)
[QdcERR,QdcCERR,QdcNLAB_OUT] = prcrossval(a_pca,qdc,10, 1); % , 0.1870 with PCA(50)
[LdcERR,LdcCERR,LdcNLAB_OUT] = prcrossval(a_pca,ldc,10, 1); % 0.0410 without PCA, 0.0320 PCA(150), 
[FisherERR,FisherCERR,FisherNLAB_OUT] = prcrossval(a_pca,fisherc,10, 1); % 0.055 without PCA, 0.0360 PCA(150), 
[LogERR,LogCERR,LogNLAB_OUT] = prcrossval(a,logmlc,10, 1); % shit


[ParzERR,ParzCERR,ParzNLAB_OUT] = prcrossval(a_pca,parzenc,10, 1); % 0.0270 without PCA, 0.0250 with PCA(150) 
[nn3ERR,nn3CERR,nn3NLAB_OUT] = prcrossval(a,knnc([],3),10, 1); % 0.0240 without PCA, 
[nn4ERR,nn4CERR,nn4NLAB_OUT] = prcrossval(a_pca,knnc([],4),10, 1); % 0.0190 PCA(700), 
[nn5ERR,nn5CERR,nn5NLAB_OUT] = prcrossval(a_pca,knnc([],5),10, 1); % 0.0220 without PCA, 0.0210 PCA(150), 


%% TEST bicubic + HOG[4 4] + (?PCA?) + knn(3,4,5)
clear;
close all;
clc;
prwaitbar on;

digits = prnist([0:9], [1:200]);
preproc = im_box([],0,1)*im_resize([],[24 24], 'bicubic')*im_box([],1,0);
design_set = digits*preproc;

% this is done once to get the length of the generated features
cellSize = [4 4];
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

% without PCA
noPcaErr = [];
for i = 1:3
    [err,b] = prcrossval(a,knnc([],i+2),25, 5);
    fprintf("%dnn: Error: %d - Std: %d\n", i+2, err, b);
    noPcaErr = [noPcaErr err];
end

%with PCA
pca_values = [100 200 300 400 500 600 700 800];
for i=1:length(pca_values)
    value = pca_values(i);
    [w, frac] = pcam(a, value);
    a_pca = a*w;
    knn = 3;
    [err,b] = prcrossval(a_pca,knnc([],knn),25, 5);
    fprintf("PCA %d -> %dnn: Error: %d - Std: %d\n",value, knn, err, b);
end

%% best one
clear;
close all;
clc;
prwaitbar on;

digits = prnist([0:9], [1:1000]);
preproc = im_box([],0,1)*im_resize([],[24 24], 'bicubic')*im_box([],1,0);
design_set = digits*preproc;

% this is done once to get the length of the generated features
cellSize = [4 4];
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


a_pca = a*w;
[err,b] = prcrossval(a,knnc([],3),25, 5);
fprintf("PCA %d -> %dnn: Error: %d - Std: %d\n",value, knn, err, b);

classifier = knnc(a, 3);

%% test with pca
clear;
close all;
clc;
prwaitbar on;

cellSize = [4 4];


digits = prnist([0:9], [1:50]);
preproc = im_box([],0,1)*im_resize([],[24 24], 'bicubic')*im_box([],1,0);
design_set = digits*preproc;

% this is done once to get the length of the generated features
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

w = scalem([],'variance')*pcam([],0.9);

[err,b] = prcrossval(a,knnc([], 3),10,5);
[err_pca,b_pca] = prcrossval(a,w*knnc([], 3),10, 5);