% this script illustrates different concepts related to classification
clear
clc

%these two parameters define the sample
% so it is enough to genrate set twice to get different samples of the same
% population

% covariance matrices
cov(1).matrix = [4, 2; 2, 3];
cov(2).matrix = [2, -2; -2, 6];
cov(3).matrix = [1, -0.5; -0.5, 1];

% mean values
mean(1).mu = [4, 1];
mean(2).mu = [-7, 0];
mean(3).mu = [0, 4];

% sample sizes
n(1) = 500;
n(2) = 700;
n(3) = 600;

Dataset = []; % Dataset
labels = [];
for clusterIDX = 1:3
    DTrain(clusterIDX).set = mvnrnd(mean(clusterIDX).mu, cov(clusterIDX).matrix, n(clusterIDX));
    DTrain(clusterIDX).labels = ones(n(clusterIDX), 1) * clusterIDX;
    Dataset = [Dataset; DTrain(clusterIDX).set];
    labels = [labels; DTrain(clusterIDX).labels];
end

% add some more complicated sets

stepS = 0.1;
% generate more comples sets
t = -2:stepS:2;
tLength = length(t);
thicknes = 10;

DS1 = [];
for clusterIDX = 1:tLength
    tSlice = rand(thicknes, 2) * 1.2;
    x(1:thicknes, 1) = tSlice(:, 1) + t(clusterIDX);
    y(1:thicknes, 1) = -tSlice(:, 2) + t(clusterIDX)^2;
    DS1 = [DS1; x, y];
end
labelsDS = ones(tLength*10, 1);

DS2 = [];
for clusterIDX = 1:tLength
    tSlice = rand(thicknes, 2) * 0.9;
    x(1:thicknes, 1) = tSlice(:, 1) + t(clusterIDX) + 2;
    y(1:thicknes, 1) = tSlice(:, 2) - t(clusterIDX)^2 + 5.5;
    DS2 = [DS2; x, y];
end
labelsDS = [labelsDS; ones(tLength*10, 1) * 2];
DS = [DS1; DS2];


%flower like clusters
%cluster1

cov(1).matrix = [1, 0; 0, 1];
%cov(1).matrix = [4, 2; 2, 3];
cov(2).matrix = [1, -2; -2, 6];
cov(3).matrix = [1, 0.5; 0.5, 1];
cov(4).matrix = [1, -2; -2, 7];

n(3) = 350;
n(4) = 400;


mu(1, 1).xy = [2, 3];
mu(1, 2).xy = [1, 7];
mu(1, 3).xy = [5, 6];
mu(1, 4).xy = [3.4, 0];

flower_1 = [];
for clusterIDX = 1:1
    for j = 1:4
        petal(clusterIDX, j).set = mvnrnd(mu(clusterIDX, j).xy, cov(j).matrix, n(j));
        flower_1 = [flower_1; petal(clusterIDX, j).set];
    end
end
[rl, ~] = size(flower_1);
labelsF = ones(rl, 1);

%cluster2

cov(4).matrix = [2, 1; 1, 2];
%cov(1).matrix = [4, 2; 2, 3];
cov(3).matrix = [1, -2; -2, 6];
cov(2).matrix = [1, 0.5; 0.5, 1];
cov(1).matrix = [1, -2; -2, 7];

n(3) = 350;
n(4) = 400;


%mu(1,4).xy = [15,4];
mu(1, 3).xy = [10, 7];
mu(1, 2).xy = [9, 2];
mu(1, 1).xy = [12, 0];

flower_2 = [];
for clusterIDX = 1:1
    for j = 1:3
        petal(clusterIDX, j).set = mvnrnd(mu(clusterIDX, j).xy, cov(j).matrix, n(j));
        flower_2 = [flower_2; petal(clusterIDX, j).set];
    end
end
[rl, ~] = size(flower_2);
flowers = [flower_1; flower_2];
labelsF = [labelsF; ones(rl, 1) * 2];


% now we need to split the data and labels for training and validation
% datasets.
proportion = 0.7;
[DTrain, labels_train, D_valid, labels_valid] = DataSplitter(Dataset, labels, proportion);
[DS_train, labelsDS_train, DS_valid, labelsDS_valid] = DataSplitter(DS, labelsDS, proportion);
[Flowers_train, labelsF_train, Flowers_valid, labelsF_valid] = DataSplitter(flowers, labelsF, proportion);

fh(1) = figure(1);
clf(figure(1))
scatter(DTrain(:, 1), DTrain(:, 2), 10, labels_train)
axis equal
grid on
xlabel('dimension 1')
ylabel('dimension 2')


fh(2) = figure(2);
clf(figure(2))
scatter(DS_train(:, 1), DS_train(:, 2), 10, labelsDS_train)
axis equal
grid on
xlabel('dimension 1')
ylabel('dimension 2')

fh(3) = figure(3);
clf(figure(3))
scatter(Flowers_train(:, 1), Flowers_train(:, 2), 10, labelsF_train)
axis equal
grid on
xlabel('dimension 1')
ylabel('dimension 2')
%print('MarginTest.pdf','-dpdf','-bestfit')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% classification%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Mdl_svm = fitcsvm(DS_train, labelsDS_train, 'KernelFunction', 'gaussian');
DS_hat = predict(Mdl_svm, DS_valid);
[decision_boundary, out] = DecisionBoundary(DS_train, Mdl_svm, 0.1);

fh(4) = figure(4);
clf(figure(4))
scatter(DS_train(:, 1), DS_train(:, 2), 10, labelsDS_train)
%surf(out.labels_hat)
hold on
plot(decision_boundary(:, 1), decision_boundary(:, 2), '--o')
axis equal
grid on
xlabel('dimension 1')
ylabel('dimension 2')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
labelsDS_train = labelsDS_train - 1;
Mdl_log = fitglm(DS_train, labelsDS_train, 'Distribution', 'binomial');
DS_hat = predict(Mdl_log, DS_valid);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
