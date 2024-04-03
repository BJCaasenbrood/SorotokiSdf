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
        B = [B1;B2];
        r.BdBox = boxhull(B);
    end
end    

function d = dSmoothUnion(d1,d2,k)
    f1 = d1(:,end); %F1 = num2cell(f1); 
    f2 = d2(:,end); %F2 = num2cell(f2);
    h = max(k-abs(f1-f2), 0.0 );
    d = min(f1, f2) - h.*h.*h/(6.0*k*k);
    d = [d1, d2, d];
end