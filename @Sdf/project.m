function P = project(Sdf,p0)

    P = zeros(size(p0));
    eps = 1e-12;
    for ii = 1:size(p0,1)
        Nd = p0(ii,:);
        n  = numel(Nd);
        Dist = 1e3;
        jj = 1;
        while abs(Dist) > 1e-2 && jj < 100
            D = Sdf.eval(Nd); 
            N = gradient(Sdf,[Nd; Nd]);
            Dist = D(end);
            Nd = Nd - (1-eps) * N(end,1:n) * Dist;
            jj = jj + 1;
        end
        
        P(ii,:) = Nd;
    end        

end