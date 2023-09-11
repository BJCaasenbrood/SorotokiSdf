function r = minus(obj1, varargin)
    obj2 = varargin{1};
    fnc = @(x) dDiff(obj1.sdf(x), obj2.sdf(x));
    r = Sdf(fnc);
    r.BdBox = obj1.BdBox;
end
