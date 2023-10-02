% STORUS Creates a signed distance field (SDF) for a torus shape.
%
%   sdf = sTorus() creates an SDF for a torus with default parameters.
%   sdf = sTorus(rc) creates an SDF for a torus with the specified outer radius rc.
%   sdf = sTorus(rc, rt) creates an SDF for a torus with the specified outer radius rc
%   and inner radius rt.
%   sdf = sTorus(rc, rt, v) creates an SDF for a torus with the specified outer radius rc,
%   inner radius rt, and translation vector v.
%
% Input:
%   - rc: The outer radius of the torus (default: 2.5).
%   - rt: The inner radius of the torus (default: 1).
%   - v: The translation vector of the torus (default: [0, 0, 0]).
%
% Output:
%   - sdf: The signed distance field (SDF) for the torus shape.
%
% Example:
%   sdf = sTorus(); % Creates an SDF for a torus with default parameters.
%   sdf = sTorus(3); % Creates an SDF for a torus with outer radius 3.
%   sdf = sTorus(3, 1.5); % Creates an SDF for a torus with outer radius 3 and inner radius 1.5.
%   sdf = sTorus(3, 1.5, [1, 2, 3]); % Creates an SDF for a torus with outer radius 3, inner radius 1.5,
%   and translation vector [1, 2, 3].
%
% See also: Sdf, dDiff, dRectangle, dCircle

function sdf = sTorus(varargin)
rt = 1;
rc = 2.5;
xc = 0;
yc = 0;
zc = 0;

if nargin == 1
    rc  = abs(varargin{1}); 
elseif nargin == 2
    rc  = max(abs(varargin{1}),abs(varargin{2})); 
    rt  = min(abs(varargin{1}),abs(varargin{2})); 
elseif nargin > 2
    rc  = max(abs(varargin{1}),abs(varargin{2})); 
    rt  = min(abs(varargin{1}),abs(varargin{2})); 
    if numel(varargin{3}) == 3
        v  = varargin{3};
        xc = v(1); 
        yc = v(2);
        zc = v(3);
    else
        error('Translation should be of size 3 in sCircle(r,[x,y,z])');
    end    
end

sdf = Sdf(@(P) sdfTorus(P,xc,yc,zc,rc,rt));

sdf.BdBox = [xc-rc-rt-1e-6,xc+rc+rt+1e-6,....
             yc-rc-rt-1e-6,yc+rc+rt+1e-6,...
             zc-rc-rt-1e-6,zc+rc+rt+1e-6];
end

function d = sdfTorus(P,xc,yc,zc,rc,rt)
d = sqrt((rc-sqrt((P(:,1)-yc).^2+(P(:,2)-zc).^2)).^2 + (P(:,3)-xc).^2) - rt;
d=[d,d];
end