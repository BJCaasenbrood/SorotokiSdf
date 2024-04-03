function export(Sdf,filename,varargin)

    if ~contains(filename,'.stl')
        filename = [filename,'.stl'];
    end

    obj = Gmodel(Sdf,'Quality',...
        Sdf.options.Quality,varargin{:});

    FV = struct;
    FV.vertices = obj.Node;
    FV.faces    = obj.Element;

    stlwriter(filename, FV);
end