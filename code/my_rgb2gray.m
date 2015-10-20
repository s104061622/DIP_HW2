function [ y ] = my_rgb2gray( image )

for i = 1:size(image,1)
    for j = 1:size(image,2)
        y(i,j) = 0.299 * image(i,j,1) + 0.587 * image(i,j,2) + 0.114 * image(i,j,3);
    end
end

end

