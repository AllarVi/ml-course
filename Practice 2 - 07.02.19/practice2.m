% this script playes a role of dataset constructor.
clear
clc

% not very nice way to define  matrices defining the distributions
% covariance matrices
cov(2).matrix = [2, -2; -2, 6];
cov(3).matrix = [1, -0.5; -0.5, 1];
cov(4).matrix = [1, -0.5; -0.5, 1];

% omavektor
% coorect way to define 'matrices defining the distributions
eVect = [; ...
    0.6154, -0.7882; ...
    -0.7882, -0.6154; ...
    ]

% omaväärtus
eVal = [; ...
    0.4384, 0; ...
    0, 5.56155; ...
    ]

% Definitsioon on A * eVect = eVal * eVect, kus
% A - kovariantsus maatriks
% eVect - omavektor e. eigenvector
% eVal - omaväärtus e. eigenvalue
cov(1).matrix = eVect * eVal * inv(eVect);


% mean values
mean(1).mu = [-8, -7];
mean(2).mu = [1, 0];
mean(3).mu = [-10, 3];
mean(4).mu = [6, 3];

% sample sizes
n(1) = 500;
n(2) = 700;
n(3) = 150;
n(4) = 200;

for i = 1:4
    D(i).set = mvnrnd(mean(i).mu, cov(i).matrix, n(i));
end

fh(1) = figure(1);
clf(fh(1))

for i = 1:4
    scatter(D(i).set(:, 1), D(i).set(:, 2))
    hold on
end

myset = [];
for i = 1:4
    cat(1, myset, D(i).set);
end
