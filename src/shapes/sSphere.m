function sdf = sSphere(varargin)
r  = 1;
xc = 0;
yc = 0;
zc = 0;

if nargin == 1
    r  = abs(varargin{1}); 
elseif nargin > 1
    r = abs(varargin{1});
    if numel(varargin{2}) == 3
        v  = varargin{2};
        xc = v(1); 
        yc = v(2);
        zc = v(3);
    else
        error('Translation should be of size 3 in sCircle(r,[x,y,z])');
    end    
end
sdf = Sdf(@(P) sdfSphere(P,xc,yc,zc,r));

sdf.BdBox = [xc-r-1e-6,xc+r+1e-6,....
             yc-r-1e-6,yc+r+1e-6,...
             zc-r-1e-6,zc+r+1e-6];
         
end

function d = sdfSphere(P,xc,yc,zc,r)
    d = sqrt((P(:,1)-xc).^2+(P(:,2)-yc).^2+(P(:,3)-zc).^2)-r;
    d = [d,d];
end