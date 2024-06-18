function binaryLeaf = extractLeaf(image)
% EXTRACTLEAF extracts the leaf from an RGB or gray image, sets the pixels
% in the leaf to 1 (white) and rest of image to 0(black) then returns the
% binary leaf.
%
% PARAMETERS:
%       image = an RGB or gray leaf image
%
% OUTPUT:
%       binaryLeaf = a binary image where the parts of leaf is white and
%       rest of the image is black
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.                                                                     

% Set tolerance to 80
tolerance = 80;

% Get points interactively, until right mouse button is clicked
but   = 0;
ii    = 0;
xlist = [];
ylist = [];
hplot = [];
hold on    
while but ~= 3,
    ii = ii + 1;
    [x, y, but] = ginput(1);       
    xlist(ii)   = round(x);
    ylist(ii)   = round(y);      
    hplot(ii)   = plot(x,y,'*'); % plot the points immediately
end
xlist(end) = [];
ylist(end) = [];
delete(hplot);
hold off

 
% Check points validity
if isempty(xlist) || isempty(ylist),
    error('Point list is empty');
end

H = size(image, 1); % image height
W = size(image, 2); % image width

% Check if any point is out of range
k = ylist > 0 & ylist <= H;
k = k & xlist > 0 & xlist <= W;

if ~any(k),
    error('Coordinates out of range');
elseif ~all(k),
    disp('Warning: some coordinates out of range');
end

ylist = ylist(k);
xlist = xlist(k);

N = length(ylist); % Number of reference pixels


%Create the binary mask
color_mask = false(H, W);

if ndims(image) < 3,
    g = double(image);
    for i = 1:N,
        ref = double(image(ylist(i),xlist(i))); 
        color_mask = color_mask | (g - ref).^2 <= tolerance^2;
    end
elseif ndims(image) == 3,
    c_r = double(image(:, :, 1)); % Red channel
    c_g = double(image(:, :, 2)); % Green channel
    c_b = double(image(:, :, 3)); % Blue channel
    for i = 1:N,
        ref_r = double(image(ylist(i), xlist(i), 1));
        ref_g = double(image(ylist(i), xlist(i), 2));
        ref_b = double(image(ylist(i), xlist(i), 3));
        color_mask = color_mask | ...
            ((c_r - ref_r).^2 + (c_g - ref_g).^2 + (c_b - ref_b).^2)...
             <= tolerance^2;
    end
end

% Connected component labelling
[objects, count] = bwlabel(color_mask, 8); 

[y x v] = find(objects);
segList = [];

for i = 1:N,
    k = find(x == xlist(i) & y == ylist(i));
    segList = [segList; v(k)];
end

segList = unique(segList);

LUT = zeros(1,count+1);
LUT(segList+1) = 1;
binaryLeaf = LUT(objects+1);

end