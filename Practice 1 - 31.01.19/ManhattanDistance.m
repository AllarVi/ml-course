function value = ManhattanDistance(point_1, point_2)

dimensionality = length(point_1);

vSum = 0;

for i=1:dimensionality
    vSum = vSum + abs((point_1(i) - point_2(i))^2);
end

value = vSum;

end