classdef Point
   properties
        position
        label
        index
    end
    
    methods
        function point = Point(position, label, index)
            point.position = position;
            point.label = label;
            point.index = index;
        end
    end
    
    methods(Static)
       function DB = getDB(DBSCANDataset)
           DB = Point.empty;
           for pointIDX = 1:length(DBSCANDataset)
               DB(pointIDX) = Point(DBSCANDataset(pointIDX, :), 0, pointIDX);
           end
       end
   end
end

