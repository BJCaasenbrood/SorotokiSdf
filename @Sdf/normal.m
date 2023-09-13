function [T,N,B,Z] = normal(Sdf,x)

    d = Sdf.sdf(x);
    N = zeros(size(x,1),3);
    T = zeros(size(x,1),3);
    
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
    
    % ensure it's unit
    N = N./sqrt((sum((N.^2),2)) + 1e-6 );

    % T(:,1) = copysign(N(:,3),N(:,1));
    % T(:,2) = copysign(N(:,3),N(:,2));
    % T(:,3) = -copysign(abs(N(:,1)) + abs(N(:,2)),N(:,3));
    % T = T./sqrt((sum((T.^2),2)) + 1e-6 );

    T = ([0,1,0;-1,0,0;0,0,1]*N.').';

    B = cross(T,N);

    Z = atan2(N(:,2).*sign(-d(:,end)),N(:,1).*sign(-d(:,end)));
       
    if size(x,2) == 2
        T = B;
        B = cross(T,N);
    end
end