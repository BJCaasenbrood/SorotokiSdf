function sdf = sCup(varargin)
% SCUP Creates a signed distance field (SDF) for a cup shape.
%
%   sdf = sCup() creates an SDF for a cup with default parameters.
%   sdf = sCup(r) creates an SDF for a cup with the specified radius r.
%   sdf = sCup(r, x) creates an SDF for a cup with the specified radius r
%   and height x.
%
% Input:
%   - r: The radius of the cup (default: 1).
%   - x: The height of the cup (default: 1).
%
% Output:
%   - sdf: The signed distance field (SDF) for the cup shape.
%
% Example:
%   sdf = sCup(); % Creates an SDF for a cup with default parameters.
%   sdf = sCup(2); % Creates an SDF for a cup with radius 2.
%   sdf = sCup(2, 3); % Creates an SDF for a cup with radius 2 and height 3.
%
% See also: Sdf, dDiff, dRectangle, dCircle

r  = 1;
xc = 0;
yc = 0;
x  = 1;

if nargin == 1
    r = varargin{1}; 
    x = r;
elseif nargin == 2
    r = varargin{1}; 
    x = varargin{2}; 
end

eps = 1e-4*r;

if x > 0
    sdf = Sdf(@(P) dDiff(dRectangle(P,xc-r,xc+r,yc-x,yc),...
        dCircle(P,xc,yc,r)));

    sdf.BdBox = [xc-r-eps,xc+r+eps,yc-x-eps,yc+eps];
else
    sdf = Sdf(@(P) dDiff(dRectangle(P,xc-r,xc+r,yc,yc+abs(x)),...
        dCircle(P,xc,yc,r)));

    sdf.BdBox = [xc-r-eps,xc+r+eps,yc-eps,yc+abs(x)+eps];
end

end

function d = dCircle(P,xc,yc,r)
    d = sqrt((P(:,1)-xc).^2+(P(:,2)-yc).^2)-r;
    %d = [d,d];
end

function d = dRectangle(P,x1,x2,y1,y2)
d = [x1-P(:,1), P(:,1)-x2, y1-P(:,2), P(:,2)-y2];
d = max(d,[],2);
end