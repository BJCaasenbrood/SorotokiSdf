function C = centerofmass(Sdf,varargin)

    Sdf = vararginParser(Sdf,varargin{:});    
    
    Q = Sdf.options.Quality;
    C = zeros(numel(Sdf.BdBox)/2,1);
    x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Q);
    y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Q);
    
    if numel(Sdf.BdBox) < 6
        [X,Y] = meshgrid(x,y);
        V =  [X(:),Y(:)];
    else
        z = linspace(Sdf.BdBox(5),Sdf.BdBox(6),Q);
        [X,Y,Z] = meshgrid(x,y,z);
        V = [X(:),Y(:),Z(:)];
    end
    
    I = Sdf.intersect(V);
    
    for ii = 1:numel(C)
       C(ii) = mean(V(I,ii));
    end
        
end