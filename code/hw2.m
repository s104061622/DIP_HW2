clc;clear;close all;
input_im = imread('../data/input_image_2.bmp');
J = rgb2gray(input_im);
K = histeq(J);
width = size(J,1);
height = size(J,2);

for i = 1:size(J,1)
    for j = 1:size(J,2)
        L(i,j,1) = K(i,j,1) - J(i,j,1);
        output_im(i,j,1) = input_im(i,j,1) + L(i,j,1);
        output_im(i,j,2) = input_im(i,j,2) + L(i,j,1);
        output_im(i,j,3) = input_im(i,j,3) + L(i,j,1);
    end
end

imshow(output_im);
output_im = rgb2hsv(output_im);
output_im(:,:,2) = output_im(:,:,2) * 3;
output_im = hsv2rgb(output_im);

figure, imshow(input_im)
figure, imshow(output_im);

imwrite(output_im, 'output_image.bmp');