classdef sdfoptions
    
    properties
        BdBox;
        Dimension;
        Color;
        ColorMap;
        StepTolerance;
        Quality;
        Rotation;
        Center;
    end
    
    methods
        function obj = sdfoptions
            %SDFOPTIONS Construct an instance of this class
            %   Detailed explanation goes here
            
            obj.Dimension = 2;
            obj.Color = [32, 129, 191]/255;
            obj.ColorMap = cmap_viridis;
            obj.Quality = 75;
            obj.StepTolerance = 1e-5;
            obj.Center = [0;0;0];
        end
    end
end

