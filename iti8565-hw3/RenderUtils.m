classdef RenderUtils
    
    methods(Static)
        function plotNeuron(totalLayersCount, layerPlotMatrix, neuronInLayerIdx)
            plot(layerPlotMatrix(1, :, neuronInLayerIdx), layerPlotMatrix(2, :, neuronInLayerIdx));
            
            neuronTitle = sprintf('neuron=%d, total layers=%d', neuronInLayerIdx, totalLayersCount);
            title(neuronTitle);
        end
        
        function plotLayer(layerPlotMatrix, totalLayersCount, totalNeuronIndeces)
            for i = 1:length(totalNeuronIndeces)
                subplot(totalLayersCount, 2, totalNeuronIndeces(:, i));
                hold on;
                
                RenderUtils.plotNeuron(totalLayersCount, layerPlotMatrix, i);
            end
        end
        
        function plotNetwork(network)
            layersCount = size(network, 2);
            
            figure(1)
            for i = 1:layersCount
                layerPlotMatrix = RenderUtils.getLayerPlotMatrix(network, i);
                neuronsCount = size(layerPlotMatrix, 3);
                
                neuronIndeces = 1:1:neuronsCount;
                neuronIndeces = neuronIndeces + 2*(i - 1);
                
                RenderUtils.plotLayer(layerPlotMatrix, layersCount, neuronIndeces);
            end
        end
        
        function layerPlotMatrix = getLayerPlotMatrix(network, layerIdx)
            outputLayer = network{layerIdx};
            
            firstNeuron = outputLayer{1};
            firstNeuronMatrix = RenderUtils.getNeuronPlotMatrix(firstNeuron);
            
            for neuronIdx = 2:size(outputLayer, 2)
                neuron = outputLayer{neuronIdx};
                
                neuronMatrix = RenderUtils.getNeuronPlotMatrix(neuron);
                
                firstNeuronMatrix(:, :, neuronIdx) = neuronMatrix;
            end
            
            layerPlotMatrix = firstNeuronMatrix;
        end
        
        function neuronPlotMatrix = getNeuronPlotMatrix(neuron)
            neuronWeights = neuron('weights');
            %             fprintf('>layerName=%s, neuronIdx=%d \n', neuron('layerName'), neuron('neuronIdx'));
            %             fprintf('%.4f ', neuronWeights(:, :)); fprintf('\n');
            
            x = -10:0.1:10;
            
            if (length(neuronWeights) == 2)
                f = @(x) neuronWeights(end) + neuronWeights(1) * x;
            elseif (length(neuronWeights) == 3)
                f = @(x) neuronWeights(end) + neuronWeights(1) * x + neuronWeights(2) * x^2;
            elseif (length(neuronWeights) == 4)
                f = @(x) neuronWeights(end) + neuronWeights(1) * x + neuronWeights(2) * x^2 + neuronWeights(3) * x^3;
            elseif (length(neuronWeights) == 5)
                f = @(x) neuronWeights(end) + neuronWeights(1) * x + neuronWeights(2) * x^2 + neuronWeights(3) * x^3 + neuronWeights(4) * x^4;
            end
            
            y = arrayfun(f, x);
            
            neuronPlotMatrix = [x; y];
        end
        
        function renderLabeledDataset(labeledDS)
            [~, cols] = size(labeledDS);
            clusters = unique(labeledDS(:, cols));
            
            legendIDX = 1;
            
            for i = 1:length(clusters)
                clusterIDX = clusters(i);
                
                [~, cols] = size(labeledDS);
                clusterPoints = labeledDS(labeledDS(:, cols) == clusterIDX, :);
                
                % Rendering
                if clusterIDX == -1 % Noise points
                    if cols == 3
                        scatter(clusterPoints(:, 1), clusterPoints(:, 2), 40);
                    elseif cols == 4
                        scatter3(clusterPoints(:, 1), clusterPoints(:, 2), clusterPoints(:, 3), 40);
                    end
                    
                    Legend{legendIDX} = strcat('Noise: ', num2str(clusterIDX));
                else % Cluster
                    if cols == 3
                        scatter(clusterPoints(:, 1), clusterPoints(:, 2), 40, 'filled');
                    elseif cols == 4
                        scatter3(clusterPoints(:, 1), clusterPoints(:, 2), clusterPoints(:, 3), 40, 'filled');
                    end
                    
                    Legend{legendIDX} = strcat('Label: ', num2str(clusterIDX));
                end
                legendIDX = legendIDX + 1;
                
                hold on;
            end
            legend(Legend);
        end
    end
end
