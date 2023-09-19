function [N,T,B,Z] = gradient(Sdf,x)
% gradient - Computes the differential vector field of SDF function
%
% Syntax:
%   [N, T, B, Z] = gradient(Sdf, x)
%
% Inputs:
%   - Sdf: A structure containing the scalar field and options.
%     - sdf: A function handle that computes the scalar field value at given points.
%     - options: A structure containing various options.
%       - StepTolerance: The step size for numerical differentiation.
%   - x: An array of points at which to compute the normal vector.
%
% Outputs:
%   - N: An array representing the normal vector at each point in x.
%   - T: An array representing the tangent vector at each point in x.
%   - B: An array representing the binormal vector at each point in x.
%   - Z: An array representing the angle between the normal vector and the x-axis.
%
% Notes:
%   - This function computes the normal vector of a scalar field using finite differences.
%   - The inputs must satisfy certain requirements:
%     - The scalar field function 'sdf' should accept an array of points as input and return an array of scalar field values.
%     - The options structure 'options' should contain the field 'StepTolerance' specifying the step size for numerical differentiation.
%     - The array of points 'x' should be in the format [x1, y1, z1; x2, y2, z2; ...] where each row represents a point.
%
% Example:
%   Sdf = sCircle; % circl sdf function
%   Sdf.options.StepTolerance = 0.001; % Set the step size for numerical differentiation.
%   x = [1, 2, 3; 4, 5, 6; 7, 8, 9]; % Replace with your own array of points.
%   [N, T, B, Z] = gradient(Sdf, x);    

    % eval sdf function to get distance
    d = Sdf.sdf(x);
    N = zeros(size(x,1),3);
    
    eps = Sdf.options.StepTolerance;
    
    % computes normal using finite difference method
    if size(x,2) == 2
        n1 = (Sdf.sdf(x+repmat([eps,0],size(x,1),1))-d)/eps;
        n2 = (Sdf.sdf(x+repmat([0,eps],size(x,1),1))-d)/eps;
        N(:,1) = n1(:,end);
        N(:,2) = n2(:,end);
    else
        n1 = (Sdf.sdf(x+repmat([eps,0,0],size(x,1),1))-d)/eps;
        n2 = (Sdf.sdf(x+repmat([0,eps,0],size(x,1),1))-d)/eps;
        n3 = (Sdf.sdf(x+repmat([0,0,eps],size(x,1),1))-d)/eps;
        N(:,1) = n1(:,end);
        N(:,2) = n2(:,end);
        N(:,3) = n3(:,end);
    end
    
    % ensure it's unit
    N = N./sqrt((sum((N.^2),2)) + 1e-6 );
    T = ( [0,1,0;-1,0,0;0,0,1] * N.' ).';
    B = cross(N,T);

    Z = atan2(N(:,2).*sign(-d(:,end)),N(:,1).*sign(-d(:,end)));
end