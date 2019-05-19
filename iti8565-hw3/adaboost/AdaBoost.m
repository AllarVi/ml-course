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
        
        function predictions = adaBootClf(obj, train, test)
            weights = AdaBoost.getInitWeights(train);
            
            predictions = zeros(size(test, 1), 1);
                        
            estimators = {};
            estimatorPredictionsList = {};
            estimatorErrors = {};
            estimatorWeights = {};
            
            weightsHistory = {};
            weightsHistory{end + 1} = weights;
            
            trainLabels = train(:, end);
            
            for i = 1:obj.M            
                % Fit a classifier
                estimator = fitctree(train(:, 1:end-1), trainLabels, 'MaxNumSplits', 1, 'Weights', weights);
            
                trainEstimatorPredictions = predict(estimator, train(:, 1:end-1));
                
                % Misclassifications
                incorrect = trainEstimatorPredictions ~= trainLabels;
                
                terrors = [];
                for j = 1:length(incorrect)
                    if (incorrect(j) == 1)
                        terrors = [terrors; 1];
                    elseif (incorrect(j) == 0) % 0 is logical false in matlab -> 0 = -1
                        terrors = [terrors; -1];
                    end
                end
                
                % Estimator error / weighted error
                estimatorError = dot(weights, incorrect) / sum(weights);
                
                % Boost estimator weights / coefficient / alpha / stage
                estimatorWeight = obj.learningRate * log((1. - estimatorError) / estimatorError);            
                
                % New weights / Boost sample weights     
                delta = [];
                for j = 1:length(terrors)
                    delta = [delta; estimatorWeight * terrors(j)];
                end
                
                weights = weights .* exp(delta);
                
                % Save iteration values
                estimators{end+1} = estimator;
                estimatorPredictionsList{end+1} = trainEstimatorPredictions;
                estimatorErrors{end+1} = estimatorError;
                estimatorWeights{end+1} = estimatorWeight;
                weightsHistory{end+1} = weights;
                
                %if (sum(weights) == 0) % ideal classifiers are discarded
                %    break;
                %end
                
                % Add to prediction
                % Update test predictions
                testEstimatorPredictions = predict(estimator, test(:, 1:end-1));
                
                newTestEstimatorPredictions = estimatorWeight * testEstimatorPredictions;
                zipped = [predictions, newTestEstimatorPredictions];
                predictions = sum(zipped, 2);
                
            end
            
            predictions = sign(predictions);
            
            AdaBoost.plotAdaBoostBoundary(estimators, estimatorWeights, train, 50);
        end
    end
    
    methods(Static)
        function weights = getInitWeights(train)
            trainCount = size(train, 1);
            weights = ones(trainCount, 1) ./ trainCount;
        end
        
        function zz = adaBoostClassify(x_temp, estimators, estimatorWeights)
            estimatorsAndWeights = [estimators(:), estimatorWeights(:)];
            % [ (e.predict(x_temp)).T* w for e, w in zip(est,est_weights )]
            preds = [];
            for i = 1:size(estimatorsAndWeights, 1)
                row = estimatorsAndWeights(i, :);
                estimator = row{1, 1};
                estimatorWeight = row{1, 2};
                
                preds = [preds, predict(estimator, x_temp)' * estimatorWeight];         
            end
            
            estimatorWeightsAsNumerical = cell2mat(estimatorWeights);
            temp_pred = preds / sum(estimatorWeightsAsNumerical);
            
            zz = sign(sum(temp_pred));
        end
        
        function plotAdaBoostBoundary(estimators, estimatorWeights, train, N)
            train_x = train(:, 1:end-1);
            
            x_min = min(train_x(:, 1)) - .1;
            x_max = max(train_x(:, 1)) + .1;
            
            y_min = min(train_x(:, 2)) - .1;
            y_max = max(train_x(:, 2)) + .1;

            [xx, yy] = meshgrid(linspace(x_min, x_max, N), linspace(y_min, y_max, N));
            
            xx_flattened = reshape(xx.', 1, []); % raveling/flattening
            yy_flattened = reshape(yy.', 1, []);
            
            zipped = [xx_flattened; yy_flattened];
            
            zz = [];
            for i = 1:size(zipped, 2)
                x_temp = zipped(:, i)';
                zz = [zz, AdaBoost.adaBoostClassify(x_temp, estimators, estimatorWeights)];
            end
            
            Z = reshape(zz, size(xx));
             
            figure;
            
            contourf(xx, yy, Z, 2);
            hold on;
            contour(xx, yy, Z, 2);
            RenderUtils.renderLabeledDataset(train);
            % scatter(train(:,1), train(:,2));
            
        end
    end
end