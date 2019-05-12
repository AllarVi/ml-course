classdef NeuralNetworkTest < matlab.unittest.TestCase
    
    properties
        %         TestFigure
    end
    
    methods(TestMethodSetup)
        %         function createFigure(testCase)
        %             % comment
        %             testCase.TestFigure = figure;
        %         end
    end
    
    methods(TestMethodTeardown)
        %         function closeFigure(testCase)
        %             close(testCase.TestFigure)
        %         end
    end
    
    methods(Test)
        
        function initializeNeuralNetwork(testCase)
            inputsCount = 2;
            outputsCount = 2;
            
            hiddenLayer1 = containers.Map();
            hiddenLayer1('neuronCount') = 2;
            hiddenLayer1('name') = 'hidden1';
            
            hiddenLayer2 = containers.Map();
            hiddenLayer2('neuronCount') = 2;
            hiddenLayer2('name') = 'hidden2';
            
            hiddenLayers{1} = hiddenLayer1;
            hiddenLayers{2} = hiddenLayer2;
            
            network = NeuralNetwork.initializeNetwork(inputsCount, outputsCount, hiddenLayers);
            
            assertEqual(testCase, size(network, 2), 3);
        end
        
        function forwardPropagate(testCase)
            neuronHidden = containers.Map();
            neuronHidden('weights') = [0.13436424411240122, 0.8474337369372327, 0.763774618976614];
            
            neuronOutput1 = containers.Map();
            neuronOutput1('weights') = [0.2550690257394217, 0.49543508709194095];
            
            neuronOutput2 = containers.Map();
            neuronOutput2('weights') = [0.4494910647887381, 0.651592972722763];
            
            layerHidden{1} = neuronHidden;
            layerOutput{1} = neuronOutput1;
            layerOutput{2} = neuronOutput2;
            
            network{1} = layerHidden;
            network{2} = layerOutput;
            
            outputs = NeuralNetwork.forwardPropagate([1, 0], network);
            
            fprintf(" %f ", outputs(:, :)); fprintf("\n");
            
            expected = [0.662997012985289, 0.725316072527975];
            difference = max(abs(outputs(:)-expected(:))) < 0.01;
            assertTrue(testCase, difference)
        end
        
        function backwardPropagateError(testCase)
            neuronHidden = containers.Map();
            neuronHidden('weights') = [0.13436424411240122, 0.8474337369372327, 0.763774618976614];
            neuronHidden('output') = 0.7105668883115941;
            
            neuronOutput1 = containers.Map();
            neuronOutput1('weights') = [0.2550690257394217, 0.49543508709194095];
            neuronOutput1('output') = 0.6213859615555266;
            
            neuronOutput2 = containers.Map();
            neuronOutput2('weights') = [0.4494910647887381, 0.651592972722763];
            neuronOutput2('output') = 0.6573693455986976;
            
            layerHidden{1} = neuronHidden;
            layerOutput{1} = neuronOutput1;
            layerOutput{2} = neuronOutput2;
            
            network{1} = layerHidden;
            network{2} = layerOutput;
            
            expected = [0, 1];
            
            NeuralNetwork.backwardPropagateError(network, expected);
            
            % network printing
            for i = 1:size(network, 2)
                layer = network{i};
                
                for j = 1:size(layer, 2)
                    neuron = layer{j};
                    weights = neuron('weights');
                    
                    fprintf('>output=%.4f weights=', neuron('output'));
                    fprintf('%.4f ', weights(:, :));
                    fprintf('delta=%.4f', neuron('delta'));
                    fprintf('\n');
                end
            end
        end
        
        function predictWithTrainedNN(testCase)
            network = NeuralNetworkTest.initializeTrainedNN();
            dataset = NeuralNetworkTest.initializeDataset();
            
            for i = 1:size(dataset, 1)
                row = dataset(i, :);
                
                prediction = NeuralNetwork.predict(network, row);
                
                fprintf('>expected=%d actual=%d \n', prediction, row(end));
            end
        end
        
        function trainNetwork(testCase)
            dataset = NeuralNetworkTest.initializeDataset();
            
            datasetLinear = [2.550537003, 0; ...
                2.362125076, 0; ...
                4.400293529, 0; ...
                1.850220317, 0; ...
                3.005305973, 0; ...
                2.759262235, 1; ...
                2.088626775, 1; ...
                1.77106367, 1; ...
                -0.242068655, 1; ...
                3.508563011, 1];
            
            
            inputsCount = size(dataset, 2) - 1;
            outputsCount = 2;
            
            hiddenLayer1 = containers.Map();
            hiddenLayer1('neuronCount') = 2;
            hiddenLayer1('name') = 'hidden1';
            
            hiddenLayers{1} = hiddenLayer1;
            
            network = NeuralNetwork.initializeNetwork(inputsCount, outputsCount, hiddenLayers);
            
            epochCount = 20;
            learningRate = 0.5;
            
            NeuralNetwork.trainNetwork(network, dataset, learningRate, epochCount, outputsCount)
        end
        
    end
    
    methods(Static)
                
        function network = initializeTrainedNN()
            neuronHidden1 = containers.Map();
            neuronHidden1('weights') = [-1.482313569067226, 1.8308790073202204, 1.078381922048799];
            
            neuronHidden2 = containers.Map();
            neuronHidden2('weights') = [0.23244990332399884, 0.3621998343835864, 0.40289821191094327];
            
            neuronOutput1 = containers.Map();
            neuronOutput1('weights') = [2.5001872433501404, 0.7887233511355132, -1.1026649757805829];
            
            neuronOutput2 = containers.Map();
            neuronOutput2('weights') = [-2.429350576245497, 0.8357651039198697, 1.0699217181280656];
            
            layerHidden{1} = neuronHidden1;
            layerHidden{2} = neuronHidden2;
            
            layerOutput{1} = neuronOutput1;
            layerOutput{2} = neuronOutput2;
            
            network{1} = layerHidden;
            network{2} = layerOutput;
        end
        
        function dataset = initializeDataset()
            dataset = [2.7810836, 2.550537003, 0; ...
                1.465489372, 2.362125076, 0; ...
                3.396561688, 4.400293529, 0; ...
                1.38807019, 1.850220317, 0; ...
                3.06407232, 3.005305973, 0; ...
                7.627531214, 2.759262235, 1; ...
                5.332441248, 2.088626775, 1; ...
                6.922596716, 1.77106367, 1; ...
                8.675418651, -0.242068655, 1; ...
                7.673756466, 3.508563011, 1];
        end
        
    end
end