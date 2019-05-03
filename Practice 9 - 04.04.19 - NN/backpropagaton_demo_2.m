% this script demonstrates backpropagation on example of single neuron
% set the limits
clear
clc

mean(1).mu = [-4,2];
mean(2).mu = [3,-4];

n(1) = 300;
n(2) = 300;

cov(1).matrix = [4, 2; 2, 3];
cov(2).matrix = [2, -2; -2, 6];
D=[];
labels = [];
for i=1:2
    D = [D;mvnrnd(mean(i).mu,cov(i).matrix,n(i))];
    labels=[labels;ones(n(i),1)*i];
end
proportion = 0.7;
[D_1,labels_1,D_2,labels_2] = DataSplitter(D,labels,proportion);

x_min = -2;
x_max = 2;
y_min = -2;
y_max = 2;
%h= 0.2;
steps = 20;
w = [0.5,2];

xx=linspace(x_min,x_max,steps);
yy=linspace(y_min,y_max,steps);
[x,y]=meshgrid(xx,yy);

%z = SurfaceGenerator(x,y,w);
fh(1)=figure(1);
clf(fh(1));
scatter(D_1(:,1),D_1(:,2),20,labels_1)
grid on
print('two_sets.pdf','-dpdf','-bestfit')



%z_noise=rand(steps,steps)*0.05; % add some noise
%z=z+z_noise;

% fh(1)=figure(1);
% clf(fh(1));
% surf(x,y,z)
% grid on
% print('initial_surface.pdf','-dpdf','-bestfit')

N_epoch = 67;

XY = [D_1(:,1),D_1(:,2)];

[L,~] = size(XY);
lbd = 2; % learning constant
w = [3.5, 5];

%fh(2)=figure(2);
z=labels_1-1;
for i=1:N_epoch
    z_current = ForwardPass(XY(:,1), XY(:,2),w);
    err = z - z_current';
    err_sqr = err.^2;
    value=NeuronTrainingVisualisation1(XY(:,1), XY(:,2),z,z_current,err,err_sqr,i);
    %clf(fh(2))
    %mesh(x,y,z,'FaceAlpha',0.1)
    %hold on
    %surf(x,y,z_current,'FaceAlpha',0.7)
    %hold on
    SSE(i) = sum(sum(err_sqr));
    Z = reshape(z,[],1);
    % compute Jacobian
    for l=1:L
        for k=1:2
            %compute exp
            current_exp = exp(w(1) * XY(l, 1) + w(2) * XY(l, 2));
            jcb(l, k) = 2 * ((-Z(l) * XY(l, k) * current_exp) / ((current_exp + 1)^2) + (XY(l, k) * (current_exp^2)) / (current_exp + 1)^3);
        end
    end
    errv=reshape(err,[],1); 
    w = w - (inv(jcb'*jcb + lbd * eye(2))* (2 * jcb'* errv))'*0.4;
   
    weights(i,:) = w;
    pause(0.1)
end

fh(3)=figure(3);
clf(fh(3))
plot(weights(:,1))
hold on
plot(weights(:,2))
hold on
grid on
xlabel('Epoch')
ylabel('Weights')
print('weights_evolution.pdf','-dpdf','-bestfit')

