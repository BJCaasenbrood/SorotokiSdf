function Sdf = render(Sdf,varargin)
    obj = Gmodel(Sdf,'Quality',80,varargin{:});
    obj.bake.render();    
    
    Sdf.Gmodel = obj;
end