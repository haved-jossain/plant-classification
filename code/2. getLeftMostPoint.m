function [x y] = getLeftMostPoint( image )
% GETLEFTMOSTPOINT returns the left most point of the binary input image.
%
% PARAMETERS:
%       image = a binary leaf image
%
% OUTPUT:
%       x = x-coordinate of the left most point of binary leaf I
%       y = y-coordinate of the left most point of binary leaf I
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

% Initialize the coordinates of the left most point
x = -1;
y = -1;

[height width] = size(image);

% Start checking from the left most column of the image and return the 
% coordinates of the white(1) pixel that is found first.
for c = 1:width
    for r = 1:height
     if( image(r,c)==1 )
         x = r;
         y = c;
         return;
     end;
   end;       
end;
    
end