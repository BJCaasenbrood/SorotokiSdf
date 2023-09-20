function sdf = sRectangle(varargin)
% SRECTANGLE Create a rectangle shape with specified dimensions.
%
%   sdf = sRectangle() creates a rectangle with default dimensions of 1x1,
%       centered at the origin (0,0).
%   sdf = sRectangle(length) creates a square with sides of length 'length',
%       centered at the origin (0,0).
%   sdf = sRectangle(width, height) creates a rectangle with the specified
%       width and height, centered at the origin (0,0).
%   sdf = sRectangle([x1, y1], [x2, y2]) creates a rectangle with the specified
%       coordinates of its bottom-left corner (x1, y1) and top-right corner
%       (x2, y2).
%   sdf = sRectangle(x1, x2, y1, y2) creates a rectangle with the specified
%       coordinates of its bottom-left corner (x1, y1) and top-right corner
%       (x2, y2).
%
%   Input:
%       - length: Length of the sides of the square (default: 1)
%       - width: Width of the rectangle
%       - height: Height of the rectangle
%       - x1: X-coordinate of the bottom-left corner
%       - x2: X-coordinate of the top-right corner
%       - y1: Y-coordinate of the bottom-left corner
%       - y2: Y-coordinate of the top-right corner
%
%   Output:
%       - sdf: The created rectangle shape
%
%   Example:
%      
%       sdf = sRectangle(2);  % Create a square with sides of length 2
%       sdf = sRectangle(3, 4) % Create a rectangle with width 3 and height 4
%       sdf = sRectangle(-1, 2, -2, 3); % Create a rectangle with custom coordinates
%
%   See also: sCircle, sPolygon

x1 = 0;
x2 = 1;
y1 = 0;
y2 = 1;

if nargin == 1
   x1 = -varargin{1}/2;
   y1 = -varargin{1}/2;
   x2 = varargin{1}/2;
   y2 = varargin{1}/2;
elseif nargin == 2
   if numel(varargin{1}) == 1
       x2 = varargin{1};
       y2 = varargin{2};
   elseif numel(varargin{1}) == 2
       p0 = varargin{1}; p1 = varargin{2};
       x1 = p0(1);
       y1 = p0(2);
       x2 = p1(1);
       y2 = p1(2);
       
       if x1 == x2
           error('Rectangle has zero width');
       elseif y1 == y2
           error('Rectangle has zero height');
       end
   else
      error('Wrong input for sRectangle');
   end
elseif nargin == 4
   x1 = varargin{1};
   y1 = varargin{3};
   x2 = varargin{2};
   y2 = varargin{4};
end

eps = 1e-4 * norm([x1; x2; y1; y2]);
sdf = Sdf(@(P) sdfRectangle(P,x1,x2,y1,y2));
sdf.BdBox = [x1 - eps, x2 + eps, y1 - eps, y2 + eps];
sdf.options.Center = sdf.centerofmass();
end

function d = sdfRectangle(P,x1,x2,y1,y2)
d = [x1-P(:,1), P(:,1)-x2, y1-P(:,2), P(:,2)-y2];
d = [d, max(d,[],2)];
end