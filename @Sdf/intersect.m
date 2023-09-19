function [y, I] = intersect(Sdf,x,varargin)
% [y, I] = intersect(Sdf, x, varargin) calculates the intersection between a signed distance function (SDF)
% and a given set of points.
%
% Inputs:
%   - Sdf: An instance of the Sdf class.
%   - x: A matrix or vector representing the points to be evaluated.
%   - varargin: Optional argument(s).
%       - delta: A threshold value for determining the intersection. If not provided,
%         it is set to 0 by default.
%
% Outputs:
%   - y: A logical array indicating whether each point intersects with the SDF
%     (f(x) <= delta). The size of y is the same as x.
%   - I: A list of indices corresponding to the points that fall within the SDF
%     function.
%
% Usage:
%   sdfObj = sCircle(); % Create an instance of the Sdf class
%   points = [1, 2; 4, 5]; % Example set of points
%   [intersections, indices] = sdfObj.intersect(points); % Calculate intersections
%
% See also: Sdf.sdf    

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