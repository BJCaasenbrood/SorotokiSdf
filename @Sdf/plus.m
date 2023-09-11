function r = plus(obj1,obj2)
    if ~isempty(obj2)
        r = Sdf(@(x) dUnion(obj1.sdf(x),obj2.sdf(x)));
    else
        r = obj1;
        obj2 = obj1;
    end
    
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
    r.BdBox = (r.BdBox(:)).';
end