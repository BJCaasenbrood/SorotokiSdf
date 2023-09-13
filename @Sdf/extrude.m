function r = extrude(obj1,varargin)
            
    if numel(varargin) == 1
        z1 = 0;
        z2 = varargin{1};
    else
        z1 = varargin{1};
        z2 = varargin{2};
    end
    
    function d = Extrude(P,obj1,z1,z2)
        d1 = obj1.eval(P(:,1:2));
        d1 = d1(:,end);
        d2 = z1-P(:,3);
        d3 = P(:,3)-z2;
        F1 = sqrt(d1.^2 + d2.^2);
        F2 = sqrt(d1.^2 + d3.^2);
        F3 = max([d1,d2,d3],[],2);
        L1 = (d1 >= 0 & d2 >=0);
        L2 = (d1 >= 0 & d3 >=0);
        L3 = ~(L1 + L2);
    
        d = F1.*L1 + F2.*L2 + F3.*L3;
    end
    
    fnc = @(x) Extrude(x,obj1,z1,z2);
    
    r = Sdf(fnc);
    r.BdBox  = [obj1.BdBox,z1,z2];
end