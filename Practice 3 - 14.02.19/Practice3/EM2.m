% this is enother implementation of EM
%generate sets
clear
clc

% covariance matrices  NB! this is not most ellegant way to generate
% covariance matrices
c(1).matrix = [4, 2; 2, 3];
c(2).matrix = [2, -2; -2, 6];
c(3).matrix = [1, -0.5; -0.5, 1];

% mean values
mu(1, :) = [2, 0];
mu(2, :) = [12, 0];
mu(3, :) = [-1, -10];

% sample sizes
n(1) = 500;
n(2) = 700;
n(3) = 600;


% generate gaussians and merge them into the single dataset
DD = [];
for i = 1:3
    D(i).set = mvnrnd(mu(i, :), c(i).matrix, n(i));
    DD = [DD; D(i).set];
end

fh(1) = figure(1);
clf(fh(1))
for i = 1:3
    scatter(D(i).set(:, 1), D(i).set(:, 2))
    hold on
end


% expected number of clusters
K = 3;
estim_mu = randn(K, 2);
cPi = ones(K) * 1 / 3;
[rows, ~] = size(DD);
% generate initial  responsibilities pi and sigma matrices for each cluster
%centroids
orient = [1, 3; 4, 2];
radiuses = [3, 0; 0, 2];

for k = 1:K
    estim(k).sigma = orient * radiuses * orient';
end

fh(2) = figure(2);
exit_flag = 0;
l = 1;
while (exit_flag == 0)
    clf(fh(2))
    scatter(DD(:, 1), DD(:, 2))
    hold on
    
    %E-step
    for i = 1:rows
        for k = 1:K
            cpikp(k) = cPi(k) * mvnpdf(DD(i, :), estim_mu(k, :), estim(k).sigma);
        end
        sum_cpikp = sum(cpikp);
        for k = 1:K
            r(i, k) = cpikp(k) / sum_cpikp;
        end
    end
    
    % M-step
    for k = 1:K
        cPi(k) = sum(r(:, k)) / rows;
        
        rxx = zeros(2, 2);
        for i = 1:rows
            rx(i, :) = DD(i, :) .* r(i, k);
            rxx = rxx + DD(i, :)' * DD(i, :) * r(i, k);
        end
        
        estim_mu(k, :) = sum(rx) / sum(r(:, k));
        estim(k).sigma = rxx ./ sum(r(:, k)) - estim_mu(k, :)' * estim_mu(k, :);
        
        % in order to draw
        % perform eigen decomposition
        [Vect, Vals] = eig(estim(k).sigma);
        Vals = Vals .* 9;
        ellipse = ellipse2D(sqrt(Vals(1, 1)), sqrt(Vals(2, 2)), estim_mu(k, 1), estim_mu(k, 2), Vect, 20);
        plot(ellipse(:, 1), ellipse(:, 2))
        hold on
        plot(estim_mu(k, 1), estim_mu(k, 2), 'o', 'MarkerFaceColor', 'magenta', 'MarkerEdgeColor', 'green', 'MarkerSize', 10)
        clear ellipse
    end
    pause(0.1)
end
