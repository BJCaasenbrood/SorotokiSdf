function [Jtt, Att] = inertia(Sdf,varargin)

    Sdf = vararginParser(Sdf,varargin{:});

    Q = Sdf.options.Quality;

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
    
    Jtt = [Jxx, Jxy, Jxz; 
           Jxy, Jyy, Jyz;
           Jxz, Jyz, Jzz];

    Jtt = (Jtt.' + Jtt) * 0.5;
end   