function r = shell(obj,T)
    fnc = @(x) abs(obj.sdf(x)) - T/2;
    r = Sdf(fnc);
    
    B = obj.BdBox;
    if numel(obj.BdBox) == 6
        r.BdBox = [B(1) - T/2, B(2) + T/2,...
                   B(3) - T/2, B(4) + T/2,...
                   B(5) - T/2, B(6) + T/2];
    else
        r.BdBox = [B(1) - T/2, B(2) + T/2,...
                   B(3) - T/2, B(4) + T/2];
    end
end