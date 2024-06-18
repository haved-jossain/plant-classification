function Yc = searchCompoundLeaves(I)
% SEARCHCOMPOUNDLEAVES searches using a pre-trained PNN for compound leaves 
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

% Load the PNN trained with compound leaves
load('CompoundLeafPNN.mat');

% Get region properties of binary leaf I
PROPS = regionprops(I,'Eccentricity','Area','ConvexArea','Perimeter','EquivDiameter','MajorAxisLength','MinorAxisLength','Extent','Solidity','FilledArea','FilledImage');     

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
fa = PROPS.FilledArea;

% Normalize the features
ar = ar/mj;
pr = pr/mj;
mr = mn/mj;
ed = ed/mj;
ci = (ca-ar)/ar;
fa = (fa-ar)/ar;

% Store the features in an array
features(1,1) = ec;
features(2,1) = sd;
features(3,1) = ar;
features(4,1) = pr;
features(5,1) = mr;
features(6,1) = ed;
features(7,1) = ex;
features(8,1) = ci;
features(9,1) = fa;

% Normalize features
features(:,1) = features(:,1) - RowMeans';
features(:,1) = features(:,1) ./ RowStds';

% Use the feature array with the PNN to find out the plant class
Y = sim(net,features);
Yc = vec2ind(Y)';

end