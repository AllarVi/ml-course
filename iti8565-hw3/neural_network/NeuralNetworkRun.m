clc;
clear;

bank_note_auth_data = csvread('datasets/data_banknote_authentication.csv');
haberman_data = csvread('datasets/haberman.csv');

% minmax = Utils.minmax(wine_quality_white_data);
% normalized_dataset = Utils.normalizeDataset(wine_quality_white_data, minmax);

% hyperparameters

% for bank notes
learningRate = 0.3;
epochCount = 20;

% for haberman
% learningRate = 0.5;
% epochCount = 100;

hiddenLayer1 = containers.Map();
hiddenLayer1('neuronCount') = 2;
hiddenLayer1('name') = 'hidden1';

hiddenLayer2 = containers.Map();
hiddenLayer2('neuronCount') = 2;
hiddenLayer2('name') = 'hidden2';

hiddenLayers{1} = hiddenLayer1;
hiddenLayers{2} = hiddenLayer2;

% fit the model
mdl = NeuralNetwork(learningRate, epochCount, hiddenLayers);

% evaluate
n_folds = 2;

scores = Utils.evaluateAlgorithm(...
        bank_note_auth_data,...
        @mdl.backPropagation,...
        n_folds,...
        true);

fprintf('Scores: %.3f%% \n', scores)
fprintf('Mean Accuracy: %.3f%% \n', sum(scores)/size(scores, 2))




