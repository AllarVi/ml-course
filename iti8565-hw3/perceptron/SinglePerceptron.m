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
            
            coefs = LinearRegression.stochastic_gradient_descent(...
                train,...
                obj.learning_rate,...
                obj.n_epoch,...
                @getActivation);
            
            for i = 1:size(test, 1)
                row = test(i, :);
                
                prediction = getActivation(row, coefs, 'binaryStep');
                predictions = [predictions; prediction];
            end
        end
    end
end