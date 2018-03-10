classdef KMeans
    
    methods(Static)  
        function labeledDataset = clusterAssignmentStep(dataset, clusters)
            new_dim = zeros(length(dataset), 1);
            dataset = cat(2, dataset, new_dim);
            for i = 1:length(dataset)
                distances = [];
                for c = 1:length(clusters)
                    point = dataset(i, :);
                    cluster = clusters(c, :);
                    distance = MetricFunction.euclideanDistance(point(1, 1:length(point) - 1), cluster);
                    distances = [distances; distance];
                end
                [~, closestCluIDX] = min(distances);
                
                cDimens = size(dataset);
                cDimens = cDimens(1, 2);
                dataset(i, cDimens) = closestCluIDX;
            end
            labeledDataset = dataset;
        end
        
        function clusters = genRndClusters(quantity, dimens)
            clusters = rand(quantity, dimens); 
        end
    end
end

