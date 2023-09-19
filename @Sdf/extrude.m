function out = extrude(obj1,varargin)
% EXTRUDE extrudes a 2D shape to create a 3D shape.
%
%   R = EXTRUDE(OBJ1, Z1) extrudes the 2D shape represented by OBJ1 along the 
%   z-axis from z=0 to z=1. 
%
%   R = EXTRUDE(OBJ1, Z1, Z2) extrudes the 2D shape represented by OBJ1 
%   along the z-axis from z=Z1 to z=Z2. Z1 and Z2 are scalar values 
%   specifying the start and end heights of the extrusion, respectively.
%
%   Input arguments:
%   - obj1: 2D Sdf class;
%   - varargin: Variable number of input arguments.
%       * If numel(varargin) == 1, Z1 is set to 0 and Z2 is set to varargin{1}.
%       * If numel(varargin) == 2, Z1 is set to varargin{1} and Z2 is set to varargin{2}.
%
%   Output arguments:
%   - out: 3D shape object representing the extruded shape.
%
%   Example:
%      obj1 = ... % define the 2D shape object
%      extrudedObj = extrude(obj1);
%      extrudedObj.show();
%
%   See also REVOLVE.

    if numel(varargin) == 1
        z1 = 0;
        z2 = varargin{1};
    else
        z1 = varargin{1};
        z2 = varargin{2};
    end
    
    function d = Extrude(P,obj1,z1,z2)
        d1 = obj1.eval(P(:,1:2));
        d1 = d1(:,end);
        d2 = z1-P(:,3);
        d3 = P(:,3)-z2;
        F1 = sqrt(d1.^2 + d2.^2);
        F2 = sqrt(d1.^2 + d3.^2);
        F3 = max([d1,d2,d3],[],2);
        L1 = (d1 >= 0 & d2 >=0);
        L2 = (d1 >= 0 & d3 >=0);
        L3 = ~(L1 + L2);
    
        d = F1.*L1 + F2.*L2 + F3.*L3;
    end
    
    fnc = @(x) Extrude(x,obj1,z1,z2);
    
    out = Sdf(fnc);
    out.BdBox  = [obj1.BdBox,z1,z2];
end