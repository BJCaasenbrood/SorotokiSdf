function sdf = sCylinder(varargin)
% SCYLINDER Create a signed distance function (SDF) for a cylinder.
%
%   sdf = sCylinder() creates an SDF for a unit cylinder centered at the
%       origin with height 2 units.
%   sdf = sCylinder(r) creates an SDF for a cylinder with radius r and
%       height 2 units, centered at the origin.
%   sdf = sCylinder(r, z2) creates an SDF for a cylinder with radius r and
%       height z2, centered at the origin.
%   sdf = sCylinder(r, [z1, z2]) creates an SDF for a cylinder with radius r
%       and height z2, starting from z1, centered at the origin.
%   sdf = sCylinder(r, [z1, z2], [xc, yc, zc]) creates an SDF for a cylinder
%       with radius r and height z2, starting from z1, centered at the point
%       (xc, yc, zc).
%
%   Input:
%       r - Radius of the cylinder (default: 1)
%       z1 - Starting height of the cylinder (default: 0)
%       z2 - Ending height of the cylinder (default: 2)
%       xc - x-coordinate of the center of the cylinder (default: 0)
%       yc - y-coordinate of the center of the cylinder (default: 0)
%
%   Output:
%       sdf - Signed distance function for the cylinder
%
%   Example:
%       sdf = sCylinder(2, [1, 4], [3, -2, 1]);
%
%   See also: DCYLINDER, SCIRCLE, SCUP

r  = 1;
z2 = 2;
xc = 0;
yc = 0;
z1 = 0;

if numel(varargin) == 1
    r = varargin{1};
elseif numel(varargin) == 2
    if numel(varargin{1}) == 1 &&  numel(varargin{2}) == 1
        r = varargin{1};
        z2 = varargin{2};
    elseif numel(varargin{1}) == 1 &&  numel(varargin{2}) == 2
        r = varargin{1};
        z1 = varargin{2}(1);
        z2 = varargin{2}(2);
    end
elseif numel(varargin) == 3
    r = varargin{1};
    xc = varargin{3}(1);
    yc = varargin{3}(2);
    z1 = varargin{3}(3);
    if numel(varargin{2}) == 1
        z2 = z1 + varargin{2};
    elseif numel(varargin{2}) == 2
        z2 = z1 + varargin{2}(2);
        z1 = z1 + varargin{2}(1);
    end
end

sdf = Sdf(@(P) sdfCylinder(P,xc,yc,z1,z2,r));

sdf.BdBox = [xc-r-1e-6,xc+r+1e-6,....
             yc-r-1e-6,yc+r+1e-6,...
             z1-1e-6,z2+1e-6];         
end

function d = sdfCylinder(P,xc,yc,z1,z2,r)
d1 = sqrt((P(:,1)-xc).^2+(P(:,2)-yc).^2)-r;
d2 = z1-P(:,3);
d3 = P(:,3)-z2;

F1 = sqrt(d1.^2 + d2.^2);
F2 = sqrt(d1.^2 + d3.^2);
F3 = max([d1,d2,d3],[],2);
L1 = (d1 > 0 & d2 >0);
L2 = (d1 > 0 & d3 >0);
L3 = ~(L1 + L2);

d = F1.*L1 + F2.*L2 + F3.*L3;

end

%-------------------------------------------------------------------------%
function [V,F] = generateNodeSet(xc,yc,zc1,zc2,r,N)
th = linspace(-pi,pi,N).';
tt = linspace(-pi,pi-pi/2,4).';
zh = linspace(zc1,zc2,N).';
nn = 0*th;

x1 = r*cos(th) + xc;
y1 = r*sin(th) + yc;
z1 = zc1 + nn;

x2 = r*cos(th) + xc;
y2 = r*sin(th) + yc;
z2 = zc2 + nn;

x3 = r*cos(tt(1)) + xc + nn;
y3 = r*sin(tt(1)) + yc + nn;
z3 = zh;

x4 = r*cos(tt(2)) + xc + nn;
y4 = r*sin(tt(2)) + yc + nn;
z4 = zh;

x5 = r*cos(tt(3)) + xc + nn;
y5 = r*sin(tt(3)) + yc + nn;
z5 = zh;

x6 = r*cos(tt(4)) + xc + nn;
y6 = r*sin(tt(4)) + yc + nn;
z6 = zh;

V = [x1,y1,z1;x2,y2,z2;x3,y3,z3;...
     x4,y4,z4;x5,y5,z5;x6,y6,z6];
 
S = [(1:N-1).',(2:N).'];
F = [S;S+N;S+2*N;S+3*N;S+4*N;S+5*N];
end
