function AL = alignLeaf( I, X, Y)
% ALIGNLEAF aligns a binary leaf, I, provided the base-point coordinate X 
%   and Y.
%
% PARAMETERS:
%       I = a binary leaf image
%       X = x-coordinate of the base-point of binary leaf I
%       Y = y-coordinate of the base-point of binary leaf I
%
% OUTPUT:
%       AL = The horizontally aligned binary leaf with its base-point on 
%       the left.
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

% Get the boundary of the leaf using X and Y
boundary = getBoundary(I,X,Y);

% Get the Base-point Contour Distance vector
dist = getDistanceVector(boundary, X, Y);  

% Find the furthest point (tip of the leaf)
[r c] = size(dist);
maxD = dist(1,1);
max_index = 1;
for i = 1:r
    if maxD < dist(i,1)
        maxD = dist(i,1);
        max_index = i;
    end
end      
mx = boundary(max_index,1);
my = boundary(max_index,2);

% Find out the inclination of the line connecting base-point and tip
u = x - mx;
v = y - my;

angle = (180/pi)*atan(abs(u/v));

% Based on the orientation of the leaf correct the angle
% so the base-point is on the left after rotation.


if u < 0 && v < 0 %04:30
    angle = angle + 0;
end

if u > 0 && v > 0 %10:30
    angle = angle + 180;
end

if u > 0 && v < 0 %01:30
    angle = 0 - angle;
end

if u < 0 && v > 0 %07:30
    angle = 180 - angle;
end

if u == 0 && v < 0 %03:00
    angle = 0;
end

if u == 0 && v > 0 %09:00
    angle = 180;
end

if u > 0 && v == 0 %12:00
    angle = -90;
end

if u < 0 && v == 0 %06:00
    angle = 90;
end

% Rotate the leaf
R = imrotate(I, angle);    

% Crop the leaf
P = regionprops(R,'Image');

AL = P.Image;

end