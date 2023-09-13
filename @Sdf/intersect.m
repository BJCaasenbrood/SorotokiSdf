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