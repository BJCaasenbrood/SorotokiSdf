function sdf = sGyroid2D(varargin)
% SGYROID2D This function generates a 2D gyroid structure.
%
%   sdf = sGyroid2D() generates a 2D gyroid structure with default parameters.
%   sdf = sGyroid2D(w) generates a 2D gyroid structure with the specified frequency w.
%   sdf = sGyroid2D(w, r) generates a 2D gyroid structure with the specified frequency w and thickness r.
%
%   Input:
%       - varargin: Variable number of input arguments.
%           - w: Frequency of the gyroid structure (default: 2*pi).
%           - r: Thickness of the gyroid structure (default: 0.75).
%
%   Output:
%       - sdf: Signed distance field representing the gyroid structure.
%
%   Example:
%       sdf = sGyroid2D(); % Generates a 2D gyroid structure with default parameters.
%       sdf = sGyroid2D(3); % Generates a 2D gyroid structure with frequency 3.
%       sdf = sGyroid2D(3, 1.5); % Generates a 2D gyroid structure with frequency 3 and thickness 1.5.
%
% See also: dSchwarz, Sdf, sSchwartz2D

r  = 0.75;
w  = 2*pi;
xc = 0;
yc = 0;

if nargin == 1
    w  = abs(varargin{1}) * 2 * pi;  % set the frequency
elseif nargin == 2
    w  = abs(varargin{1}) * 2 * pi; % set the frequency
    r  = abs(varargin{1});  % set thickeness of gyroid structure
end

eps = 1e-4*r;
sdf = Sdf(@(P) dGyroid(P,r,w));
sdf.BdBox = [xc - w/pi - eps, xc + w/pi + eps, ...
             yc - w/pi - eps, yc + w/pi + eps]/2;

sdf.options.Quality = 200;
end

function d = dGyroid(P,r,w)
Z = pi;

x = P(:,1);
y = P(:,2);

d = abs(sin(w * x) .* cos(w * y) + sin(w * y)*cos(w*Z) + sin(w*Z)*cos(w*x)) - r;
d = [d,d];
end