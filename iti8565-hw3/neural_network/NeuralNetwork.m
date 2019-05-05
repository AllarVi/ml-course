classdef NeuralNetwork
    
    methods(Static)
        function trainNetwork(network, train, learningRate, epochCount, outputsCount)
            for i = 1:epochCount
                RenderUtils.plotNetwork(network);
                
                sumError = 0;
                
                for j = 1:size(train, 1)
                    row = train(j, :);
                    
                    outputs = NeuralNetwork.forwardPropagate(row, network);
                    
                    expected = zeros(1, outputsCount);
                    expected(row(end) + 1) = 1;
                    
                    sumError = sumError + Utils.getRSE(expected, outputs);
                    
                    NeuralNetwork.backwardPropagateError(network, expected);
                    
                    NeuralNetwork.updateWeights(network, row, learningRate);
                end
               
                fprintf('>epoch=%d, lrate=%.3f, error=%.3f \n', i, learningRate, sumError);
                pause(1)
            end
        end
        
        function updateWeights(network, row, learningRate)
            for i = 1:size(network, 2)
                inputs = row(1, 1:end-1); % last input is the bias 
                
                if (i ~= 1) % if not first (hidden) layer  
                    prevLayerOutputs = [];
                    prevLayer = network{i - 1};
                    for j = 1:size(prevLayer, 2)
                        neuron = prevLayer{j};
                        prevLayerOutputs = [prevLayerOutputs, neuron('output')];
                    end
                    inputs = prevLayerOutputs;      
                end
                
                layer = network{i};
                for neuronIdx = 1:size(layer, 2)
                    neuron = layer{neuronIdx};
                    
                    for j = 1:length(inputs)
                        newWeight = learningRate * neuron('delta') * inputs(j);
                        neuronWeights = neuron('weights');
                        neuronWeights(j) = neuronWeights(j) + newWeight;
                        neuron('weights') = neuronWeights;
                    end
                    neuronWeights = neuron('weights');
                    newBias = learningRate * neuron('delta');
                    neuronWeights(end) = neuronWeights(end) + newBias;
                    neuron('weights') = neuronWeights;
                end 
            end
        end
        
        function backwardPropagateError(network, expected)
            for i = size(network, 2):-1:1
                layer = network{i};
                errors = [];
                
                if (i ~= size(network, 2)) % hidden layer
                    for j = 1:size(layer, 2)
                        error = 0.0;

                        prevLayer = network{i + 1};
                        for n = 1:size(prevLayer, 2)
                            neuron = prevLayer{n};
                            neuronWeights = neuron('weights');

                            neuronError = neuronWeights(j) * neuron('delta');

                            error = error + neuronError;
                        end
                        
                        errors = [errors, error];
                    end
                else % output layer
                    for j = 1:size(layer, 2)
                        neuron = layer{j};
                        
                        error = expected(j) - neuron('output');
                        
                        errors = [errors, error];
                    end
                end 
                
                for j = 1:size(layer, 2) % add delta (error * derivative) to neuron
                    neuron = layer{j};
                    
                    neuron('delta') = errors(j) * getSigmoidDerivative(neuron('output'));
                end                
            end
        end
        
        function outputs = forwardPropagate(row, network)
            inputs = row;
            
            for i = 1:size(network, 2)
                layer = network{i};
                
                newInputs = [];
                
                for j = 1:size(layer, 2)
                    neuron = layer{j};
                    activation = getActivation(inputs, neuron('weights'), 'logistic');
                    neuron('output') = activation;
                    
                    newInputs = [newInputs, neuron('output')];
                end
                
                inputs = newInputs;
            end
            
            outputs = inputs; % last inputs are the outputs of the nn
        end
        
        function network = initializeNetwork(inputsCount, hiddenCount, outputsCount)
            network = {};
            
            hiddenLayer = NeuralNetwork.getLayer(hiddenCount, inputsCount, "hidden");
            network{1} = hiddenLayer;
            
            outputLayer = NeuralNetwork.getLayer(outputsCount, hiddenCount, "output");
            network{2} = outputLayer;
        end
        
        function layer = getLayer(neuronsCount, neuronInputsCount, layerName)
            layer = {};
            for i = 1:neuronsCount
                neuron = containers.Map();
                neuron('layerName') = layerName;
                neuron('neuronIdx') = i;
                neuron('weights') = rand(1, neuronInputsCount + 1);
                layer{i} = neuron;
            end
        end
    end
end