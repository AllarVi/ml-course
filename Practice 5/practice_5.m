clear
clc

% find(1-0.5, 1, 98)

load('data_for_regression.mat')

[rows, cols] = size(X);

for j=1:cols
    for k=j:cols
        c = corrcoef(X(:,j),X(:,k));
        mcm(j,k) = c(1,2);
    end
end

mdl_1 = fitlm(X(:,1), yy);
model_stats = anova(mdl_1, 'summary');

mdl_2 = fitlm(X(:,1:2), yy);
model_stats_2 = anova(mdl_2, 'summary');

F_c = ((mdl_1.SSE - mdl_2.SSE) / 1) / (mdl_2.SSE / (100 - 2 - 1));
F_r = finv(1 - 0.05, 1, 97);






