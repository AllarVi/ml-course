classdef Point
   properties
        position
        label
        index
    end
    
    methods
        function obj = Point(pos, l, idx)
            obj.position = pos;
            obj.label = l;
            obj.index = idx;
        end
    end
    
    methods(Static)
       function out = toArray(points)
           array_long = [points.position];
           out = zeros(length(points), 2);
           for i = 1:length(points)
               out(i,:) = [array_long(i*2-1) array_long(i*2)];
           end
       end
   end
end

