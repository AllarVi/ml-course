clear;
clc;

DBSCANStruct = load('DD1.mat');
DBSCANDataset = struct2dataset(DBSCANStruct);
DBSCANDataset = DBSCANDataset.DD;