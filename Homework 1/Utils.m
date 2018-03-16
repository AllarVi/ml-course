classdef Utils
    
    methods(Static)  
        function result = getMatRowLength(matrix)
            [~, cols] = size(matrix); 
            result = cols;
        end
        
        function clusterPoints = renderLabeledDataset(labeledDS, clusters)
            for clusterIDX = 1:clusters
                [~, cols] = size(labeledDS); 
                clusterPoints = labeledDS(labeledDS(:, cols) == clusterIDX, :);
                scatter(clusterPoints(:, 1), clusterPoints(:, 2), 40, 'filled');
                Legend{clusterIDX} = strcat('Label: ', num2str(clusterIDX));
                hold on;
            end 
            legend(Legend);
        end
    end
end

