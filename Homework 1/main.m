clear;
clc;

set1 = [3, 7];
set2 = [3, 4];

% 3dim rnd vectors
rndVector1 = [66, 640, 44];
rndVector2 = [64, 580, 29];

% center point of the dataset (mean(dataset))
dataset_mean = [68, 600, 40];

dataset = [
    64 580 29;
    66 570 33;
    68 590 37;
    69 660 46;
    73 600 55
    ];

% should return Euclidean Distance 3
%euclideanDistance = MetricFunction.euclideanDistance(set1, set2);

% should return Manhattan Distance 3
%manhattanDistance = MetricFunction.manhattanDistance(set1, set2);

% should return Chebyshev Distance 3
%chebyshevDistance = MetricFunction.chebyshevDistance(set1, set2);

% should return Canberra Distance 0.272727
% sensitive with short distances
% canberraDistance = MetricFunction.canberraDistance(rndVector1, rndVector2);

% should return Mahalanobis Distance 3
% mahal = MetricFunction.mahalanobisDistance(dataset, rndVector1);
% mahalSquared = MetricFunction.mahalanobisDistanceSquared(rndVector1, rndVector2, [rndVector1; rndVector2]);

% should return Cosine Distance
% cosDistance = MetricFunction.cosineDistance(rndVector1, rndVector2);

% K-means

% Prepare data
% kMeansStruct = load('dataset_3.mat');
% kMeansDataset = struct2dataset(kMeansStruct);
% kMeansDataset = kMeansDataset.DD;

% scatter(kMeansDataset(:,1),kMeansDataset(:,2));
% hold on;

% clusters = KMeans.genRndClusters(4, Utils.getMatRowLength(kMeansDataset));
% 
% for epoch = 1:10
%     labeledDataset = KMeans.clusterAssignmentStep(kMeansDataset, clusters);
% 
%     clusters = KMeans.moveClustersStep(labeledDataset, clusters);
%     
%     % scatter(clusters(:,1),clusters(:,2), 70, 'filled');
%     % hold on;
% end

% Matlab builtin
% matlabResult = kmeans(kMeansDataset, 4);
% labeledDataset = [kMeansDataset, matlabResult];

% Utils.renderLabeledDataset(labeledDataset, 4); % render final labeled cluster points
% scatter(clusters(:,1),clusters(:,2), 90, 'filled'); % render final centroids

% DBSCAN
DBSCANStruct = load('dataset_3.mat');
DBSCANDataset = struct2dataset(DBSCANStruct);
DBSCANDataset = DBSCANDataset.DD;

DB = Point.empty;
for pointIDX = 1:length(DBSCANDataset)
    DB(pointIDX) = Point(DBSCANDataset(pointIDX, :), 0, pointIDX);
end

% % As a rule of thumb, minPts = 2·dim can be used
[labeledDB, clusters] = DBSCAN.execute(DB, 4, 7);

for clusterIDX = 1:clusters
    mask = arrayfun(@(x) x.label == clusterIDX, labeledDB);
    DBSCANClusterPoints = labeledDB(mask);
    
    arr = Point.toArray(DBSCANClusterPoints);
    scatter(arr(:,1),arr(:,2), 40, 'filled');
    labelNr = DBSCANClusterPoints(1).label;
    Legend{clusterIDX}=strcat('Label: ', num2str(labelNr));
    hold on;
end 

mask = arrayfun(@(x) x.label == -1, labeledDB);
DBSCANClusterPoints = labeledDB(mask);
    
arr = Point.toArray(DBSCANClusterPoints);
scatter(arr(:,1),arr(:,2), 40);
hold on;

legend(Legend);
grid on;


