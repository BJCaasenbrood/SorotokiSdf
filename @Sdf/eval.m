function d = eval(Sdf,x)
% EVAL Evaluate a signed distance function at a given point.
%
%   d = EVAL(Sdf, x) evaluates the signed distance function Sdf at the 
%   point x and returns the result in d.
%
%   Input arguments:
%   - Sdf: A struct representing the signed distance function.
%   - x: The point at which the signed distance function is evaluated.
%
%   Output argument:
%   - d: The value of the signed distance function at the given point.
%
%   See also SDF

    if ~isempty(Sdf.options.Rotation)
       R = rot3d(Sdf.options.Rotation);
       x = (R*x.').';
    end
        
    d = Sdf.sdf(x);
end