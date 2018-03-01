clear;
clc;

set1 = [3, 7];
set2 = [3, 4];

mahal1 = [66, 640, 44];
mahal2 = [64, 580, 29];

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
%canberraDistance = MetricFunction.canberraDistance(set1, set2);

% should return Mahalanobis Distance 3
mahalanobisDistance = MetricFunction.mahalanobisDistance(mahal2, mahal1);
