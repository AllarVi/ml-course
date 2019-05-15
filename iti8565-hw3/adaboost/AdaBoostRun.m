clc;
clear;

bank_note_auth_data = csvread('datasets/data_banknote_authentication.csv');
bank_note_auth_data_easy = [bank_note_auth_data(:, 1), bank_note_auth_data(:, 2), bank_note_auth_data(:, end)];

% hyperparameters

% for bank notes
learningRate = 0.01;
M = 5;

% fit the model
mdl = AdaBoost(M, learningRate);

% evaluate
n_folds = 2;

scores = Utils.evaluateAlgorithm(...
        bank_note_auth_data_easy,...
        @mdl.adaBootClf,...
        n_folds,...
        true);

fprintf('Scores: %.3f%% \n', scores)
fprintf('Mean Accuracy: %.3f%% \n', sum(scores)/size(scores, 2))

