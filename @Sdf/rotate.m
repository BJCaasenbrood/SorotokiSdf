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