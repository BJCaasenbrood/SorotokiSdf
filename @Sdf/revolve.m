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
      else
            rot = 2 * pi;
      end

      fnc = @(x) obj1.eval(dRevolve(x, rot, true));
      r = Sdf(fnc);
      r.BdBox = [-obj1.BdBox(2),obj1.BdBox(2),...
                  -obj1.BdBox(2),obj1.BdBox(2),...
                  obj1.BdBox(3),obj1.BdBox(4)];
end

%%
function y = dRevolve(x, rot, flip)
   if nargin == 3
         if islogical(flip), x = (roty(pi/2)*x.').';
         else, x = (roty(flip)*x.').';
         end
   end

   [th,r,z] = cart2pol(x(:,2),x(:,3),x(:,1));
   if nargin == 1
         y = [r(:), z(:)];
   else
         if numel(rot) == 1
            rot = sort([0, rot]);
         end
            
      %    Id = th > rot(1) & th < rot(2);
         
         [X,Y,Z] = pol2cart(th,r,z);
         [~,r,z] = cart2pol(X,Y,Z);
         y = [r(:), z(:)];
      %    y(Id,1) = y(Id,1) * 1e6;
   end
end
   