% this script playes a role of dataset constructor. 
clear
clc

cov(1).matrix =[1,3;4,2]*[16,0 ;0, 9]*[1,3;4,2]';
cov(2).matrix =[1,-3;-4,2]*[1,0 ;0, 1]*[1,-3;-4,2]';
cov(3).matrix =[-1,3;4,-2]*[9,0 ;0, 4]*[-1,3;4,-2]';
cov(4).matrix =[1,3;4,2]*[2,0 ;0, 7]*[1,3;4,2]';

mean(1).mu = [12,4];
mean(2).mu = [35,20];
mean(3).mu = [-23,-7];
mean(4).mu = [0,25];

n(1) = 200;
n(2) = 400;
n(3) = 300;
n(4) = 500;

DD = []
for i=1:4
    D(i).set = mvnrnd(mean(i).mu,cov(i).matrix,n(i));
    DD = [DD;D(i).set]
end
size(DD)
fh(1) = figure(1);
clf(fh(1))
for i=1:4
    scatter(D(i).set(:,1),D(i).set(:,2))
    hold on
end