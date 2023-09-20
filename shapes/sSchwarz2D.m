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