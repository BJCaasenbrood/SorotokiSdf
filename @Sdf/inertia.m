function [Jtt, Att] = inertia(Sdf,varargin)
% INERTIA calculates the second-moment of inertia tensor and slice volume 
% for a given function Sdf.
%
% INPUTS:
%   - Sdf: 2D or 3D Sdf class
%
% OUTPUTS:
%   - Jtt: Second-moment of inertia tensor. A 3x3 matrix where each element
%     represents the moment of inertia about a particular axis.
%   - Att: Slice volume. Total volume of the slice.
%
% USAGE:
%   [Jtt, Att] = inertia(Sdf)
%
% EXAMPLE:
%   % Define signed distance function
%   Sdf = sCircle;
%   Sdf.options.Center = [0, 0];
%   Sdf.options.Quality = 100;
%   Sdf.BdBox = [-1, 1, -1, 1];
%   Sdf.eval = @(points) sqrt(points(:,1).^2 + points(:,2).^2) - 0.5;
%
%   % Calculate inertia and slice volume
%   [Jtt, Att] = inertia(Sdf);
%
% REFERENCES:
%   - Lecture notes from MIT course 16-07 Dynamics, Fall 2009:
%     https://ocw.mit.edu/courses/aeronautics-and-astronautics/16-07-dynamics-fall-2009/lecture-notes/MIT16_07F09_Lec26.pdf    

    % parse arguments to Sdf
    Sdf = vararginParser(Sdf,varargin{:});
    
    % set the quality of the ineratia estimation
    Q = Sdf.options.Quality;

    % genere mesh grid
    x0 = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Q);
    y0 = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Q);
    [X0,Y0] = meshgrid(x0,y0);
    
    % get tangent-sub volume
    dv = (x0(2) - x0(1))*(y0(2) - y0(1));
    
    % generate image from cross-section
    D   = Sdf.eval([X0(:),Y0(:)]);
    rho = (D(:,end)<1e-5);
    
    I0 = reshape(rho,[Q,Q]);
    
    % https://ocw.mit.edu/courses/aeronautics-and-astronautics/
    % 16-07-dynamics-fall-2009/lecture-notes/MIT16_07F09_Lec26.pdf
    x0 = x0 - Sdf.options.Center(1);
    y0 = y0 - Sdf.options.Center(2);
    X0 = X0 - Sdf.options.Center(1);
    Y0 = Y0 - Sdf.options.Center(2);
    
    % evaluate slice volume
    Att = sum(sum(I0*dv));
    
    % evaluate 2nd-moment inertia
    Jxx = trapz(y0,trapz(x0,(Y0.^2).*I0,2))/Att;
    Jyy = trapz(y0,trapz(x0,(X0.^2).*I0,2))/Att;
    Jzz = trapz(y0,trapz(x0,(X0.^2 + Y0.^2).*I0,2))/Att;
    
    Jxy = trapz(y0,trapz(x0,(X0.*Y0).*I0,2))/Att;
    Jxz = trapz(y0,trapz(x0,(X0.*Y0).*I0,2))/Att;
    Jyz = trapz(y0,trapz(x0,(X0.*Y0).*I0,2))/Att;
    
    % assemble inertia tensor
    Jtt = [Jxx, Jxy, Jxz; 
           Jxy, Jyy, Jyz;
           Jxz, Jyz, Jzz];

    Jtt = (Jtt.' + Jtt) * 0.5;
end   