function surfaceZ = ForwardPass(x,y,w)
% this function returns surface representing the graph of the neuron
% function with two inputs
I=length(x);
for i =1:I
    surfaceZ(i) = 1/(1+exp(-1*(w(1)*x(i)+w(2)*y(i))));
end
end
