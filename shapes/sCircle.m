function sdf = sCircle(varargin)
% SCIRCLE Creates a signed distance field (SDF) for a circle.
%
%   sdf = sCircle() creates an SDF for a unit circle centered at the origin.
%
%   sdf = sCircle(r) creates an SDF for a circle with radius r, centered at
%   the origin.
%
%   sdf = sCircle(r, [x, y]) creates an SDF for a circle with radius r,
%   centered at the point (x, y).
%
% Input:
%   - r: Radius of the circle (default: 1)
%   - [x, y]: Center coordinates of the circle (default: [0, 0])
%
% Output:
%   - sdf: Signed distance field for the circle
%
% Example:
%   sdf = sCircle(2, [3, 4]);
%   % Creates an SDF for a circle with radius 2, centered at (3, 4)
%
% See also: dCircle, Sdf
    
r  = 1;
xc = 0;
yc = 0;

if nargin == 1
    r  = abs(varargin{1}); 
elseif nargin > 1
    r = abs(varargin{1});
    if numel(varargin{2}) == 2
        v  = varargin{2};
        xc = v(1); 
        yc = v(2);
    else
        error('Translation should be of size 2 in sCircle(r,[x,y])');
    end    
end

eps = 1e-4*r;
sdf = Sdf(@(P) dCircle(P,xc,yc,r));
sdf.BdBox = [xc - r - eps, xc + r + eps, ...
             yc - r - eps, yc + r + eps];
sdf.options.Quality = 200;
end

function d = dCircle(P,xc,yc,r)
d = sqrt((P(:,1) - xc).^2 + (P(:,2) - yc).^2) - r;
d = [d,d];
end