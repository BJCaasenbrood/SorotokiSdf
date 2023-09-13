function r = smoothdiff(obj1,obj2,varargin)
    if isempty(varargin), k = 1;
    else, k = varargin{1};
    end
        
    fnc = @(x) dSmoothDiff(obj1.sdf(x),obj2.sdf(x),k);
    r = Sdf(fnc);
    B1 = box2node(obj1.BdBox); 
    B2 = box2node(obj2.BdBox);
    
    if norm(B1) == Inf
        r.BdBox = B2;
    elseif norm(B2) == Inf
        r.BdBox = B1;
    else
        B = [box2node(obj1.BdBox); box2node(obj2.BdBox)];
        r.BdBox = boxhull(B);
    end
end  