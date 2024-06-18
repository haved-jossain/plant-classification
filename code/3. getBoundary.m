function boundary = getBoundary(I, x, y)
% GETBOUNDARY gets the coordinates of the boundary pixels of the binary
% leaf I. The boudary tracing starts at pixel (x,y) and terminates 
% when it arrives this starting point.
%
% PARAMETERS:
%       I = a binary leaf image
%       X = x-coordinate of the starting point of binary leaf I
%       Y = y-coordinate of the starting point of binary leaf I
%
% OUTPUT:
%       boundary = the coordinates of the boundary pixels of the binary
% leaf I
%
% AUTHOR:
%       Javed Hossain
%       Date: April 20, 2010.

% Initialize boundary
boundary = -1;

% Extract the boundary with initial search direction set to North (N)
try
    boundary = bwtraceboundary(I,[x, y],'N'); 
catch
    try % Try East (E) is North fails
        boundary = bwtraceboundary(I,[x, y],'E');
    catch
        try % Try South (S) is East fails
            boundary = bwtraceboundary(I,[x, y],'S');
        catch
            try % Try West (W) is East fails
                boundary = bwtraceboundary(I,[x, y],'W');
            catch
                error('Boundary extraction failed.');
            end
        end
    end
end

end