function Yc = searchSimpleLeaves(I)
% SEARCHSIMPLELEAVES searches using a pre-trained PNN for compound leaves 
% and returns which class the input leaf belongs to.
%
% PARAMETERS:
%       I = a fully preprocessed binary leaf image
%
% OUTPUT:
%       Yc = value indicating which of the 5 classes the compound 
%       leaf belongs to
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

% Load the PNN trained with simple leaves
load('SimpleLeafPNN.mat');

% Fill any holes that might exist in the input image
BW1 = imfill(I,'holes');        

% Find the largest connected component
CC = bwconncomp(BW1);
[h w] = size(BW1);
BW2 = zeros(h,w);
numPixels = cellfun(@numel,CC.PixelIdxList);
[biggest,idx] = max(numPixels);
BW2(CC.PixelIdxList{idx}) = 1;    
I = BW2;

% Get region properties of binary leaf I
PROPS = regionprops(I,'Eccentricity','Area','ConvexArea','Perimeter','EquivDiameter','MajorAxisLength','MinorAxisLength','Extent','Solidity');     


% Extract the shape features
ec = PROPS.Eccentricity;
ar = PROPS.Area;
ca = PROPS.ConvexArea;                
pr = PROPS.Perimeter;
ed = PROPS.EquivDiameter;
mj = PROPS.MajorAxisLength;
mn = PROPS.MinorAxisLength;
ex = PROPS.Extent;
sd = PROPS.Solidity;

% Normalize the features
ar = ar/mj;
pr = pr/mj;
mr = mn/mj;
ed = ed/mj;            
ca = (ca-PROPS.Area)/PROPS.Area;

% Store the features in an array
features(1,1) = ec;
features(2,1) = sd;
features(3,1) = ar;
features(4,1) = pr;
features(5,1) = mr;
features(6,1) = ed;        
features(7,1) = ex;
features(8,1) = ca;   

% Get LWF of the input image
wv = getWidthVector(I,11);

% Combine all the features
F(1:11,1) = wv; 
F(12:19,1) = features;

% Normalize all features
F(:,1) = F(:,1) - RowMeans';
F(:,1) = F(:,1) ./ RowStds';

% Use the final feature array F with the PNN to find out the plant class
Y = sim(net,F);
Yc = vec2ind(Y)';

end