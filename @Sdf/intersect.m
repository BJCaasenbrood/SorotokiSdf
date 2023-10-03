function [y, I] = intersect(Sdf,x,varargin)
% INTERSECT Find the intersection points of a scalar field with a threshold.
% [Y, I] = INTERSECT(SDF, X) finds the intersection points of a scalar
% field defined by the signed distance function class (SDF) with a threshold.
% The output Y is a logical array indicating whether each point in X
% intersects with the scalar field. The output I is an array containing
% the indices of the intersecting points.

% Example:
% sdf = struct('sdf', @mySignedDistanceFunction);
% x = linspace(-1, 1, 100)';
% [y, I] = intersect(sdf, x);
%
% 

% set the threshold for intersection
if isempty(varargin)
    delta = 0;
else
    delta = varargin{1} ;
end

% eval the SDF function
d = Sdf.sdf(x);
y = d(:,end)<delta;

% build entries that fall within SDF function: f(x) <= d
List = 1:numel(y);
I = List(y);

end