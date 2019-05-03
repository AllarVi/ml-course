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
            hiddenCount = 1;
            outputsCount = 2;
            
            network = NeuralNetwork.initializeNetwork(inputsCount, hiddenCount, outputsCount);
        end
        
        function forwardPropagate(testCase)
            inputsCount = 2;
            hiddenCount = 1;
            outputsCount = 2;
            
            network = NeuralNetwork.initializeNetwork(inputsCount, hiddenCount, outputsCount);
            
            outputs = NeuralNetwork.forwardPropagate([1, 0], network);
        end
        
        function backwardPropagateError(testCase)
            inputsCount = 2;
            hiddenCount = 1;
            outputsCount = 2;
            
            network = NeuralNetwork.initializeNetwork(inputsCount, hiddenCount, outputsCount);
            
            outputs = NeuralNetwork.forwardPropagate([0, 1], network);
            
            expected = [0, 1];
            
            NeuralNetwork.backwardPropagateError(network, expected);
        end
        
        function trainNetwork(testCase)
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
            
            inputsCount = size(dataset, 2) - 1;
            outputsCount = 2;
            hiddenCount = 2;
            
            network = NeuralNetwork.initializeNetwork(inputsCount, hiddenCount, outputsCount);
            
            outputLayer = network{end};
            outputNeuron1 = outputLayer{1};
            X = outputNeuron1('weights');
            Y = X()
            
            figures(1) = figure(1);
            
            
            epochCount = 3;
            learningRate = 0.5;
            
            NeuralNetwork.trainNetwork(network, dataset, learningRate, epochCount, outputsCount)
        end
        
    end
end