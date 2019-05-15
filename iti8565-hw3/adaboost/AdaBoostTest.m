classdef AdaBoostTest < matlab.unittest.TestCase
    
    methods(Test)
         
        function adaBootClf(testCase)
            bank_note_auth_data = csvread('datasets/data_banknote_authentication.csv');

            [x_train, x_test, y_train, y_test] = Utils.splitDataset(bank_note_auth_data, 0.7);
            
            train = [x_train, y_train];
            test = [x_test, y_test];
            
            train_easy = [train(:, 1), train(:, 2), train(:, end)];
            test_easy = [test(:, 1), test(:, 2), test(:, end)];
            
            %train_easy = AdaBoostTest.initializeDataset();
            %test_easy = AdaBoostTest.initializeTest();
            
            
            %scatter(train_easy(:, 1), train_easy(:, 2));
            
            M = 10;
            learningRate = 0.5;
            
            mdl = AdaBoost(M, learningRate);
            
            predictions = mdl.adaBootClf(train_easy, test_easy);
        end
        
        function initializeInitialWeights(testCase)
            dataset = AdaBoostTest.initializeDataset();
            
            weights = AdaBoost.getInitWeights(dataset);
        end
    end
    
    methods(Static)

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
        
        function test = initializeTest()
            test = [2.3810836, 2.150537003, 0; ...
                3.06407232, 3.105305973, 0; ...
                7.573756466, 3.548563011, 1];
        end
        
    end
end