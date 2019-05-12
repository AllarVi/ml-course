classdef Utils
    
    methods(Static)
        
        function [x_train, x_test, y_train, y_test] = splitDataset(data, ratio)
            N = size(data, 1); % total number of rows
            tf = false(N, 1); % create logical index vector
            tf(1:round(ratio*N)) = true;
            tf = tf(randperm(N)); % randomise order
            
            train = data(tf, :);
            test = data(~tf, :);
            
            x_train = train(:, 1:end - 1);
            y_train = train(:, end);
            
            x_test = test(:, 1:end - 1);
            y_test = test(:, end);
        end
        
        function accuracy = getAccuracy(actuals, predictions)
            correct = 0;
            
            for i = 1:size(actuals)
                if actuals(i) == predictions(i)
                    correct = correct + 1;
                end
            end
            
            accuracy = (correct / size(actuals, 1)) * 100.0;
        end
        
        function rmse = getRMSE(actuals, predictions)
            % Calculate Root Mean Squared Error
            rootSquaredError = Utils.getRSE(actuals, predictions);
            
            meanError = rootSquaredError / size(actuals, 1);
            rmse = sqrt(meanError);
        end
        
        function rse = getRSE(actuals, predictions)
            rse = 0;
            
            for i = 1:length(actuals)
                predictionError = predictions(i) - actuals(i);
                rse = rse + predictionError^2;
            end
        end
        
        function folds = crossValidationFolds(dataset, n_folds)
            folds = {};
            
            dataset_copy = ones(size(dataset)) .* dataset;
            
            c = cvpartition(dataset(:, end-1), 'KFold', n_folds);
            test_sizes = c.TestSize;
            
            for i = 1:n_folds
                fold = [];
                fold_size = test_sizes(i);
                
                while size(fold) < fold_size
                    a = 1;
                    b = size(dataset_copy, 1);
                    index = floor((b-a).*rand(1,1) + a);
                    
                    fold = [fold; dataset_copy(index, :)];
                    dataset_copy(index, :) = [];
                end
                
                folds{end + 1} = fold;
            end
        end
        
        function minmax = minmax(dataset)
            % Find the min and max values for each column
            
            minmax = [];
            
            for i = 1:size(dataset, 2)
                col_values = dataset(:, i);
                
                value_min = min(col_values);
                value_max = max(col_values);
                
                minmax = [minmax; value_min, value_max];
            end
        end
        
        function normalized_dataset = normalizeDataset(dataset, minmax)
            normalized_dataset = ones(size(dataset)) .* dataset; % copy dataset
            
            for i = 1:size(normalized_dataset, 1)
                row = normalized_dataset(i, :);
                
                for j = 1:size(row, 2)
                    row(j) = (row(j) - minmax(j, 1)) / (minmax(j, 2) - minmax(j, 1));
                end
                
                normalized_dataset(i, :) = row;
            end
        end      

        function dataset = strColumnToInt(dataset, column)
            classValues = unique(dataset(:, column));
            
            lookup = containers.Map();
            
            for i = 1:size(classValues)
                classValue = classValues{i, 'Var61'}{1, 1};
                
                lookup(classValue) = i - 1;
            end
            
            for i = 1:size(dataset)
                valueToConvert = lookup(dataset{i, column}{1, 1});
                valueAsTable = array2table(valueToConvert);
                
                dataset{i, column} = table2cell(valueAsTable);
            end
        end
        
        function scores = evaluateAlgorithm(dataset, algorithm, n_folds, useAccuracy)
            folds = Utils.crossValidationFolds(dataset, n_folds);
                
            scores = [];
            
            for i = 1:size(folds, 2)
                fold = folds{i};
                
                train_folds = folds(:, :);
                train_folds(i) = []; % remove current fold
                
                train_set = [];
                for j = 1:size(train_folds, 2)
                    train_set = [train_set; train_folds{j}];
                end
                
                % fold acts as test_set
                predictions = algorithm(train_set, fold);
       
                actuals = fold(:, end);
                
                if useAccuracy
                    metric = Utils.getAccuracy(actuals, predictions);
                    % fprintf('Fold %d accuracy: %.3f%% \n', i, metric)
                else
                    metric = Utils.getRMSE(actuals, predictions);
                    % fprintf('Fold %d rmse: %.3f%% \n', i, metric)
                end
                
                scores = [scores, metric];
            end
        end
    end
end
