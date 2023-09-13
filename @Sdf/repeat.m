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