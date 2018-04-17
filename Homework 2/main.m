clear;
clc;

%%%%%%%%%%%%%%%
% Exercise 1. %
%%%%%%%%%%%%%%%

% DD = readtable('iris.csv');
% DD = Utils.convertLabelToNumeric(DD);

% Load data
knnStruct = load('iris.mat');
knnDataset = struct2dataset(knnStruct);
knnDataset = knnDataset.DD;
