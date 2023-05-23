function sdf = sLine(varargin)
x1 = 0;
x2 = 1;
y1 = 0;
y2 = 1;

if nargin == 1
   x2 = varargin{1};
   y2 = varargin{1};
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
       
       if norm(p0(:)-p1(:)) < eps
           error('Line has zero length');
       end
   else
      error('Wrong input for sLine');
   end
elseif nargin == 4
   x1 = varargin{1};
   y1 = varargin{3};
   x2 = varargin{2};
   y2 = varargin{4};
end


sdf = Sdf(@(P) sdfLine(P,x1,x2,y1,y2));

if abs(atan2(y2-y1,x2-x1)) < 2*pi/300
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