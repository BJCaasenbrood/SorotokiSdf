function r = shell(obj,T)
    fnc = @(x) abs(obj.sdf(x)) - T/2;
    r = Sdf(fnc);
    eps = 1;
    B = obj.BdBox;
    if numel(obj.BdBox) == 6
        r.BdBox = [B(1) - T/2 - eps, B(2) + T/2 + eps,...
                   B(3) - T/2 - eps, B(4) + T/2 + eps,...
                   B(5) - T/2 - eps, B(6) + T/2 + eps];
    else
        r.BdBox = [B(1) - T/2-eps, B(2) + T/2+eps,...
                   B(3) - T/2-eps, B(4) + T/2+eps];
    end
    
end