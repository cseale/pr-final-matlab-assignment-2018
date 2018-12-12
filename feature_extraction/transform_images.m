function [output] = transform_images(A)
    a = A;

    b = [];

    for n = -0.5:0.1:0.5
        a = im_rotate(A, n);
        b = [b; a];
    end
    
    output = b
end

