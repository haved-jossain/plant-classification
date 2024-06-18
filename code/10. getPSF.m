function PSF = getPSF()
% GETPSF extracts the Primary Shape Features of all 1200 simple leaves and
% returns the feature matrix.
%
% PARAMETERS:
%       None
%
% OUTPUT:
%       PSF = the feature matrix of size 8 x 1200
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

    % Initialize feature matrix PSF
    PSF = zeros(8,1200);
    
    for i = 1:1200
       
        % Read the image and convert to black and white (BW) image
        filename = strcat(int2str(1000 + f),'.bmp');
        I = im2bw(imread(filename));
        
        % Crop the image, keep only leaf
        P = regionprops(I, 'Image');
        C = P.Image;
        
        % Get region properties of binary leaf I
        PROPS = regionprops(C,'Eccentricity','Area','ConvexArea','Perimeter','EquivDiameter','MajorAxisLength','MinorAxisLength','Extent','Solidity');     

        % Extract the Primary Shape Features (PSF)
        ec = PROPS.Eccentricity;
        ar = PROPS.Area;
        ca = PROPS.ConvexArea;                
        pr = PROPS.Perimeter;
        ed = PROPS.EquivDiameter;
        mj = PROPS.MajorAxisLength;
        mn = PROPS.MinorAxisLength;
        ex = PROPS.Extent;
        sd = PROPS.Solidity;

        % Normalize features
        ar = ar/mj;
        pr = pr/mj;
        mr = mn/mj;
        ed = ed/mj;            
        ca = (ca-PROPS.Area)/PROPS.Area;

        % Store features
        features(1,i) = ec;
        features(2,i) = sd;
        features(3,i) = ar;
        features(4,i) = pr;
        features(5,i) = mr;
        features(6,i) = ed;        
        features(7,i) = ex;
        features(8,i) = ca;         
        PSF(:,i) = features(:,i);
        
        % Print progress
        fprintf('Progress: %g',100*i/1200);
        disp(' ');
    end    
end