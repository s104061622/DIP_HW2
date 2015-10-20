function [ f ] = my_fgauss( sigma )
%MY_FGAUSS Summary of this function goes here
%   Detailed explanation goes here

      hsize = [3, 3];
      h1 = hsize (1)-1; h2 = hsize (2)-1; 
      [x, y] = meshgrid(0:h2, 0:h1);
      x = x-h2/2; y = y-h1/2;
      gauss = exp( -( x.^2 + y.^2 ) / (2*sigma^2) );
      f = gauss / sum (gauss (:));


end

