classdef Container
    properties
        height {mustBeNumeric};
        weight {mustBeNumeric};
        width {mustBeNumeric};
        twistlocks;
    end
    methods
        function obj = Container(height,weight,width)
            obj.height = height;
            obj.weight = weight;
            obj.width = width;
            obj.twistlocks = 0;
        end
        
        function obj = activateTwistlocks(obj)
            obj.twistlocks = 1;
        end
        
        function checkTwistlocks(obj)
            disp(obj.twistlocks);
        end
    end
end
