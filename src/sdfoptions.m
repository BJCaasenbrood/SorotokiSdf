classdef sdfoptions
    
    properties
        BdBox;
        Dimension;
        Color;
        ColorMap;
        StepTolerance;
        Quality;
        Rotation;
    end
    
    methods
        function obj = sdfoptions
            %SDFOPTIONS Construct an instance of this class
            %   Detailed explanation goes here
            obj.Dimension = 2;
            obj.Color = [32, 129, 191]/255;
            obj.ColorMap = cmap_viridis;
            obj.Quality   = 75;
            obj.StepTolerance = 1e-5;
        end
    end
end

