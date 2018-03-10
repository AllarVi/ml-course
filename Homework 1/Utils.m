classdef Utils
    
    methods(Static)  
        function result = getMatRowLength(matrix)
            [~, cols] = size(matrix); 
            result = cols;
        end
    end
end

