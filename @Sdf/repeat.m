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

function P = pRepeat(P0,c) 
    if numel(c) == 3
    P = zeros(size(P0,1),3);
        P(:,1) = mod(P0(:,1),c(1));
        P(:,2) = mod(P0(:,2),c(2));
        P(:,3) = mod(P0(:,3),c(3));
    else
        P = zeros(size(P0,1),2);
        P(:,1) = mod(P0(:,1),c(1));
        P(:,2) = mod(P0(:,2),c(2));
    end
end