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