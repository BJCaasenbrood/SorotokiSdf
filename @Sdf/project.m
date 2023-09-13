function P = project(Sdf,p0)

    P = zeros(size(p0));
    
    for ii = 1:size(p0,1)
        Nd = p0(ii,:);
        Dist = 1e3;
        jj = 1;
        while abs(Dist) > 1e-2 && jj < 100
            D = Sdf.eval(Nd); 
            [~,N] = normal(Sdf,[Nd; Nd]);
            Dist = D(end);
            Nd = Nd - 0.99*N(end,:)*Dist;
            jj = jj + 1;
        end
        
        P(ii,:) = Nd;
    end        

end