function[D_1,labels_1,D_2,labels_2] = DataSplitter(dataset,labels,proportion)
% this function returns two datasets and corresponding labels which are 
% splitted dataset and labels in proportion

[rows,~]=size(dataset);

rows_1 = floor(rows*proportion);


% generate row numbers to be smapled out for the first subset
row_nrs_all=1:1:rows;
row_nrs_1=randperm(rows,rows_1);
row_nrs_2=setdiff(row_nrs_all,row_nrs_1);

D_1=dataset(row_nrs_1,:);
labels_1 = labels(row_nrs_1);

D_2=dataset(row_nrs_2,:);
labels_2 = labels(row_nrs_2);
end

    



