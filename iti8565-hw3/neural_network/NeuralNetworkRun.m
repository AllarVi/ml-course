clc;
clear;

bank_note_auth_data = csvread('datasets/data_banknote_authentication.csv');

% minmax = Utils.minmax(wine_quality_white_data);
% normalized_dataset = Utils.normalizeDataset(wine_quality_white_data, minmax);

% hyperparameters
learningRate = 0.3;
epochCount = 20;
hiddenCount = 5;

% fit the model
mdl = NeuralNetwork(learningRate, epochCount, hiddenCount);

% evaluate
n_folds = 5;

scores = Utils.evaluateAlgorithm(...
        bank_note_auth_data,...
        @mdl.back_propagation,...
        n_folds,...
        true);

fprintf('Scores: %.3f%% \n', scores)
fprintf('Mean Accuracy: %.3f%% \n', sum(scores)/size(scores, 2))




