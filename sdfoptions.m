classdef sdfoptions
    
    properties
        Color;
        ColorMap;
        StepTolerance;
        Quality;
        Rotation;
        Center;
    end
    
    methods
        function obj = sdfoptions          
            obj.Color = [32, 129, 191]/255;
            obj.ColorMap = cmap_viridis;
            obj.Quality = 75;
            obj.StepTolerance = 1e-2;
            obj.Center = [0;0;0];
        end
    end
end

