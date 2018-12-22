function [output] = transform_images(A, rot, transf)
    preproc = im_box([],0,1)*im_resize([],[24 24])*im_box([],1,0);

    output = [];

    for n = 1:10
        temp = A;
        r_transform = -transf + (2*transf)*rand(1,1)
        r_rotate = -rot + (2*rot)*rand(1,1)
        r = [1 0 0; r_transform 1 0; 0 0 1];
        tform = maketform('affine',r);
        temp = im_rotate(temp, r_rotate);  
        temp = mapm(temp, 'imtransform', tform)*preproc;
        output = [output; prdataset(temp)];
    end
end