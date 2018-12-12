function [output] = transform_images(A)
    temp = A;

    b = [];

    for n = 1:10
        r_transform = -.5 + (.5+.5)*rand(1,1)
        r_rotate = -.25 + (.25+.25)*rand(1,1)
        r = [1 0 0; r_transform 1 0; 0 0 1];
        tform = maketform('affine',r);
        temp = A*mapm('imtransform', tform);
        temp = im_rotate(temp, r_rotate);
        b = [b; temp];
    end
    
    output = [A; b]
end

