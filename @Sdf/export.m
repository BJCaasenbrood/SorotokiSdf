function export(Sdf, filename, varargin)

    if nargin < 2
        filename = 'test';
    end

    if ~contains(filename,'.stl')
        filename = [filename,'.stl'];
    end

    %enlarge bdbox by 2%
    Sdf = enlargeBdBox(Sdf, Sdf.options.StepTolerance);
    obj = Gmodel(Sdf,'Quality',...
        Sdf.options.Quality,varargin{:});

    FV = triangulation(obj.Element, obj.Node);
    stlwrite(FV,filename,'text');
end

function Sdf = enlargeBdBox(Sdf, per)
    B = Sdf.BdBox(:).';
    dim = length(B) / 2;                                                
    delta = per * (B(dim+1:end) - B(1:dim)) / 2;               
    Sdf.BdBox = [B(1:dim)-delta, B(dim+1:end)+delta];
end