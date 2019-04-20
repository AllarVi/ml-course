function z = SurfaceGenerator(x, y, w)
% this function returns surface representing the graph of the neuron
% function with two inputs
[rows, cols] = size(x);
for i = 1:rows
    for j = 1:cols
        xCoord = x(i, j) * w(1);
        yCoord = y(i, j) * w(2);
        
        z(i, j) = 1 / (1 + exp(-1*(xCoord + yCoord)));
    end
end

end
