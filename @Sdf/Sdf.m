classdef Sdf
 
properties
    sdf;
    BdBox;
    Gmodel;
    options;
end
    
%--------------------------------------------------------------------------    
    methods        
%---------------------------------------------------- Signed Distance Class     
        function obj = Sdf(f,varargin)
            obj.sdf      = @(x) [f(x), f(x)];          
            obj.options = sdfoptions;

            obj = vararginParser(obj,varargin{:});
        end
%---------------------------------------------------------------- intersect                
        function r = repeat(obj,dX,varargin)
            if isempty(varargin)
                N = 2;
            else
                N = varargin{1};
            end
                
            B = obj.BdBox(:);
            
            if numel(B) == 4
                if dX(2) == 0
                    A = (B + [0,(N-1)*dX(1),0,0].').';
                else
                    A = (B + [0,0,0,(N-1)*dX(2)].').';
                end

                Si = sRectangle(A(1),A(2),A(3),A(4));
            else
                if dX(2) == 0 && dX(3) == 0
                    A = (B + [0,(N-1)*dX(1),0,0,0,0].').';
                elseif dX(1) == 0 && dX(3) == 0
                    A = (B + [0,0,0,(N-1)*dX(2),0,0].').';
                else
                    A = (B + [0,0,0,0,0,(N-1)*dX(3)].').';
                end

                Si = sCube(A(1),A(2),A(3),A(4),A(5),A(6));
            end
            
            r = Sdf( @(x) dIntersect(obj.sdf(pRepeat(x,dX)), Si.sdf(x)));
            r.BdBox = A;

        end
%----------------------------------------------------------- rotate X <-> Y              
        function r = transpose(obj1)
            
            B = obj1.BdBox;
            if numel(B) == 4
                fnc = @(x) obj1.sdf([x(:,2),x(:,1)]);
                r = Sdf(fnc);
                r.BdBox = [B(3), B(4), B(1), B(2)];
            else
                fnc = @(x) obj1.sdf([x(:,2),x(:,3),x(:,1)]);
                r = Sdf(fnc);
                r.BdBox = [B(5), B(6), B(3), B(4), B(1), B(2)];
            end
            
        end
%----------------------------------------------------------- rotate X <-> Y              
        function r = rotate(obj1,varargin)
            
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
%----------------------------------------------------------- rotate X <-> Y              
        function r = smoothunion(obj1,obj2,varargin)
            if isempty(varargin), k = 1;
            else, k = varargin{1};
            end
                
            fnc = @(x) dSmoothUnion(obj1.sdf(x),obj2.sdf(x),k);
            r = Sdf(fnc);
            B1 = box2node(obj1.BdBox); 
            B2 = box2node(obj2.BdBox);
            
            if norm(B1) == Inf
                r.BdBox = B2;
            elseif norm(B2) == Inf
                r.BdBox = B1;
            else
                B = (1 + k/5)*[B1;B2];
                r.BdBox = boxhull(B);
            end
        end     
%----------------------------------------------------------- rotate X <-> Y              
        function r = smoothdiff(obj1,obj2,varargin)
            if isempty(varargin), k = 1;
            else, k = varargin{1};
            end
                
            fnc = @(x) dSmoothDiff(obj1.sdf(x),obj2.sdf(x),k);
            r = Sdf(fnc);
            B1 = box2node(obj1.BdBox); 
            B2 = box2node(obj2.BdBox);
            
            if norm(B1) == Inf
                r.BdBox = B2;
            elseif norm(B2) == Inf
                r.BdBox = B1;
            else
                B = [box2node(obj1.BdBox); box2node(obj2.BdBox)];
                r.BdBox = boxhull(B);
            end
        end          
%----------------------------------------------------------- rotate X <-> Y    
        function r = extrude(obj1,varargin)
            
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
            
            r = Sdf(fnc);
            r.BdBox  = [obj1.BdBox,z1,z2];
        end
%---------------------------------------------------------- revolve about Y  
        function r = revolve(obj1,varargin)
            
            if ~isempty(varargin)
               rot = varargin{1};
            end
            
            fnc = @(x) obj1.eval(dRevolve(x,rot));
            r   = Sdf(fnc);
            r.BdBox = [-obj1.BdBox(2),obj1.BdBox(2),...
                       -obj1.BdBox(2),obj1.BdBox(2),...
                        obj1.BdBox(3),obj1.BdBox(4)];
        end
%------------------------------------------------------- mirror about plane  
        function r = mirror(obj1,varargin)
            c = varargin{1};
            fnc = @(x) obj1.sdf(pMirror(x,c));
            r   = Sdf(fnc);
            r.BdBox = obj1.BdBox;

        end        
%----------------------------------------------------------- rotate X <-> Y    
        function r = shell(obj,T)
            fnc = @(x) abs(obj.sdf(x)) - T/2;
            r = Sdf(fnc);
            
            B = obj.BdBox;
            if numel(obj.BdBox) == 6
                r.BdBox = [B(1) - T/2, B(2) + T/2,...
                           B(3) - T/2, B(4) + T/2,...
                           B(5) - T/2, B(6) + T/2];
            else
                r.BdBox = [B(1) - T/2, B(2) + T/2,...
                           B(3) - T/2, B(4) + T/2];
            end
        end
    end
%--------------------------------------------------------------------------       
methods (Access = public)
%--------------------------------------------------------- evalution of SDF
function d = eval(Sdf,x)
if ~isempty(Sdf.options.Rotation)
   R = rot3d(Sdf.options.Rotation);
   x = (R*x.').';
end
    
d = Sdf.sdf(x);
end
%--------------------------------------------------------- evalution of SDF
function [y, I] = intersect(Sdf,x,varargin)
if isempty(varargin)
    delta = 0;
else
    delta = varargin{1} ;
end
d = Sdf.sdf(x);
y = d(:,end)<delta;

List = 1:numel(y);
I = List(y);
end
%--------------------------------------------------------- evalution of SDF
function [Nds,X,Y] = sampleSet(Sdf)
if nargin < 2
    if numel(Sdf.BdBox) < 6
        Sdf.options.Quality = 250;
    else
        Sdf.options.Quality = 50;
    end
end

x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Sdf.options.Quality);
y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Sdf.options.Quality);
[X,Y] = meshgrid(x,y);
Nds = [X(:), Y(:)];
end
%------------------------------------------------- evalution of tangent SDF
function [T,N,B,Z] = normal(Sdf,x)
d = Sdf.sdf(x);
N = zeros(size(x,1),3);

eps = Sdf.options.StepTolerance;

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

N = N./sqrt((sum((N.^2),2)) + 1e-3 );
T = ([0,1,0;-1,0,0;0,0,1]*N.').';
B = cross(T,N);
Z = atan2(N(:,2).*sign(-d(:,end)),N(:,1).*sign(-d(:,end)));
   
if size(x,2) == 2
    T = T(:,1:2);
    B = B(:,1:2);
    N = N(:,1:2);
end

end
%------------------------------------------------- evalution of tangent SDF
function C = centerofmass(Sdf,varargin)

Sdf = vararginParser(Sdf,varargin{:});    

Q = Sdf.options.Quality;
C = zeros(numel(Sdf.BdBox)/2,1);
x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Q);
y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Q);

if numel(Sdf.BdBox) < 6
    [X,Y] = meshgrid(x,y);
    V =  [X(:),Y(:)];
else
    z = linspace(Sdf.BdBox(5),Sdf.BdBox(6),Q);
    [X,Y,Z] = meshgrid(x,y,z);
    V = [X(:),Y(:),Z(:)];
end

I = Sdf.intersect(V);

for ii = 1:numel(C)
   C(ii) = mean(V(I,ii));
end
    
end
%---------------------------------------------------------- compute inertia
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
    Jxz = 0*trapz(y0,trapz(x0,(X0.*Y0).*I0,2))/Att;
    Jyz = 0*trapz(y0,trapz(x0,(X0.*Y0).*I0,2))/Att;
    
    Jtt = [Jxx, Jxy, Jxz; 
           Jxy, Jyy, Jyz;
           Jxz, Jyz, Jzz];

    Jtt = (Jtt.' + Jtt) * 0.5;
end   
%-------------------------------------------- find closest point on surface
function P = surfaceproject(Sdf,p0)

P = zeros(size(p0));

for ii = 1:size(p0,1)
    Nd = p0(ii,:);
    Dist = 1e3;
    jj = 1;
    while abs(Dist) > 1e-2 && jj < 100
        D = Sdf.eval([Nd]); 
        [~,N] = normal(Sdf,[Nd;Nd]);
        Dist = D(end);
        Nd = Nd - 0.99*N(end,:)*Dist;
        jj = jj + 1;
    end
    
    P(ii,:) = Nd;
end
    
end
%--------------------------------------------------------------------- show
function show(Sdf,varargin)

for ii = 1:2:length(varargin)
    Sdf.(varargin{ii}) = varargin{ii+1};
end

Q = Sdf.options.Quality;
x = linspace(Sdf.BdBox(1),Sdf.BdBox(2), Q);
y = linspace(Sdf.BdBox(3),Sdf.BdBox(4), Q);

if numel(Sdf.BdBox) < 6
    [X,Y] = meshgrid(x,y);

    D = Sdf.eval([X(:),Y(:)]);
    D = abs(D(:,end)).^(0.75).*sign(D(:,end));

    figure(101);
    cplane(X,Y,reshape(D,[Q, Q]) - 1e-6);
    axis equal; hold on;

    contour3(X,Y,                                                       ...
        reshape(D,[Q, Q]),                                              ...
        [0 0],'linewidth', 2.5, 'Color', 'w');

    view(0,90);
else
    z = linspace(Sdf.BdBox(5),Sdf.BdBox(6),Q);
    [X,Y,Z] = meshgrid(x,y,z);

    D = Sdf.eval([X(:),Y(:),Z(:)]);
    D = D(:,end);
    D(D>0) = NaN;
    figure(101);
    C = reshape(D,[Q, Q, Q]);
    scatter3(X(:),Y(:),Z(:),85,C(:),'Marker','.');
    axis equal; hold on;
end

axis(Sdf.BdBox);
colormap(Sdf.options.ColorMap);

end
%--------------------------------------------------------------------- show
function Sdf = render(Sdf,varargin)
obj = Gmodel(Sdf,'Quality',80,varargin{:});
obj.bake.render();    

Sdf.Gmodel = obj;
end
%------------------------------------------------------------- show contour
function [h, V] = showcontour(Sdf,varargin)
    
    for ii = 1:2:length(varargin)
        Sdf.options.(varargin{ii}) = varargin{ii+1};
    end
    
    Q = Sdf.options.Quality;

    x = linspace(Sdf.BdBox(1),Sdf.BdBox(2),Q);
    y = linspace(Sdf.BdBox(3),Sdf.BdBox(4),Q);
    
    if numel(Sdf.BdBox) < 6

        [X,Y] = meshgrid(x,y);

        D = Sdf.eval([X(:),Y(:)]);
        D = abs(D(:,end)).^(0.75).*sign(D(:,end));
        
        V = [X(:),Y(:)];
        V = V(D<1e-6,:);
        D(D>1e-6) = NaN;
        
        figure(101);
        h = cplane(X,Y,reshape(D,[Q Q])-1e-6);
        axis equal; hold on;
        I = frame2im(getframe(gca));
        
        hh = contour3(X,Y,reshape(D,[Q Q]),...
            [-2e6 -1e-6],'k');
        
        axis(Sdf.BdBox*1.01);

        colormap([Sdf.options.Color; Sdf.options.Color]);
        view(0,90);
        drawnow;
        %I = frame2im(getframe(gca));
        
    else
        hold on;
        h = patch('Vertices',Sdf.Node,'Faces',Sdf.Element,...
            'FaceColor','none','LineW',3);
    end
end
end
    
methods (Access = private)

end
end
