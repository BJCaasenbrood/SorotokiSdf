function r = revolve(obj1,varargin)
% REVOLVE Revolve an object around a specified axis.
%
%   r = revolve(obj1) revolves the object obj1 around the default axis.
%   r = revolve(obj1, rot) revolves the object obj1 around the specified axis.
%
%   Input arguments:
%   - obj1: The object to be revolved.
%   - rot:  Optional. The axis of revolution.
%
%   Output argument:
%   - r: The revolved object.
%
%   Example:
%   % Revolve a 2D object around the default axis
%   obj = ...; % create the object
%   out = revolve(obj);
%
%   % Revolve a 3D object around the y-axis
%   obj = ...; % create the object
%   out = revolve(obj, 'y');
%
%   See also dRevolve, Sdf.

    if ~isempty(varargin)
       rot = varargin{1};
    end
    
    fnc = @(x) obj1.eval(dRevolve(x,rot));
    r   = Sdf(fnc);
    r.BdBox = [-obj1.BdBox(2),obj1.BdBox(2),...
               -obj1.BdBox(2),obj1.BdBox(2),...
                obj1.BdBox(3),obj1.BdBox(4)];
ends