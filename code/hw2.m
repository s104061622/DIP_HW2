clc;clear;close all;
input_im = imread('../data/input_image_1.bmp');
J = rgb2gray(input_im);
% figure, imhist(J,64);
K = histeq(J);
% figure, imhist(K,64);

for i = 1:size(J,1)
    for j = 1:size(J,2)
        L(i,j,1) = K(i,j,1) - J(i,j,1);
        output_im(i,j,1) = input_im(i,j,1) + L(i,j,1);
        output_im(i,j,2) = input_im(i,j,2) + L(i,j,1);
        output_im(i,j,3) = input_im(i,j,3) + L(i,j,1);
    end
end

figure, imshow(output_im);
output_im = rgb2hsv(output_im);
output_im(:,:,2) = output_im(:,:,2) * 2;
output_im = hsv2rgb(output_im);
sharpen = imsharpen(output_im);
for i = 1:size(sharpen,1)
    for j = 1:size(sharpen,2)
        unsharpen(i,j,1) = sharpen(i,j,1) - input_im(i,j,1);
        unsharpen(i,j,2) = sharpen(i,j,2) - input_im(i,j,2);
        unsharpen(i,j,3) = sharpen(i,j,3) - input_im(i,j,3);
    end
end
output_im = imgaussfilt(output_im, 2);

figure, imshow(input_im)
figure, imshow(sharpen)
figure, imshow(unsharpen)
figure, imshow(output_im);

imwrite(output_im, 'output_image.bmp');