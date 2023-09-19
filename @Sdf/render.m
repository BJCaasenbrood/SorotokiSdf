function Sdf = render(Sdf,varargin)
    if numel(Sdf.BdBox) > 4
        figure(101);
        view(30,30);
        obj = Gmodel(Sdf,'Quality',...
            Sdf.options.Quality,varargin{:});
        obj.bake.render();
        Sdf.Gmodel = obj;
    else
        showContour(Sdf,varargin{:});
    end
end