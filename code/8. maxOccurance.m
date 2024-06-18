function M = maxOccurance(A)
% MAXOCCURANCE returns the value that occurred the highest number of times in
% the input array.
%
% PARAMETERS:
%       A = an array of value
%
% OUTPUT:
%       M = the value that occurred the highest number of times in
%       the input array A.
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

% Get the maximum value in array A
mx = max(A);

% Create an array of size A
arr = zeros(mx,1);
[r c]= size(A);

% Count the number of times each value has occurred in array A
for i = 1:r
    arr(A(i,1),1) = arr(A(i,1),1) + 1;                
end
max_occur = 1;

% Find the value with highest occurance
for i = 1:mx
    if arr(i,1) > arr(max_occur,1)
        max_occur = i;
    end
end
% return the value with highest occurrance
M = max_occur;        
end