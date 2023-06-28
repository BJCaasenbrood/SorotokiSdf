function r = sTranslate(obj1,move)
            
    B = obj1.BdBox; 
    y = @(x) x - repmat(move(:)',size(x,1),1);
    r = Sdf(@(x) obj1.sdf(y(x)));
    
    if numel(move) == 2
        r.BdBox = [B(1)+move(1), B(2)+move(1),               ...
                   B(3)+move(2), B(4)+move(2)];    
    else
        r.BdBox = [B(1)+move(1), B(2)+move(1),               ...
                    B(3)+move(2), B(4)+move(2),               ...
                    B(5)+move(3), B(6)+move(3)];     
    end
    
 end     