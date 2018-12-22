% MY_REP returns the prdataset with the extracted HOG features
% a = my_rep(m) returns the resulting dataset a from the NIST prdatafile m
% 
% m NIST prdatafile (the one we obtain from prnist)
% a processed dataset after the HOG feature extraction
% 
% NOTE that the dimension reduction with pca is done in this function
% so if you want to change parameters of pca reduction you should do it
% in this function.


function a=my_rep(m)
design_set = m

if (isa(m, 'prdatafile'))
    preproc = im_box([],0,1)*im_resize([],[24 24], 'bicubic')*im_box([],1,0);
    design_set = m*preproc;
end

% this is done once to get the length of the generated features
cellSize = [4 4];

% convert to prdataset
design_set = prdataset(design_set);
imgs = data2im(design_set);

[hog, vis] = extractHOGFeatures(imgs(:,:,1,1),'CellSize',cellSize);
hogFeatureSize = length(hog);

% Loop over the trainingSet and extract HOG features from each image. A
% similar procedure will be used to extract features from the testSet.
numImages = size(imgs, 4);
features = zeros(numImages, hogFeatureSize);
for i = 1:numImages
    img = imgs(:,:,1,i);
    features(i, :) = extractHOGFeatures(img, 'CellSize', cellSize);
end

labels = getlabels(m);
a = prdataset(features, labels);
end