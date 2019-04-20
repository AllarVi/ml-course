classdef SinglePerceptron
    
    properties
      learning_rate = 0;
      n_epoch = 0;
    end
    
    methods
        function obj = SinglePerceptron(learning_rate, n_epoch)
            obj.learning_rate = learning_rate;
            obj.n_epoch = n_epoch;
        end
        
        function predictions = singlePerceptron(obj, train, test)
            predictions = [];
            
            activationFunction = @getActivation;
            activationFunctionType = 'binaryStep';
            
            coefs = stochasticGradientDescent(...
                train,...
                obj.learning_rate,...
                obj.n_epoch,...
                activationFunction,...
                'binaryStep');
            
            for i = 1:size(test, 1)
                row = test(i, :);
                
                prediction = activationFunction(row, coefs, activationFunctionType);
                predictions = [predictions; prediction];
            end
        end
    end
end