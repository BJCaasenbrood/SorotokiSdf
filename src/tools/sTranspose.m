function r = sTranspose(obj1)
            
    B = obj1.BdBox;
    if numel(B) == 4
        fnc = @(x) obj1.sdf([x(:,2),x(:,1)]);
        r = Sdf(fnc);
        r.BdBox = [B(3), B(4), B(1), B(2)];
    else
        fnc = @(x) obj1.sdf([x(:,2),x(:,3),x(:,1)]);
        r = Sdf(fnc);
        r.BdBox = [B(5), B(6), B(3), B(4), B(1), B(2)];
    end
    
end