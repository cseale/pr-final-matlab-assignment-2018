% MY_REP2 returns the prdataset with the extracted HOG features
% a = my_rep(m) returns the resulting dataset a from the NIST prdatafile m
% 
% m NIST prdatafile (the one we obtain from prnist)
% a processed dataset after the HOG feature extraction
% 
% NOTE that the dimension reduction with pca is done in this function
% so if you want to change parameters of pca reduction you should do it
% in this function.


function a=my_rep2(m)
preproc = im_box([],0,1)*im_resize([],[24 24], 'bicubic')*im_box([],1,0);
design_set = m*preproc;


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

labels = getlabels(m);
a = prdataset(features, labels);

% [w, frac] = pcam(a, 100);
% a_pca = a*w;
end