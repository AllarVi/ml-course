classdef AdaBoost
    
    properties
        M = 0; % number of weak classifiers
        learningRate = 0;
    end
    
    methods
        function obj = AdaBoost(M, learningRate)
            obj.M = M;
            obj.learningRate = learningRate;
        end
        
        function testPredictions = adaBootClf(obj, train, test)
            weights = AdaBoost.getInitWeights(train);
            
            testPredictions = zeros(size(test, 1), 1);
            
            trainLabels = train(:, end);
            
            estimators = {};
            estimatorPredictionsList = {};
            estimatorErrors = {};
            estimatorWeights = {};
            weightsHistory = {};
            
            for i = 1:obj.M            
                % Fit a classifier
                estimator = fitctree(train(:, 1:end-1), trainLabels, 'MaxNumSplits', 1, 'Weights', weights);
            
                estimatorPredictions = predict(estimator, train(:, 1:end-1));
                testEstimatorPredictions = predict(estimator, test(:, 1:end-1));
                
                % Misclassifications
                incorrect = estimatorPredictions ~= trainLabels;
                
                % Estimator error / weighted error
                estimatorError = dot(weights, incorrect) / sum(weights);
                
                % Boost estimator weights / coefficient / alpha
                if (estimatorError == 0)
                    estimatorWeight = 21474836;
                else
                    estimatorWeight = obj.learningRate * log((1 - estimatorError) / estimatorError);
                end
                
                % New weights / Boost sample weights
                incorrect2 = [];
                for j = 1:length(incorrect)
                    if (incorrect(j) == 1)
                        incorrect2 = [incorrect2; 1];
                    elseif (incorrect(j) == 0)
                        incorrect2 = [incorrect2; -1];
                    end
                end
                
                delta = [];
                for j = 1:length(incorrect2)
                    delta = [delta; estimatorWeight * incorrect2(j)];
                end
                change = exp(delta);
                
                weights = weights .* change;
                
                % Save iteration values
                estimators{end+1} = estimator;
                estimatorPredictionsList{end+1} = estimatorPredictions;
                estimatorErrors{end+1} = estimatorError;
                estimatorWeights{end+1} = estimatorWeight;
                weightsHistory{end+1} = weights;
                
                if (sum(weights) == 0) % ideal classifiers are discarded
                    break;
                end
                
                % Add to prediction
                % Update test predictions
                newTestEstimatorPredictions = estimatorWeight * testEstimatorPredictions;
                zipped = [testPredictions, newTestEstimatorPredictions];
                testPredictions = sum(zipped, 2);
                
            end
            
            testPredictions = sign(testPredictions);
            
        end
    end
    
    methods(Static)
        function weights = getInitWeights(train)
            trainCount = size(train, 1);
            weights = ones(trainCount, 1) ./ trainCount;
        end
    end
end