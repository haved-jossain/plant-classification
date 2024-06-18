function LWF = getWidthVector(image, length)
% GETWIDTHVECTOR extracts and return the Laminal Width Factor (LWF) of a 
% binary leaf.
%
% PARAMETERS:
%       image = an aligned binary (fully preprocessed) simple leaf
%       length = specifies the length of the output vector LWF
%
% OUTPUT:
%       LWF = The Laminal Width Factor of the input simple leaf
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

    % Get the width of the image, which is actually the length of the leaf
    C = image;
    [r c] = size(C);    
    leafLength = c;
    
    % Calculate the interval based on the specified length (of LWF)
    interval = floor(leafLength /(length+1));
    x = interval;
    
    % Calculate the LWF
    for i = 1:length               
        col = C(:,x);  
        w = sum(col); % width of column x of image C
        LWF(i,1) = w/leafLength; % normalize with the leaf length
        x = x + interval;
    end            
end