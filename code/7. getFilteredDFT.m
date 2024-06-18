function [vc pc] = getFilteredDFT(distCurve, boundary)
% GETFILTEREDDFT smooths the BCD vector of a leaf by applying FFT and IFFT,
% counts the number of valleys in the smoothed BCD and the number of peaks
% that occurred the maximum times.
%
% PARAMETERS:
%       distCurve = BCD curve of a leaf
%       boundary = boundary of a leaf
%      
% OUTPUT:
%       vc = valley count of the smoothed BCD
%       pc = peak count of the smoothed BCD    
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

d1 = distCurve(:,1);

% Smooth and count peaks over 30 iterations using FFT and IFFT
ind = 1;     
for j = 1:1:30
    F = fft(d1);
    AF = abs(F);
    [r c] = size(F);
    F2 = zeros(r,c);
    thresh = j;        
    for i = 1:r
        if AF(i,1) >= thresh % thresh to filter out sine waves with low amp
            F2(i,1) = F(i,1);                
        end
    end
    F3 = ifft(F2);
    N = nCount(F3);        
    Na(ind,1) = N(1,3);
    ind = ind + 1;
end    

% Find out the boundary pixels corresponding to the valleys
N = nCount(F3);
dec_arr_size = N(1,3) - 1;
dec_arr = zeros(dec_arr_size,2);
for i = 1:N(1,1)
    v = N(2,i);
    if v ~= 0            
        dec_arr(i,1) = boundary(v,1);
        dec_arr(i,2) = boundary(v,2);
    end
end

count = 0;
% Compute distances among the valleys  
for i = 1:dec_arr_size
    x1 = dec_arr(i,1);
    y1 = dec_arr(i,2);        
    for j = i+1:dec_arr_size
        x2 = dec_arr(j,1);
        y2 = dec_arr(j,2);
        distance = sqrt((x1 - x2)^2 + (y1 - y2)^2);
        if distance <= 0.15
            count = count + 1;
        end
    end        
end
pc = maxOccurance(Na);
vc = count;

end

function out = nCount( dist )

    [r c] = size(dist);
    inc = zeros(r,1);
    dec = zeros(r,1);
    all = zeros(r,1);
    N = 0;
    out = zeros(4,r);
    
    increasing = 0;
    in_count = 0;

    decreasing = 0;
    de_count = 0;
  
    thresh = 1;
    for i = 1:r-1
        if dist(i+1,1) > dist(i,1)
            %Change from decreasing to increasing
            if decreasing >= thresh
                N = N + 1;
                decreasing = 0;                
                in_count = in_count + 1;
                inc(in_count,1) = i;
                all(N,1) = dist(i,1);
            end                                   
            increasing = increasing + 1;            
        end
        if dist(i+1,1) < dist(i,1)
            %Change from increasing to decreasing
            if increasing >= thresh
                N = N + 1;
                increasing = 0;                
                de_count = de_count + 1;
                dec(de_count,1) = i;
                all(N,1) = dist(i,1);
            end                     
            decreasing = decreasing + 1;
        end
    end
    
    out(1,1) = N;
    out(1,2) = in_count;
    out(1,3) = de_count;    
    out(2,:) = inc(:,:);
    out(3,:) = dec(:,:);
    out(4,:) = all(:,:);
end