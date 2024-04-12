function [h, V] = showContour(Sdf,varargin)
    
    for ii = 1:2:length(varargin)
        Sdf.options.(varargin{ii}) = varargin{ii+1};
    end
    
    Q = Sdf.options.Quality;

    if numel(Q) == 1
        Q = [Q, Q];
    end

    x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Q(1));
    y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Q(2));
    
    if numel(Sdf.BdBox) < 6

        [X,Y] = meshgrid(x,y);

        D = Sdf.eval([X(:),Y(:)]);
        D = abs(D(:,end)).*sign(D(:,end));
        
        V = [X(:), Y(:)];
        V = V(D<-0,:);
        D(D>-0) = NaN;
        
        figure(101);
        h = cplane(X,Y,reshape(D,[Q(2), Q(1)]));
        axis equal; hold on;
        I = frame2im(getframe(gca));
        
        axis(Sdf.BdBox);
        colormap([Sdf.options.Color; Sdf.options.Color]);
        view(0,90);
        drawnow;       
    else
        hold on;
        h = patch('Vertices',Sdf.Node,'Faces',Sdf.Element,...
            'FaceColor','none','LineW',3);
    end
end