function C = centerofmass(Sdf,varargin)
% CENTEROFMASS calculates the center of mass for a given shape.
%
%   C = CENTEROFMASS(SDF) calculates the center of mass for the given 
%   shape defined by the signed distance function (SDF). The SDF can be 
%   provided as an input argument. 
%
%   C = CENTEROFMASS(SDF, Name, Value) specifies additional options using
%   name-value pairs:
%     - 'Quality': Specifies the number of points to use for sampling the
%       shape. Default value is 100.
%
%   Input arguments:
%   - Sdf: Signed distance function representing the shape.
%
%   Output arguments:
%   - C: Center of mass coordinates.
%
%   Example:
%      sdf = ... % define the signed distance function for the shape
%      com = centerofmass(sdf);
%      fprintf('The center of mass is located at (%f,%f).\n', com(1), com(2));
%
%   See also inertia.    

    Sdf = vararginParser(Sdf,varargin{:});    
    
    Q = Sdf.options.Quality;
    C = zeros(numel(Sdf.BdBox)/2,1);
    x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Q);
    y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Q);
    
    if numel(Sdf.BdBox) < 6
        [X,Y] = meshgrid(x,y);
        V =  [X(:),Y(:)];
    else
        z = linspace(Sdf.BdBox(5),Sdf.BdBox(6),Q);
        [X,Y,Z] = meshgrid(x,y,z);
        V = [X(:),Y(:),Z(:)];
    end
    
    I = Sdf.intersect(V);
    
    for ii = 1:numel(C)
       C(ii) = mean(V(I,ii));
    end
end