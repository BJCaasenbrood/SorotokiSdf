function r = smoothunion(obj1,obj2,varargin)
    if isempty(varargin), k = 1;
    else, k = varargin{1};
    end
        
    fnc = @(x) dSmoothUnion(obj1.sdf(x),obj2.sdf(x),k);
    r = Sdf(fnc);
    B1 = box2node(obj1.BdBox); 
    B2 = box2node(obj2.BdBox);
    
    if norm(B1) == Inf
        r.BdBox = B2;
    elseif norm(B2) == Inf
        r.BdBox = B1;
    else
        B = (1 + k/5)*[B1;B2];
        r.BdBox = boxhull(B);
    end
end    