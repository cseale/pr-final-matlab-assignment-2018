function [output] = transform_images(A)
    temp = A;

    b = [];

    rot = 1;
    transf = 1;
    for n = 1:10
        r_transform = -transf + (2*transf)*rand(1,1)
        r_rotate = -rot + (2*rot)*rand(1,1)
        r = [1 0 0; r_transform 1 0; 0 0 1];
        tform = maketform('affine',r);
        temp = A*mapm('imtransform', tform);
        temp = im_rotate(temp, r_rotate);
        b = [b; temp];
    end
    
    output = [A; b]
end

