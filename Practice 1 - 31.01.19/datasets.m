clear 
clc

cov(1).matrix = [4, 2; 2, 3];

% mean values
mean(1) = 500;
mean(2) = 700;
mean(3) = 100;
mean(4) = 100;
mean(5) = 100;

for i=1:5
    D(i).set = mvnrnd(mean(i).mu, cov(i).matrix, n(i));
end