function value=NeuronTrainingVisualisation1(x,y,z,z_current,err,err_sqr,epochNr)
% this function draws the surfaces describing the process of
% Neural network training
value=1;
lx = length(x);
z_current_visual = round(z_current);
z_zeros = zeros(lx,1);
z1=z;
fh(2)=figure(2);
clf(fh(2))
%subplot(2,2,1)
subplot('Position',[0.08, 1-0.5+0.07,  0.4, 0.4])
scatter3(x,y,z_current,20,z_current_visual)
hold on
scatter3(x,y,z1,20,z1)
hold on

for i=1:lx
    if z1(i)==0
        cl='blue';
    else
        cl='yellow';
    end
    plot3([x(i),x(i)],[y(i),y(i)],[z_current(i),z1(i)],'color',cl)
    hold on
end

%surf(x,y,err)
%grid on
%xlabel('x')
%ylabel('y')
%zlabel('residuals')
%axis([-2.1,2.1,-2.1,2.1,-0.5,0.5])
view([-60,36])
%subplot(2,2,2)
subplot('Position',[0.06+0.5, 1-0.5+0.07,  0.4, 0.4])
scatter(x,y,20,z_current_visual)
hold on
grid on
xlabel('x')
ylabel('y')
% zlabel('output')
% axis([-2.1,2.1,-2.1,2.1,-0.1,1.1])
% view([-101,14])

%subplot(2,2,3)
subplot('Position',[0.08, 0+0.08,  0.4, 0.4])
scatter3(x,y,z_current,20,z_current_visual)
hold on
scatter3(x,y,z1,20,z1)
hold on

for i=1:lx
    if z1(i)==0
        cl='blue';
        %errr=err(i);
    else
        cl='yellow';
        %errr=-err(i);
    end
    plot3([x(i),x(i)],[y(i),y(i)],[z1(i),z1(i)+err(i)],'color',cl)
    hold on
end

%surf(x,y,err)
%grid on
%xlabel('x')
%ylabel('y')
%zlabel('residuals')
%axis([-2.1,2.1,-2.1,2.1,-0.5,0.5])
view([-60,36])
%subplot(2,2,4)
subplot('Position',[0.06+0.5, 0+0.08,  0.4, 0.4])
scatter3(x,y,z_zeros,20,z1)
hold on
for i=1:lx
    if z1(i)==0
        cl='blue';
    else
        cl='yellow';
    end
    plot3([x(i),x(i)],[y(i),y(i)],[z_zeros(i),z_zeros(i)+err_sqr(i)],'color','red')
    hold on
end
%grid on
%xlabel('x')
%ylabel('y')
%zlabel('squared residuals')
%axis([-2.1,2.1,-2.1,2.1,-0.5,0.5])
view([-60,36])

%
print(['classifier_fitting_epoch',num2str(epochNr),'.pdf'],'-dpdf','-bestfit')