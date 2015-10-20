function output = my_imfilter(image, filter)
% This function is intended to behave like the built in function imfilter()
% See 'help imfilter' or 'help conv2'. While terms like "filtering" and
% "convolution" might be used interchangeably, and they are indeed nearly
% the same thing, there is a difference:
% from 'help filter2'
%    2-D correlation is related to 2-D convolution by a 180 degree rotation
%    of the filter matrix.

% Your function should work for color images. Simply filter each color
% channel independently.

% Your function should work for filters of any width and height
% combination, as long as the width and height are odd (e.g. 1, 7, 9). This
% restriction makes it unambigious which pixel in the filter is the center
% pixel.

% Boundary handling can be tricky. The filter can't be centered on pixels
% at the image boundary without parts of the filter being out of bounds. If
% you look at 'help conv2' and 'help imfilter' you see that they have
% several options to deal with boundaries. You should simply recreate the
% default behavior of imfilter -- pad the input image with zeros, and
% return a filtered image which matches the input resolution. A better
% approach is to mirror the image content over the boundaries for padding.

% % Uncomment if you want to simply call imfilter so you can see the desired
% % behavior. When you write your actual solution, you can't use imfilter,
% % filter2, conv2, etc. Simply loop over all the pixels and do the actual
% % computation. It might be slow.
% % output = imfilter(image, filter);


[ r_im c_im ] = size(image);
[ r_fltr c_fltr ] = size(filter);
r_fltr
c_fltr
modi_im = zeros(r_im + r_fltr - 1, c_im + c_fltr - 1);
output = zeros(r_im, c_im);

    
for i = 1:size(modi_im,1)
    for j = 1:size(modi_im,2)
        if (i == 1) && (j == 1)
            modi_im(i,j) = image(i,j);
        elseif (i == 1) && (j >= 2) && (j <= size(image,2) + 1)
            modi_im(i,j) = image(i,j-1);
        elseif (i == 1) && (j == size(modi_im,2))
            modi_im(i,j) = image(i,j-2);
            
        elseif (i >= 2) && (i <= size(image,1) + 1) && (j == 1)
            modi_im(i,j) = image(i-1,j);
        elseif (i >= 2) && (i <= size(image,1) + 1) && (j >= 2) && (j <= size(image,2) + 1)
            modi_im(i,j) = image(i-1,j-1);
        elseif (i >= 2) && (i <= size(image,1) + 1) && (j == size(modi_im,2))
            modi_im(i,j) = image(i-1,j-2);    
            
        elseif (i == size(modi_im,1)) && (j == 1)
            modi_im(i,j) = image(i-2,j);
        elseif (i == size(modi_im,1)) && (j >= 2) && (j <= size(image,2) + 1)
            modi_im(i,j) = image(i-2,j-1);
        else
            modi_im(i,j) = image(i-2,j-2);
        end
    end
end
    
%     modi_R_im = padarray(R_im, [ (r_fltr-1)/2 (c_fltr-1)/2 ], 'symmetric', 'both');
%     modi_G_im = padarray(G_im, [ (r_fltr-1)/2 (c_fltr-1)/2 ], 'symmetric', 'both');
%     modi_B_im = padarray(B_im, [ (r_fltr-1)/2 (c_fltr-1)/2 ], 'symmetric', 'both');
    
    for i = 1:size(image,1)
        for j = 1:size(image,2)
            output(i,j) = sum(sum(modi_im(i:i+r_fltr-1, j:j+c_fltr-1).*filter));
        end
    end
end


 
 
 

    


    





