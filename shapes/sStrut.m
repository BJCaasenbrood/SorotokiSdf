% SSTRUT Creates a strut surface distance field.
%
% Syntax:
%   sdf = sStrut(varargin)
%
% Description:
%   This function creates a strut surface distance field. The strut is
%   defined by its start and end points, as well as its thickness.
%
% Input:
%   varargin - Optional input arguments. The following options are
%              available:
%              - x2: The x-coordinate of the end point of the strut. If
%                only one argument is provided, both x2 and y2 will be set
%                to that value. Default is 1.
%              - y2: The y-coordinate of the end point of the strut. If
%                only one argument is provided, both x2 and y2 will be set
%                to that value. Default is 1.
%              - [x1, y1]: The start point coordinates of the strut. If two
%                arguments are provided, x1 and y1 will be set to the first
%                argument, and x2 and y2 will be set to the second
%                argument. Default is [0, 0].
%              - [p0, p1]: The start and end point coordinates of the strut.
%                If two 2D coordinate arrays are provided, x1, y1, x2, and
%                y2 will be set accordingly. Default is [0, 0] and [1, 1].
%              - T: The thickness of the strut. If only one argument is
%                provided after the start and end points, T will be set to
%                that value. Default is 0.5.
%
% Output:
%   sdf - Sdf object representing the strut surface distance field.
%
% See also: sdfLine, Sdf

function sdf = sStrut(varargin)

x1 = 0;
x2 = 1;
y1 = 0;
y2 = 1;
T = 0.5;

if nargin == 1
    x2 = varargin{1};
    y2 = varargin{1};
elseif nargin == 2
    if numel(varargin{1}) == 1
        x2 = varargin{1};
        y2 = varargin{2};
    elseif numel(varargin{1}) == 2 && numel(varargin{2}) == 2
        p0 = varargin{1}; p1 = varargin{2};
        x1 = p0(1);
        y1 = p0(2);
        x2 = p1(1);
        y2 = p1(2);
        
        if norm(p0(:)-p1(:)) < eps
            error('strut has zero length');
        end
    elseif numel(varargin{1}) == 2 && numel(varargin{2}) == 1
        p1 = varargin{1};
        x2 = p1(1);
        y2 = p1(2);
        T = varargin{2};
    else
        error('Wrong input for strut');
    end
elseif nargin == 3
    if numel(varargin{1}) == 2
        p0 = varargin{1}; p1 = varargin{2};
        x1 = p0(1);
        y1 = p0(2);
        x2 = p1(1);
        y2 = p1(2);
        T  = varargin{3};
        
        if norm(p0(:)-p1(:)) < eps
            error('strut has zero length');
        end
    end
elseif nargin == 5
    x1 = varargin{1};
    y1 = varargin{3};
    x2 = varargin{2};
    y2 = varargin{4};
    T = varargin{4};
end

sdf = Sdf(@(P) sdfLine(P,x1,x2,y1,y2,T));
sdf.BdBox = [x1-T,x2+T,y1-T,y2+T];
end

function d = sdfLine(P,x1,x2,y1,y2,T)
a = [x2-x1,y2-y1]; 
a = a/norm(a);
b = [P(:,1)-x1,P(:,2)-y1];
d1 = abs(b(:,1)*a(2) - b(:,2)*a(1))-T;

th = atan2(y2-y1,x2-x1);
r = [cos(-pi/2+th), sin(-pi/2+th);
     cos(+pi/2+th), sin(+pi/2+th)];

X11 = x1;
X21 = x1 + r(1,1);
Y11 = y1;
Y21 = y1 + r(1,2);

X12 = x2;
X22 = x2 + r(2,1);
Y12 = y2;
Y22 = y2 + r(2,2);

a = [X21-X11,Y21-Y11]; 
a = a/norm(a);
b = [P(:,1)-X11,P(:,2)-Y11];
d2 = b(:,1)*a(2) - b(:,2)*a(1);

d1 = max(d1(:,end),d2(:,end));

a = [X22-X12,Y22-Y12]; 
a = a/norm(a);
b = [P(:,1)-X12,P(:,2)-Y12];
d2 = b(:,1)*a(2) - b(:,2)*a(1);

d=max(d1(:,end),d2(:,end));

c1 = sqrt((P(:,1)-x1).^2+(P(:,2)-y1).^2)-T;
c2 = sqrt((P(:,1)-x2).^2+(P(:,2)-y2).^2)-T;

d = min(min(d(:,end),c2(:,end)),c1(:,end));

d = [d,d,d,d];
end