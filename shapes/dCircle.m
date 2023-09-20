function d = dCircle(P,xc,yc,r)
% DCIRCLE Calculates the signed distance from a point to a circle.
%
%   d = dCircle(P, xc, yc, r) calculates the signed distance between each
%   point in P and the circle with center (xc, yc) and radius r.
%
% Input:
%   - P: Matrix of points with x and y coordinates. Each row represents a
%        point.
%   - xc: x-coordinate of the circle center.
%   - yc: y-coordinate of the circle center.
%   - r: Radius of the circle.
%
% Output:
%   - d: Column vector containing the signed distances from each point in P

    d = sqrt((P(:,1) - xc).^2 + (P(:,2) - yc).^2) - r;
    d = [d,d];
end