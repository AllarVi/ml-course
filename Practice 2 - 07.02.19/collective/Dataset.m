% this script playes a role of dataset constructor. 
clear
clc

%eigenvalues, eigenvectors, means 

% not very nice way to define  matrices defining the distributions
% covariance matrices
cov(1).matrix = [4, 2; 2, 3];
cov(2).matrix = [2, -2; -2, 6];
cov(3).matrix = [1, -0.5; -0.5, 1];
cov(4).matrix = [1, -0.5; -0.5, 1];
cov(5).matrix = [1, -0.5; -0.5, 1];

% coorect way to define 'matrices defining the distributions
%eVect = [0.615412209402636,-0.788205438016109;-0.788205438016109,-0.615412209402636]
%eVal = [1.43844718719117,0;0,5.56155281280883]
%cov(1).matrix = eVect*eVal* inv(eVect);

%eVal = [6.43844718719117,0;0,15.56155281280883]

%m = [ 1 2; 5 1 ];
%[V, D] = eig(m)
%cov(2).matrix = V*D*inv(V)

% mean values
mean(1).mu = [-8,-7];
mean(2).mu = [1,0];
mean(3).mu = [-8,6];
mean(4).mu = [5,7];
mean(5).mu = [5, -11];

% sample sizes
n(1) = 500;
n(2) = 700;
n(3) = 100;
n(4) = 100;
n(5) = 200;

for i=1:5
    D(i).set = mvnrnd(mean(i).mu,cov(i).matrix,n(i));
end

D1 = cat(1,D(1).set, D(2).set, D(3).set, D(4).set,D(5).set)

fh(1) = figure(1);
clf(fh(1))
for i=1:5
    scatter(D(i).set(:,1),D(i).set(:,2))
    hold on
end

% res = kmeans(DD,5)

%fh(2) = figure(2);
%clf(fh(2))
%for i=1:length(res)
%    scatter(DD(i,1),DD(i,2),5,res(i))
%    hold on
%end

%hold off
% coeff = [];
% for i=1:8
%    fh(i) = figure(i);
%    res = kmeans(DD,i);
%    coeff = mean(silhouette(DD,res))
% end