function CPSF = getCompoundPSF()
% GETCOMPOUNDPSF extracts the Primary Shape Features of all 200 compound
% leaves and returns the feature matrix.
%
% PARAMETERS:
%       None
%
% OUTPUT:
%       CPSF = the feature matrix of size 9 x 200
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

    % Initialize feature matrix with 0's
    CPSF = zeros(9,200);

    for i = 1:200
        
        % Read image
        filename = strcat(int2str(400 + f),'.bmp');
        I = imread(filename);
      
        % Get region properties of binary leaf I
        PROPS = regionprops(I,'Eccentricity','Area','ConvexArea','Perimeter','EquivDiameter','MajorAxisLength','MinorAxisLength','Extent','Solidity','FilledArea','FilledImage');     
        
        % Extract the features
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

        % Normalize features
        ar = ar/mj;
        pr = pr/mj;
        mr = mn/mj;
        ed = ed/mj;
        ci = (ca-ar)/ar;
        fa = (fa-ar)/ar;
        
        % Store features
        features(1,i) = ec;
        features(2,i) = sd;
        features(3,i) = ar;
        features(4,i) = pr;
        features(5,i) = mr;
        features(6,i) = ed;
        features(7,i) = ex;
        features(8,i) = ci;
        features(9,i) = fa;
        
        CPSF(:,i) = features(:,i);
        
        % Print progress
        fprintf('Progress: %g',100*i/200);
        disp(' ');
    end    
end