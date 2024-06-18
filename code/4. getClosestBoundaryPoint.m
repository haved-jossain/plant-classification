function [x y] = getClosestBoundaryPoint(I,X,Y)
% GETCLOSESTBOUNDARYPOINT Finds the closest point on the contour/boundary 
% of binary leaf I from the base-point (X,Y).
%
% PARAMETERS:
%       I = a binary leaf image
%       X = x-coordinate of the base-point of binary leaf I
%       Y = y-coordinate of the base-point of binary leaf I
%
% OUTPUT:
%       x = x-coordinate of the closest contour/boundary point from (X,Y)
%       y = y-coordinate of the closest contour/boundary point from (X,Y)
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

    % Get the left most point of binary leaf image I
    [x y] =  getLeftMostPoint(I);    
    
    % Get the boundary clockwise starting from (x,y)
    boundary = getBoundary(I,x,y);

    [r c] = size(boundary);
    
    % Calculate the distances of all the points on the border from the
    % point (x,y) and remember the point with minimum distance
    
    min_d = sqrt(( X - boundary(1,2) )^2 + ( Y - boundary(1,1) )^2);
    min_index = 1;
    for m = 2:r
        d = sqrt((X - boundary(m,2) )^2 + ( Y - boundary(m,1))^2);
        if d < min_d
            min_d = d;
            min_index = m;            
        end
    end

    % Store the x and y-coordinates of the closest point
    x = boundary(min_index,1);
    y = boundary(min_index,2);
end