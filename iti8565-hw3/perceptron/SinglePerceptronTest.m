clc
clear

%% Test 1: should train single perceptron

dataset = readtable('datasets/sonar.all-data.csv');
dataset = Utils.strColumnToInt(dataset, 61);
dataset.Var61 = cell2mat(dataset.Var61);

dataset = table2array(dataset);

learningRate = 0.01;
n_epoch = 500;

% fit the model
perceptron = SinglePerceptron(learningRate, n_epoch);

% evaluate
n_folds = 3;

scores = Utils.evaluateAlgorithm( ...
    dataset, ...
    @perceptron.singlePerceptron, ...
    n_folds, ...
    true);


% fprintf('Scores: %.3f \n', scores)
fprintf('Mean Accuracy: %.3f \n', sum(scores)/size(scores, 2))