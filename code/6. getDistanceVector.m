function DV = getDistanceVector(contour, x, y)
% GETDISTANCEVECTOR calculates the distances of all the points in the
% contour vector from the point (x,y), then returns the distance vector.
%
% PARAMETERS:
%       contour = the coordinates of the boundary pixels of a leaf
%       x = x-coordinate of the reference point to compute distance from
%       y = y-coordinate of the reference point to compute distance from
%
% OUTPUT:
%       DV = the coordinates of the boundary pixels of the binary
% leaf I
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

% Get the size of contour matrix
[r c] = size(contour);

% Initialize distance vector
d = zeros(r,1);

% Calculate the distances of all the countour points from the point (x,y)
for i = 1:r
    x1 = contour(i,1);
    y1 = contour(i,2);
    dist = sqrt((x - x1)^2 + (y - y1)^2);        
    d(i,1) = dist;
end

% Find the maximum distance
maxDist = max(d);

% Normalize the distances by dividing all of them by the max distance
for i = 1:r                
    d(i,1) = d(i,1)/maxDist;
end

DV = d;
end