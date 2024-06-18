function leafType = identifyLeaf(I,x,y)
% IDENTIFYLEAF identifies whether the input binary leaf is simple or 
% compound, provided the coordinates of the base-point.
%
% PARAMETERS:
%       I = a preprocessed binary leaf image
%       X = x-coordinate of the base-point of binary leaf I
%       Y = y-coordinate of the base-point of binary leaf I
%
% OUTPUT:
%       leafType = type of the leaf, possible return values are 'simple',
%       'compound' and 'simple/compound'(returned if identification fails).
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

% Get the boundary of the input binary image
B = getBoundary(I,x,y);

% Get the Base-point Contour Distance (BCD) vector of the input leaf
D = getDistanceVector(B,x,y);

% Smooth the BCD vector
F = getFilteredDFT(D,B,I);

% Get the largest connected component in input image
BW1 = I;
CC = bwconncomp(BW1);
[h w] = size(BW1);
BW2 = zeros(h,w);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
BW2(CC.PixelIdxList{idx}) = 1;

% Get the Filled Area and Area(normal) of the input leaf
P = regionprops(BW2,'FilledArea','Area');
Ar = P.Area;
Far = P.FilledArea;

% Find the amount of holes in the leaf
holeArea = ((Far - Ar)/Ar)*100;

% Get the number of valleys in the BCD vector
totalValleyCount = F(1,1);

% Get the number of valleys in the BCD vector that are very close
closeValleyCount = F(1,2);

% Classify the input leaf based on the features extracted above
if totalValleyCount == 1
    leafType = 'Simple';    
elseif totalValleyCount > 0 && holeArea > 1
    leafType = 'Compound';
elseif holeArea > 2
    leafType = 'Compound';
elseif totalValleyCount > 0 && closeValleyCount > 1 && holeArea < 0.5
    leafType = 'Compound';    
elseif totalValleyCount > 0 && holeArea < 0.5
    leafType = 'Simple/Compound';    
end

end