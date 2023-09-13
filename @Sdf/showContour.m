function [h, V] = showContour(Sdf,varargin)
    
    for ii = 1:2:length(varargin)
        Sdf.options.(varargin{ii}) = varargin{ii+1};
    end
    
    Q = Sdf.options.Quality;

    x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Q);
    y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Q);
    
    if numel(Sdf.BdBox) < 6

        [X,Y] = meshgrid(x,y);

        D = Sdf.eval([X(:),Y(:)]);
        D = abs(D(:,end)).^(0.75).*sign(D(:,end));
        
        V = [X(:),Y(:)];
        V = V(D<1e-6,:);
        D(D>1e-6) = NaN;
        
        figure(101);
        h = cplane(X,Y,reshape(D,[Q Q])-1e-6);
        axis equal; hold on;
        I = frame2im(getframe(gca));
        
        hh = contour3(X,Y,reshape(D,[Q Q]),...
            [-2e6 -1e-6],'k');
        
        axis(Sdf.BdBox*1.01);

        colormap([Sdf.options.Color; Sdf.options.Color]);
        view(0,90);
        drawnow;
        %I = frame2im(getframe(gca));
        
    else
        hold on;
        h = patch('Vertices',Sdf.Node,'Faces',Sdf.Element,...
            'FaceColor','none','LineW',3);
    end
end