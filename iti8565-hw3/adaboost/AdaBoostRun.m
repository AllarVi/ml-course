clc;
clear;

bank_note_auth_data = csvread('datasets/data_banknote_authentication.csv');
bank_note_auth_data_easy = [bank_note_auth_data(:, 1), bank_note_auth_data(:, 2), bank_note_auth_data(:, end)];

easyBinaryClassificationDataRaw = load('datasets/easy-binary-classification-data.mat');
easyBinaryClassificationData = easyBinaryClassificationDataRaw.DD;

easyBinaryClassificationDataRaw2 = load('datasets/easy-binary-classification-data-2.mat');
easyBinaryClassificationData2 = easyBinaryClassificationDataRaw2.DD;

% hyperparameters

% for bank notes
learningRate = 0.7;
M = 8;

% fit the model
mdl = AdaBoost(M, learningRate);

% evaluate
n_folds = 2;

scores = Utils.evaluateAlgorithm(...
        easyBinaryClassificationData2,...
        @mdl.adaBootClf,...
        n_folds,...
        true);

fprintf('Scores: %.3f%% \n', scores)
fprintf('Mean Accuracy: %.3f%% \n', sum(scores)/size(scores, 2))

