function r = mirror(obj1,varargin)
    c = varargin{1};
    fnc = @(x) obj1.sdf(pMirror(x,c));
    r   = Sdf(fnc);
    r.BdBox = obj1.BdBox;
end  