% Multi zone algorithm
% author: M. Pocchiari
%
% A NxN image is divided into smaller sub-images and for each the proportion of black and white is calculated and then used
% as a feature in the feature vector. The number of configuration is scalable in the sense that the numbers in the conf vector
% determine in how many different parts the image should be divided in both directions.
%
% For details: 
% - https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=4&ved=2ahUKEwid25e7193eAhWqsaQKHWjYCiUQFjADegQICBAC&url=https%3A%2F%2Fpdfs.semanticscholar.org%2F1062%2Fbab70ae84adb250ac5dafe2be98fa8fe7a69.pdf&usg=AOvVaw0CeYfEsWf0be8ljvAfZWeE
% - https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=1&ved=2ahUKEwibpK7H-93eAhVCsaQKHcxNDkwQFjAAegQIABAC&url=https%3A%2F%2Fpdfs.semanticscholar.org%2F0020%2F45129a9b687f551e0c30f47581b09a19a0b2.pdf&usg=AOvVaw0HmE72Rt4XUjh-BnC3nz_Y

prwaitbar off

% load data file
a = prnist([0:9],[1:100:1000]);

% matrix of possible configurations of zones to be detected
conf=[4 4 ; 4 1 ; 8 8];

% total number of features
sum = 0;
for i = 1:size(conf,1)
    row_prod = conf(i,1)*conf(i,2);
    sum = sum + row_prod;
end

% creating a matrix to contain all the feature for all the selected images
feat_space = zeros(size(a,1),sum);

for cnt_img=1:size(a,1) 
    %PREPROCESSING
    % take image
    a1 = a(cnt_img);
    % resize image, pad the end with zeros if needed
    a1 = a1*im_box(0,1);
    a1 = a1*im_resize([32 32]);
    % convert to matrix
    im = data2im(a1);
    cnt_feat=1; %counter to keep track of the numbers of feature
    for cnt_i = 1:size(conf,1) % cycle to inspect all conf vector
        rows_sub_im = 32/conf(cnt_i,1); % number of row the sub image should have
        cols_sub_im = 32/conf(cnt_i,2); %number of columns the sub image should have
        for i = 1:rows_sub_im:32
            for j = 1:cols_sub_im:32
                row_extract = i:i+rows_sub_im-1; % rows of original image to use in the extraction phase sub_mat
                col_extract = j:j+cols_sub_im-1; % columns of original image to use in the extraction phase sub_mat
                sub_mat = im([row_extract],[col_extract]); % sub matrix extracted
                perc = nnz(sub_mat)/(size(sub_mat,1)*size(sub_mat,2));
                feat_space(cnt_img,cnt_feat) = perc;
                cnt_feat = cnt_feat + 1;
            end
        end
    end
end

data = prdataset(feat_space,getlab(a));
