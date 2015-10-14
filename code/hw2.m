clc;clear;close all;
input_im = imread('../data/input_image_3.bmp');
hsv_input = rgb2hsv(input_im);
gray_input = hsv_input(:,:,3);
figure, imhist(gray_input,65536);
figure, imshow(gray_input), title('1. Original Image (Grayscale)');
he_input = histeq(gray_input,65536);
% he_input = imadjust(gray_input,[], [], 0.5);
figure, imhist(he_input,65536);
figure, imshow(he_input), title('2. Enhance Contrast Using Histogram Equalization');
g_blurred_im = imgaussfilt(he_input,1);
figure, imshow(g_blurred_im), title('3. 2-D Gaussian Filtering of 2.');
% sharpen_input_im = imsharpen(gray_input, 'Radius', 1, 'Amount', 2);
% figure, imshow(sharpen_input_im), title('4. Sharpening Input Image');
% edge_input_im = sharpen_input_im - gray_input;
% figure, imshow(edge_input_im),;
edge_im_b = edge(gray_input);
figure, imshow(edge_im_b), title('4. Edge of Input Image (Logical)');
edge_im_d = double(edge_im_b);
edge_im = edge_im_d .* he_input;
figure, imshow(edge_im), title('5. Edge of 2. (Double)');
for i = 1:size(g_blurred_im,1)
    for j = 1:size(g_blurred_im,2)
        if (edge_im(i,j) == 0)
            modi_im(i,j) = g_blurred_im(i,j);
        else
            modi_im(i,j) = edge_im(i,j);
        end
    end
end
figure, imshow(modi_im), title('6. Combining 3. and 5.');


% for i = 1:size(gray_input,1)
%     for j = 1:size(gray_input,2)
%         weight(i,j,1) = modi_im(i,j,1) / gray_input(i,j,1);
%         output_im(i,j,1) = input_im(i,j,1) * weight(i,j,1);
%         output_im(i,j,2) = input_im(i,j,2) * weight(i,j,1);
%         output_im(i,j,3) = input_im(i,j,3) * weight(i,j,1);
% %    end
% %end
% 
% for i = 1:size(gray_input,1)
%    for j = 1:size(gray_input,2)
%        rgb2hsv(output_im(i,j,3)) = modi_im(i,j,1)
%    end
% end

output_im = rgb2hsv(input_im);
output_im(:,:,3) = modi_im(:,:);
output_im(:,:,2) = output_im(:,:,2) * 1;
output_im = hsv2rgb(output_im);

figure, imshowpair(input_im, output_im, 'montage'), title('Input Image vs. Output Image');
imwrite(output_im, 'output_image.bmp');