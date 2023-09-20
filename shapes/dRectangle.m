function d = dRectangle(P,x1,x2,y1,y2)
% DRECTANGLE Calculates the distances from points P to a rectangle defined by its corners.
%
%   d = dRectangle(P, x1, x2, y1, y2) calculates the distances from each point in P to a rectangle
%   defined by its bottom-left corner (x1, y1) and top-right corner (x2, y2). The output d is a 
%   matrix where each row corresponds to a point in P and contains the distances in the following order:
%   [distance to left side, distance to right side, distance to bottom side, distance to top side, maximum distance].
%
% Input:
%   - P: a matrix of size N-by-2 representing N points with their x and y coordinates.
%   - x1: the x-coordinate of the bottom-left corner of the rectangle.
%   - x2: the x-coordinate of the top-right corner of the rectangle.
%   - y1: the y-coordinate of the bottom-left corner of the rectangle.
%   - y2: the y-coordinate of the top-right corner of the rectangle.
%
% Output:
%   - d: distances from each point in P to the rectangle.    
    d = [x1-P(:,1), P(:,1)-x2, y1-P(:,2), P(:,2)-y2];
    d = [d, max(d,[],2)];
end