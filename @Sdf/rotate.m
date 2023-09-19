function r = rotate(obj1,varargin)
% ROTATE Rotate an object in 2D or 3D space.
%
%   r = rotate(obj1) rotates the object obj1 by pi/2 radians around the z-axis.
%   r = rotate(obj1, Rot, angle) rotates the object obj1 by the specified angle
%   (in degrees) around the specified rotation axis.
%
%   Input:
%   - obj1: The object to be rotated.
%   - Rot:  Optional. A character specifying the rotation axis ('x', 'y', or 'z').
%           Default is an empty string (''), which corresponds to a 2D rotation.
%   - angle: The angle of rotation in degrees. Default is pi/2 radians.
%
%   Output:
%   - r: The rotated object.
%
%   Example:
%   % Rotate a 2D object by 45 degrees around the origin
%   obj = ...; % create the SDF object
%   r = rotate(obj, 45);
%
%   % Rotate a 3D object by 90 degrees around the y-axis
%   obj = ...; % create the SDF object
%   r = rotate(obj, 'y', 90);
%
%   See also rotx, roty, rotz, rot2d, Sdf, box2node, boxhull.    
            
    Rot = [];
    if isempty(varargin)
        k = pi/2;
    else
        if isa(varargin{1},'char')
            Rot = varargin{1};
            k = deg2rad(varargin{2});
        else
            k = deg2rad(varargin{1});
            Rot = '';
        end
    end
    
    switch(Rot)
        case('x'), R = rotx(k);
        case('y'), R = roty(k);
        case('z'), R = rotz(k);
        otherwise, R = rot2d(k);
    end
    
    fnc = @(x) obj1.sdf((R*x.').');
    r   = Sdf(fnc);
    BB  = box2node(obj1.BdBox);
    
    r.BdBox = boxhull((R.'*BB.').').';
end  