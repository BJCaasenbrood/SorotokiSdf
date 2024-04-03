function sdf = sCube(varargin)
% SCUBE This function creates a signed distance field (SDF) for a cube.
%
%   sdf = sCube() an SDF for a unit cube centered at the origin.
%   sdf = sCube(a) a cube with side length 2*a centered at the origin.
%   sdf = sCube(X,Y) a cube defined by the coordinates of 
%       two opposite corners: [x1, y1, z1] and [x2, y2, z2].
%   sdf = sCube(X1, X2, Y1, Y2, Z1, Z2) creates an SDF for a cube defined
%       by the coordinates of two opposite corners: [X1, Y1, Z1] and [X2, Y2, Z2].
%
%   Input:
%       - varargin: Variable number of input arguments.
%           - a: Side length of the cube. Default is 0.5.
%           - X, Y: Coordinates of two opposite corners of the cube: [x1, y1, z1] and [x2, y2, z2].
%           - X1, X2, Y1, Y2, Z1, Z2: Coordinates of two opposite corners of the cube: [X1, Y1, Z1] and [X2, Y2, Z2].
%
%   Output:
%       - sdf: Signed distance field (SDF) for the cube.
%
% Example usage:
%   sdf = sCube(); % Creates an SDF for a unit cube centered at the origin.
%   sdf = sCube(1); % Creates an SDF for a cube with side length 2 centered at the origin.
%   sdf = sCube([0, 0, 0], [1, 1, 1]); % Creates an SDF for a cube defined by two opposite corners: [0, 0, 0] and [1, 1, 1].
%   sdf = sCube(0, 1, 0, 1, 0, 1); % Creates an SDF for a cube defined by two opposite corners: [0, 0, 0] and [1, 1, 1].
%
% See also: dCube

a = 0.5; 
x1 = -a; 

if isempty(varargin)
    x1 = -a; x2 = a; 
    y1 = -a; y2 = a; z1 = -a;
    z2 = a;
elseif numel(varargin{1}) == 1 && numel(varargin) == 1
    a = varargin{1}; x1 = -a; x2 = a; 
    y1 = -a; y2 = a; z1 = -a;
    z2 = a;
elseif numel(varargin{1}) == 1 && numel(varargin) == 2
    a = varargin{1}; 
    p = varargin{2}; 
    
    x1 = -a + p(1); x2 = a + p(1); 
    y1 = -a + p(2); y2 = a + p(2);
    z1 = -a + p(3); z2 = a + p(3);
elseif numel(varargin{1}) == 3 && numel(varargin{2}) == 3
    X = varargin{1}; 
    Y = varargin{2}; 
    x1 = X(1); x2 = Y(1);
    y1 = X(2); y2 = Y(2);
    z1 = X(3); z2 = Y(3);   
elseif numel(varargin{1}) == 3
    X = varargin{1}; 
    x1 = 0; x2 = X(1);
    y1 = 0; y2 = X(2);
    z1 = 0; z2 = X(3);
else
    X = x1; x1 = X(1); x2 = X(2);
    y1 = X(3); y2 = X(4);
    z1 = X(5); z2 = X(6);
end

sdf = Sdf(@(P) sdfCube(P,x1,x2,y1,y2,z1,z2));
sdf.BdBox = [x1-1e-6,x2+1e-6,....
             y1-1e-6,y2+1e-6,...
             z1-1e-6,z2+1e-6];
         
end

function d = sdfCube(P,x1,x2,y1,y2,z1,z2)
d = [x1-P(:,1) + 1e-12, P(:,1)-x2, y1-P(:,2)+1e-12, P(:,2)-y2, z1-P(:,3)+1e-12, P(:,3)-z2];
d = [d, max(d,[],2)];
end
