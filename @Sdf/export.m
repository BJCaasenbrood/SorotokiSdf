function export(Sdf,filename,varargin)

    if ~contains(filename,'.stl')
        filename = [filename,'.stl'];
    end

    %enlarge bdbox by 2%
    Sdf = enlargeBdBox(Sdf, Sdf.options.StepTolerance)
    obj = Gmodel(Sdf,'Quality',...
        Sdf.options.Quality,varargin{:});

    FV = struct;
    FV.vertices = obj.Node;
    FV.faces    = obj.Element;

    stlwriter(filename, FV);
end

function Sdf = enlargeBdBox(Sdf, per)
    B = Sdf.BdBox(:).';
    dim = length(B) / 2;                                                
    delta = per * (B(dim+1:end) - B(1:dim)) / 2;               
    Sdf.BdBox = [B(1:dim)-delta, B(dim+1:end)+delta];
end