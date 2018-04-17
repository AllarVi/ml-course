classdef Utils
    
    methods(Static)
        function result = getMatRowLength(matrix)
            [~, cols] = size(matrix);
            result = cols;
        end
        
        function table = convertLabelToNumeric(table)
            labelIdx = 0;
            currentLabel = {};
            for rowIdx = 1:height(table)
                newLabel = table{rowIdx, end}; % get last element in table row
                if ~isequal(newLabel, currentLabel)
                    currentLabel = newLabel;
                    labelIdx = labelIdx + 1;
                end
                table{rowIdx, end} = {labelIdx};
            end
            
            table = Utils.convertToArray(table);
        end
        
        function result = convertToArray(table)
            result = zeros(height(table), width(table));
            for rowIdx = 1:height(table)
                for columnIdx = 1:width(table)
                    if iscell(table{rowIdx, columnIdx})
                        result(rowIdx, columnIdx) = cell2mat(table{rowIdx, columnIdx});
                    else
                        result(rowIdx, columnIdx) = table{rowIdx, columnIdx};
                    end
                end
            end
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
        
        function matrix = getMatrix(objArray)
            numOfPoints = length(objArray);
            
            matrix = zeros(numOfPoints, 2);
            for j = 1:numOfPoints
                matrix(j, :) = [objArray(j).position(1, 1), objArray(j).position(1, 2)];
            end
        end
        
        function labelNr = renderDBSCANClusters(labeledDB, clusterIDX)
            mask = arrayfun(@(x) x.label == clusterIDX, labeledDB);
            DBSCANClusterPoints = labeledDB(mask);
            
            clusterPointsMatrix = Utils.getMatrix(DBSCANClusterPoints); % convert objArray to matrix
            scatter(clusterPointsMatrix(:, 1), clusterPointsMatrix(:, 2), 40, 'filled');
            hold on;
            
            labelNr = DBSCANClusterPoints(1).label; % get labelNr from first point
        end
    end
end
