clear;
clc;

%%%%%%%%%%%%%%%
% Exercise 1. %
%%%%%%%%%%%%%%%

% DD = readtable('iris.csv');
% DD = Utils.convertLabelToNumeric(DD);

% Data preparation with ratio of 67/33
knnStruct = load('iris.mat');
originalSet = struct2dataset(knnStruct);
originalSet = originalSet.DD;

[trainingSet, testSet] = Utils.loadDataset('iris.mat', 0.66);

% Print
figure(1);
title('Data preparation with ratio of 67/33')
hold on;
scatter(originalSet(:, 1), originalSet(:, 2), 100, 'filled');
scatter(trainingSet(:, 1), trainingSet(:, 2), 20, 'filled');
scatter(testSet(:, 1), testSet(:, 2), 20, 'filled');
legend('Original', 'Training', 'Test', 'Location', 'Best');

KNearestNeighbors.execute(trainingSet, testSet);


