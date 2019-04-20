% Load the data and train the network 

m=3;     % number of the neurons on hiddenlayer 
n=1;  
nMax=10; %
p=2;     % reference model order


inputLin=ones(1000,1);
outputLin=ones(1000,1).*2;
%inputSin=sin(2*t);
for i=1:1000
    t(i)=i*0.01-0.01;
    inputSin(i)=sin(2*t(i));
    inputRandLin(i)=randn*10;
    outputRandLin(i)=inputRandLin(i)*5+randn;
    inputRandSin(i)=sin(t(i))*randn;
    outputRandSin(i)=cos(inputRandSin(i))+rand;
    outputSin(i)=inputSin(i)*5+randn;
end

%x=inputSin;
%t=outputSin;

x=inputRandLin;
t=outputRandLin;
net=fitnet(7);
net=train(net,x,t);
view(net);
y=net(x);

y_hat=sim(net,inputRandLin);

fh(1)=figure(1);
clf(fh(1))
plot(outputRandLin,'blue')
hold on
plot(y_hat,'red')
