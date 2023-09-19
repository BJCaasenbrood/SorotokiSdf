%SCIRCLE - returns a signed distance function for a circle
%
%   sdf = sCircle(r) returns a signed distance function for a circle with 
%   radius r and centered at the origin (0, 0).
%
%   sdf = sCircle(r, [x, y]) returns a signed distance function for a circle 
%   with radius r and centered at point (x, y).
%
%   The output sdf is a SDF object that can be used to evaluate the signed
%   distance of a given point to the circle.
%
%   Example:
%       sdf = sCircle(1, [0, 0])
%       point = [-0.5, 0.5];
%       dist = sdf.eval(point)
%
%   See also SDF, DCIRCLE

function sdf = sGyroid2D(varargin)
r  = 0.75;
w  = 2*pi;
xc = 0;
yc = 0;

if nargin == 1
    w  = abs(varargin{1}) * 2 * pi; 
elseif nargin == 2
    w  = abs(varargin{1}) * 2 * pi; 
    r  = abs(varargin{1});
end

eps = 1e-4*r;
sdf = Sdf(@(P) dGyroid(P,r,w));
sdf.BdBox = [xc - w/pi - eps, xc + w/pi + eps, ...
             yc - w/pi - eps, yc + w/pi + eps]/2;

sdf.options.Quality = 200;
end

function d = dGyroid(P,r,w)
Z = pi;

x = P(:,1);
y = P(:,2);

d = abs(sin(w * x) .* cos(w * y) + sin(w * y)*cos(w*Z) + sin(w*Z)*cos(w*x)) - r;
d = [d,d];
end