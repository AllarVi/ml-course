classdef KNearestNeighbors
    
    methods(Static)
        function response = execute(trainingSet, testSet)
            
            % generate predictions
            predictions = [];
            k = 3;
            
            [rows, ~] = size(testSet);
            for i = 1:rows
                neighbors = KNearestNeighbors.getNeighbors(trainingSet, testSet(i, :), k);
                response = KNearestNeighbors.getResponse(neighbors);
                predictions = [predictions; response];
                fprintf('predicted: %i, actual: %i \n', response, testSet(i, end));
            end
            
            accuracy = KNearestNeighbors.getAccuracy(testSet, predictions);
            fprintf('accuracy: %i \n', accuracy);
        end
        
        function accuracy = getAccuracy(testSet, predictions)
            correct = 0;
            
           [rows, ~] = size(testSet);
           for i = 1:rows
               if testSet(i, end) == predictions(i)
                   correct = correct + 1;
               end    
           end
           
           percent = (correct / rows) * 100.0;
           accuracy = percent;
        end
        
        function response = getResponse(neighbors)
           [rows, ~] = size(neighbors);
           labelVotes = zeros(1, 2); 
           
           for i = 1:rows
               label = neighbors(i, end);
               if ismember(label, labelVotes(:, 1))
                   indeces = find(labelVotes==label);
                   idx = indeces(1, 1);
                   
                   votesCount = labelVotes(idx, 2:2);
                   votesCount = votesCount + 1;
                   labelVotes(idx, 2) = votesCount;
               else
                   labelVotes = [labelVotes; label, 1];
               end
           end
           
           sorted = sortrows(labelVotes, 2, 'descend'); 
           response = sorted(1, 1); % improve in case of tie
        end
        
        function neighbors = getNeighbors(trainingSet, testInstance, k)
            distances = [];
            
            [row, ~] = size(trainingSet);
            for i = 1:row % calc distances
                dist = MetricFunction.euclideanDistance(testInstance(1, 1:end-1), trainingSet(i, 1:end-1));
                distances = [distances; trainingSet(i, :), dist];
            end
            
            [~, distColIdx] = size(distances);
            distances = sortrows(distances, distColIdx); % sort distances
            
            neighbors = [];
            for i = 1:k % return k nearest neighbors
                neighbors = [neighbors; distances(i, 1:end-1)];
            end
        end
    end
    
end