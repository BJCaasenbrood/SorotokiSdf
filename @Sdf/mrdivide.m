function r = mrdivide(obj1,obj2)
    fnc = @(x) dIntersect(obj1.sdf(x),obj2.sdf(x));
    r = Sdf(fnc);
    B1 = box2node(obj1.BdBox); 
    B2 = box2node(obj2.BdBox);
    
    if norm(B1) == Inf
        r.BdBox = B2;
    elseif norm(B2) == Inf
        r.BdBox = B1;
    else
        B = [box2node(obj1.BdBox); 
             box2node(obj2.BdBox)];
        r.BdBox = boxhull(B);
    end
end