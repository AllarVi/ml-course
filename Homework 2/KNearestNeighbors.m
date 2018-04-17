classdef KNearestNeighbors
    properties
        dataset
        k
    end
    
    methods
        function obj = KNearestNeighbors(dataset, k)
            obj.dataset = dataset;
            obj.k = k;
        end
    end
    
end