function sdf = sLine(varargin)
% SLINE Creates a line segment in 2D space. Note left-hand side is defined as inside the SDF fucntion.
%
% Syntax:
%   sdf = sLine(varargin)
%
% Description:
%   This function creates a line segment in 2D space. The line can be
%   defined by specifying different input arguments.
%
% Input:
%   varargin (optional) - Variable number of input arguments.
%     - If nargin == 1, 
%       - sLine([x2,y2]), sets line from [0,0,] to [x2,y2]
%     - If nargin == 2,
%       - sLine(x2,y2), sets line from [0,0] to [x2,y2].
%       - sLine([x1,y1],[x2,y2]), sets line from [x1,y1] to [x2,y2].
%     - If nargin == 4, 
%       - sLine(x1,x2,y1,y2) to make line from [x1,y1] to [x2,y2].
%
% Output:
%   sdf - Sdf object representing the line segment.
% See also: sdfLine, Sdf
    
x1 = 0;
x2 = -1;
y1 = 0;
y2 = 0;

if nargin == 1  % sets line from [0,0] to [x2,y2]
   x2 = varargin{1};
   y2 = varargin{1};
elseif nargin == 2
   if numel(varargin{1}) == 1 % sets line from [0,0] to [x2,y2]
       x2 = varargin{1};
       y2 = varargin{2};
   elseif numel(varargin{1}) == 2 % sets line from [x1,y1] to [x2,y2]
       p0 = varargin{1}; p1 = varargin{2};
       x1 = p0(1);
       y1 = p0(2);
       x2 = p1(1);
       y2 = p1(2);
       
       if norm(p0(:)-p1(:)) < eps
           error('Line has zero length');
       end
   else
      error('Wrong input for sLine');
   end
elseif nargin == 4 % uses input [x1,x2,y1,y2] to make line from [x1,y1] to [x2,y2]
   x1 = varargin{1};
   y1 = varargin{3};
   x2 = varargin{2};
   y2 = varargin{4};
end

sdf = Sdf(@(P) sdfLine(P,x1,x2,y1,y2));

if abs(atan2(y2-y1,x2-x1)) < 2*pi/300 || (abs(atan2(y2-y1,x2-x1)) - pi) < 2*pi/300
    a = max(abs(x2-x1),abs(y2-y1));
    sdf.BdBox = [-a+x1,a+x1,-a+y1,a+y1];
else
    sdf.BdBox = [x1,x2,y1,y2];
end

end

function d = sdfLine(P,x1,x2,y1,y2)
a = [x2-x1,y2-y1]; 
a = a/norm(a);
b = [P(:,1)-x1,P(:,2)-y1];
d = b(:,1)*a(2) - b(:,2)*a(1);
d = [d,d];
end