% DCUBE   Calculate the distances from a point to the boundaries of a cube.
%
%   d = dCube(P, x1, x2, y1, y2, z1, z2) calculates the distances from each
%   point in P to the boundaries of a cube defined by the minimum and
%   maximum values in the x, y, and z directions. The minimum and maximum
%   values are specified by x1, x2, y1, y2, z1, and z2 respectively. The
%   resulting distances are returned as d.
%
function d = dCube(P,x1,x2,y1,y2,z1,z2)
d = [x1-P(:,1) + 1e-12, P(:,1)-x2, y1-P(:,2)+1e-12, P(:,2)-y2, z1-P(:,3)+1e-12, P(:,3)-z2];
d = [d,max(d,[],2)];
end