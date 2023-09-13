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
end
end
