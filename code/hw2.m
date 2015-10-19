clc;clear;close all;
input_im = imread('../data/input_image_4.bmp');
my_gray_input = my_rgb2gray(input_im);
figure, imshow(my_gray_input), title('1. Original Image (Grayscale)');
log_gray_input = log(double(my_gray_input + 1));
PQ = paddedsize(size(log_gray_input));
F = fft2(log_gray_input,PQ(1),PQ(2));
figure, imshow(fftshift(F), [0 1000]);
Hp = (1 - lpfilter('gaussian', PQ(1), PQ(2), 100)) + 10;
figure, imshow(fftshift(Hp), [ ]);
Gp = Hp.*F;
figure, imshow(fftshift(Gp), [0 1000]);
gp = real(ifft2(Gp));
gpc = gp(1:size(log_gray_input,1), 1:size(log_gray_input,2));
figure, imshow(gpc, [ ]), title('Homomorphic filter');
figure, imhist(gpc,64);


he_input = histeq(gpc,64);
he_input = adapthisteq(my_gray_input,'ClipLimit',0.01,'NBins',1024,'Distribution','rayleigh');
% he_input = imadjust(gpc,[0 0.2],[ ],0.3);
figure, imhist(he_input,65536);
figure, imshow(he_input), title('2. Enhance Contrast Using Histogram Equalization');

PQ = paddedsize(size(he_input));
F = fft2(he_input,PQ(1),PQ(2));
Hp = lpfilter('gaussian', PQ(1), PQ(2), 200);
Gp = Hp.*F;
gp = real(ifft2(Gp));
g_blurred_im = gp(1:size(he_input,1), 1:size(he_input,2));
figure, imshow(g_blurred_im), title('3. 2-D Gaussian Filtering of 2.');

% sharpen_input_im = imsharpen(gray_input, 'Radius', 1, 'Amount', 2);
% figure, imshow(sharpen_input_im), title('4. Sharpening Input Image');
% edge_input_im = sharpen_input_im - gray_input;
% figure, imshow(edge_input_im),;
% edge_im_b = edge(gray_input,'Canny');
% figure, imshow(edge_im_b), title('4. Edge of Input Image (Logical)');
% 
% edge_im_d = double(edge_im_b);
% edge_im = edge_im_d .* he_input;
% figure, imshow(edge_im), title('5. Edge of 2. (Double)');

% for i = 1:size(g_blurred_im,1)
%     for j = 1:size(g_blurred_im,2)
%         if (edge_im(i,j) == 0)
%             modi_im(i,j) = g_blurred_im(i,j);
%         else
%             modi_im(i,j) = edge_im(i,j);
%         end
%     end
% end
% figure, imshow(modi_im), title('6. Combining 3. and 5.');


output_im = input_im;
for i = 1:size(my_gray_input,1)
    for j = 1:size(my_gray_input,2)
        weight(i,j,1) = he_input(i,j,1) / double(my_gray_input(i,j,1) + 1);
        output_im(i,j,1) = input_im(i,j,1) * weight(i,j,1);
        output_im(i,j,2) = input_im(i,j,2) * weight(i,j,1);
        output_im(i,j,3) = input_im(i,j,3) * weight(i,j,1);
    end
end


% output_im = rgb2hsv(input_im);
% output_im(:,:,3) = gpc(:,:) * 1;
% output_im(:,:,2) = output_im(:,:,2) * 1;
% output_im = hsv2rgb(output_im);

figure, imshowpair(input_im, output_im, 'montage'), title('Input Image vs. Output Image');
imwrite(output_im, 'output_image.bmp');