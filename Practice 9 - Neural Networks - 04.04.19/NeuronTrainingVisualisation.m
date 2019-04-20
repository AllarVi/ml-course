function value=NeuronTrainingVisualisation(x,y,z,z_current,err,err_sqr)
% this function draws the surfaces describing the process of
% Neural network training
value=1;

fh(2)=figure(2);
clf(fh(2))
%subplot(2,2,1)
subplot('Position',[0.08, 1-0.5+0.07,  0.4, 0.4])
mesh(x,y,z,'FaceAlpha',0.2)
hold on
surf(x,y,z_current)
hold on
grid on
xlabel('x')
ylabel('y')
zlabel('output')
axis([-2.1,2.1,-2.1,2.1,-0.1,1.1])
view([-101,14])
%subplot(2,2,2)
subplot('Position',[0.06+0.5, 1-0.5+0.07,  0.4, 0.4])
surf(x,y,z_current)
hold on
grid on
xlabel('x')
ylabel('y')
zlabel('output')
axis([-2.1,2.1,-2.1,2.1,-0.1,1.1])
view([-101,14])

%subplot(2,2,3)
subplot('Position',[0.08, 0+0.08,  0.4, 0.4])
surf(x,y,err)
grid on
xlabel('x')
ylabel('y')
zlabel('residuals')
axis([-2.1,2.1,-2.1,2.1,-0.5,0.5])
view([-101,14])

%subplot(2,2,4)
subplot('Position',[0.06+0.5, 0+0.08,  0.4, 0.4])
surf(x,y,err_sqr)
grid on
xlabel('x')
ylabel('y')
zlabel('squared residuals')
axis([-2.1,2.1,-2.1,2.1,-0.5,0.5])
view([-101,14])

%
%print(['neuron_surfaces_epoch',num2str(epochNr),'.pdf'],'-dpdf','-bestfit')