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

predictions = KNearestNeighbors.execute(trainingSet, testSet);

figure(2);
title('Actual results')
hold on;
Utils.renderLabeledDataset(testSet, 3, 40);

figure(3);
title('Predicted results')
hold on;
predictedSet = testSet(:, 1:end-1);
predictedSet = [predictedSet, predictions];
Utils.renderLabeledDataset(predictedSet, 3, 40);



