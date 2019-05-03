function[value]=NARX_NN(iodata,n,m,tl)
%This function returns trained NARX- type neural network trained on the 
%basis of iodata modelling single input single output system of order n
%note this function is not fuulproof. M is the number of hidden naurons on
%each layer,, tl-training lenght in epoch

[read veerud]=size(iodata); % get the size of input-output data

%in order to train the network one should create shiftid inputs and outputs

for i=1:n
    P{i,1}=[iodata(1+i-1:read-n+i-1,1)'; iodata(1+i-1:read-n+i-1,2)']; % n-previous control inputs u & n-previous outputs y
end
    
% create a  Target
T={iodata(n+1:read,2)'};

% find minimal and maximal values for the data
max_Y=max(iodata(:,2));
min_Y=min(iodata(:,2));
max_U=max(iodata(:,1));
min_U=min(iodata(:,1));



net=network;
net.numInputs=n; % number of NN-inputs
net.numLayers=2; % number of layers
B=ones(1, n+1);
B(n+1)=0; % auxilary vector of length n where all ellemesnt are 1 except the last one
% net.biasConnect=B';
F=ones(1,n); % auxilary matrix
G=zeros(1,n);
H=[F; G];
net.inputConnect=H; % which input to which layer 
A=zeros(n,n+1); % auxilary matrix n by n+1 of zeros
C=[A; B];
net.layerConnect=[0 0; 1 0];% [A; B];% connections between layers in case of ANARX each layer connecto to the last layer only
D=zeros(1,n+1);
D(n+1)=1; %auxilary matrix
net.outputConnect=[0 1]; %D; % what goes to output, in our case it is 4th output only 
% according to MATLAB 9 & 10 warning next line is not needed
%net.targetConnect=B; % what will be compared with reference signal
%define the range of the input signal
for i=1:n
    net.inputs{i}.range=[min_U max_U; min_Y max_Y]; %define the range of the input signal
end

for i=1:1
    net.layers{i}.size=m; % number of neurons on this layer
end

for i=1:1
    net.layers{i}.transferFcn='logsig'; % type of activation function on this layer
end

net.layers{2}.transferFcn='purelin'; % type of activation function on last layer

for i=1:1
    net.layers{1}.initFcn='initnw'; % type of activation function on this layer
end


net.initFcn='initlay'; %initialisation
net.performFcn='mse'; % meansquare 
net.trainFcn='trainlm'; % training algorithm
net=init(net); %initialisationh


net.trainParam.epochs=tl; % lenght of training 
net.trainParam.show=1000;   % show parameter 
net=train(net,P,T); % train the network


value=net;
end
