function varargout = export(Sdf, filename, varargin)

    if nargin < 2
        filename = 'test';
    end

    if numel(Sdf.BdBox) == 6

        if ~contains(filename,'.stl')
            filename = [filename,'.stl'];
        end

        %enlarge bdbox by 2%
        Sdf = enlargeBdBox(Sdf, Sdf.options.StepTolerance);
        obj = Gmodel(Sdf,'Quality',...
            Sdf.options.Quality,varargin{:});

        FV = triangulation(obj.Element, obj.Node);
        stlwrite(FV,filename,'text');
    else

        if ~contains(filename,'.png')
            filename = [filename,'.png'];
        end
        
        I = makeSdfIso(Sdf);
        varargout{1} = I;
    end
end

function Sdf = enlargeBdBox(Sdf, per)
    B = Sdf.BdBox(:).';
    dim = length(B) / 2;                                                
    delta = per * (B(dim+1:end) - B(1:dim)) / 2;               
    Sdf.BdBox = [B(1:dim)-delta, B(dim+1:end)+delta];
end

function I = makeSdfIso(Sdf)

    Q = Sdf.options.Quality;

    if numel(Q) < 2
        Q = [Q, Q];
    end

    x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Q(1));
    y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Q(2));

    [X,Y] = meshgrid(x,y);

    D = Sdf.eval([X(:),Y(:)]);
    D = abs(D(:,end)).*sign(D(:,end));
    
    V = [X(:), Y(:)];
    V = V(D<0,:);
    I1 = D>0;
    I2 = ~I1;

    D(I1) = 255;
    D(I2) = 0;
    % D(D<=0) = 1;
    % D(D>0)  = 0;
    
    % figure(101);
    % h = cplane(X,Y,reshape(D,[Q Q])-1e-6);
    I = reshape(D,[Q(1), Q(2)]);
end