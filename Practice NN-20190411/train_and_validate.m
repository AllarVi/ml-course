% Load the data and train the network 

m=5;     % number of the neurons on hiddenlayer 
n=2000;  % length of the dataset  
nMax=10; %
p=2;     % reference model order

load('IOData.mat')
iodata1=iodataHeater(2).val(1:500,:);   % you have 3 datasets to play with here do not forget to split
narx_nn=NARX_NN(iodata1,3,m,n);

%validate
iodata=iodataHeater(2).val(501:end,:);   % you have 3 datasets to play with here do not forget to split
output_y_narx=Model_NN(iodata(:,1),narx_nn,3,iodata(:,2));

figure(3)
clf(figure(3))
plot(iodata1(:,2),'color','blue')
hold on
plot(output_y_narx,'color','red')
hold on