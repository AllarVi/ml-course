classdef KMeans
    
    methods(Static)  
        function labeledDataset = clusterAssignmentStep(dataset, clusters)
            datasetLength = length(dataset);
            zerosColumn = zeros(datasetLength, 1);
            dataset = cat(2, dataset, zerosColumn); % add column of zeros
            
            for pointIDX = 1:datasetLength
                distances = [];
                for clusterIDX = 1:length(clusters)
                    point = dataset(pointIDX, :); % point from dataset
                    cluster = clusters(clusterIDX, :); 
                    dist = MetricFunction.euclideanDistance(point(1, 1:length(point) - 1), cluster);
                    distances = [distances; dist];
                end
                [~, closestCluIDX] = min(distances);
                [~, cols] = size(dataset); 
                
                dataset(pointIDX, cols) = closestCluIDX;
            end
            labeledDataset = dataset;
        end
        
        function clusters = moveClustersStep(labeledDataset, clusters)
            for i = 1:length(clusters)
                newCluster = KMeans.getClusterMean(labeledDataset, i);
                clusters(i, :) = newCluster; 
            end
        end
        
        function clusters = genRndClusters(quantity, dimens)
            clusters = rand(quantity, dimens); 
        end
        
        function newCluster = getClusterMean(labeledDataset, clusterIDX)
            [~, cols] = size(labeledDataset); 
            clusterPoints = labeledDataset(labeledDataset(:, cols) == clusterIDX, :); 
            newCluster = mean(clusterPoints(:, 1:(cols-1)));
        end
    end
end

