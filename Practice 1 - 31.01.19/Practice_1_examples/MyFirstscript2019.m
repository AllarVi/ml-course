clear
clc

theta = 0:0.01:2 * pi;
val = sin(theta);

fh(1) = figure(1);
plot(theta, val)
hold on
