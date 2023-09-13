function d = eval(Sdf,x)
    if ~isempty(Sdf.options.Rotation)
       R = rot3d(Sdf.options.Rotation);
       x = (R*x.').';
    end
        
    d = Sdf.sdf(x);
end