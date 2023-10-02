% SPOLYLINE Creates a polyline in 2D space.
%
%   sdf = sPolyline(X)
%
%   This function creates a polyline in 2D space. The polyline is defined
%   by a set of points specified in the input argument X.
%
% Input:
%   X - Matrix of size N-by-2, where N is the number of points in the
%       polyline. Each row of X represents the coordinates of a point in
%       the polyline.
%
%   Example:
%       X = linspace(pi, 3*pi, 100).';
%       Y = sin(X);
%       sdf = sPolyline([X(:), Y(:)]);
%       sdf.show();
%
%   See also SDF, SPOLYLINE, SLINE

function sdf = sPolyline(X)

sdf = Sdf(@(P) sdfLine(P,X));
sdf.BdBox = [min(X(:,1)), max(X(:,1)),...
             min(X(:,2)), max(X(:,2))];

end
%------------------------------------------------------------- Vector Class
function d = sdfLine(P,X)

Tvec = TangentField(X);

if size(P,2) == 3
   P = P(:,[1,2]); 
end

[XY,D,I] = distance2curve(X,P,'linear');
s = linspace(0,1,size(X,1)).';
F = griddedInterpolant(s,Tvec);

N = F(I);

dr = XY - P;
dr = dr./sqrt((sum((dr.^2),2)));
dr(:,3) = 0; 
N(:,3)  = 0;

so  = cross(N,dr);
dir = zeros(size(so,1),1);

for ii = 1:size(so,1)
   dir(ii) = sign(-dot(so(ii,:), [0,0,1]));
   if dir(ii) == 0 && ii > 2
       dir(ii) = dir(ii - 1);
   end
end

d = dir.*[D,D];

end
%------------------------------------------------------------- Vector Class
function T = TangentField(PS1)
[~, Fy] = gradient(PS1);
T = [Fy(:,1), Fy(:,2)];
T = T ./ sqrt((sum((T.^2),2)));
end