function Sdf = render(Sdf,varargin)
    if numel(Sdf.BdBox) > 4
        figure(101);
        view(30,30);

        %enlarge bdbox by 2%
        Sdf = enlargeBdBox(Sdf, Sdf.options.StepTolerance);
        obj = Gmodel(Sdf,'Quality',...
            Sdf.options.Quality,varargin{:});
        obj.bake.render();
        Sdf.Gmodel = obj;
    else
        showContour(Sdf,varargin{:});
    end
end

function Sdf = enlargeBdBox(Sdf, per)
    B = Sdf.BdBox(:).';
    dim = length(B) / 2;                                                
    delta = per * (B(dim+1:end) - B(1:dim)) / 2;               
    Sdf.BdBox = [B(1:dim)-delta, B(dim+1:end)+delta];
end