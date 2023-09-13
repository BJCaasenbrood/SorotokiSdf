function [Nds,X,Y] = sampleset(Sdf)

    if nargin < 2
        if numel(Sdf.BdBox) < 6
            Sdf.options.Quality = 250;
        else
            Sdf.options.Quality = 50;
        end
    end
    
    x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Sdf.options.Quality);
    y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Sdf.options.Quality);

    [X,Y] = meshgrid(x,y);
    Nds = [X(:), Y(:)];
    
end