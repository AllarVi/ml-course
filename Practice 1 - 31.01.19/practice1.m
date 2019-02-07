clear;
clc;

% create array
theta = 0:0.01:2*pi;

val = sin(theta);

% figure handler
fh(1) = figure(1);
plot(val)

plot(theta, val)
hold on

point_a = [1, 3];
point_b = [4, 1];

minkovsky(point_a, point_b, 2) % euclidian distance

function value=minkovsky(point_1, point_2, p)
    
    n=length(point_1);
    
    sum=0;
    
    if p~=Inf
        for i = 1:n
            sum=sum+(abs(point_1(i)-point_2(i)))^p;
            value=sum^(1/p);
        end
    else
        for i=1:n
            d(i)=abs(point_1(i)-point_2(i));
        end
        value=max(d);
    end
end