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

function sdf = sSchwarz2D(varargin)
r = 1;
w = 2;
isRotated = false;

for ii = 1:numel(varargin)
    if strcmpi(varargin{ii},'rotated')
        isRotated = varargin{ii+1};
    end
end

if nargin == 1
    w  = abs(varargin{1}) ; 
elseif nargin > 1
    w  = abs(varargin{1}); 
    r  = abs(varargin{2});
end

eps = 1e-4*r;
sdf = Sdf(@(P) dSchwarz(P,r,w,isRotated));
sdf.BdBox = [- eps, 1 + eps, ...
             - eps, 1  + eps];

sdf.options.Quality = 300;
end

function d = dSchwarz(P,r,w,rotate)

if rotate    
    x = 0.5*sqrt(2)*P(:,1) - 0.5*sqrt(2)*P(:,2);
    y = 0.5*sqrt(2)*P(:,1) + 0.5*sqrt(2)*P(:,2);   
    w = 0.5*sqrt(2) * w;
else
    x = P(:,1);
    y = P(:,2);
end

d = abs(cos(2 * w * pi * x) + cos(2 * w * pi * y)) - r;
d = [d,d];
end