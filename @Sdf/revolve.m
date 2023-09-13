function r = revolve(obj1,varargin)
            
    if ~isempty(varargin)
       rot = varargin{1};
    end
    
    fnc = @(x) obj1.eval(dRevolve(x,rot));
    r   = Sdf(fnc);
    r.BdBox = [-obj1.BdBox(2),obj1.BdBox(2),...
               -obj1.BdBox(2),obj1.BdBox(2),...
                obj1.BdBox(3),obj1.BdBox(4)];
ends