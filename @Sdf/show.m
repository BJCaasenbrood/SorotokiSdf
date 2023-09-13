function show(Sdf,varargin)

    for ii = 1:2:length(varargin)
        Sdf.(varargin{ii}) = varargin{ii+1};
    end
    
    Q = Sdf.options.Quality;
    x = linspace(Sdf.BdBox(1),Sdf.BdBox(2), Q);
    y = linspace(Sdf.BdBox(3),Sdf.BdBox(4), Q);
    
    if numel(Sdf.BdBox) < 6
        [X,Y] = meshgrid(x,y);
    
        D = Sdf.eval([X(:),Y(:)]);
        D = abs(D(:,end)).^(0.75).*sign(D(:,end));
    
        figure(101);
        cplane(X,Y,reshape(D,[Q, Q]) - 1e-6);
        axis equal; hold on;
    
        contour3(X,Y,                                                       ...
            reshape(D,[Q, Q]),                                              ...
            [0 0],'linewidth', 2.5, 'Color', 'w');
    
        view(0,90);
    else
        z = linspace(Sdf.BdBox(5),Sdf.BdBox(6),Q);
        [X,Y,Z] = meshgrid(x,y,z);
    
        D = Sdf.eval([X(:),Y(:),Z(:)]);
        D = D(:,end);
        D(D>0) = NaN;
        figure(101);
        C = reshape(D,[Q, Q, Q]);
        scatter3(X(:),Y(:),Z(:),85,C(:),'Marker','.');
        axis equal; hold on;
    end
    
    axis(Sdf.BdBox);
    colormap(Sdf.options.ColorMap);
    
end