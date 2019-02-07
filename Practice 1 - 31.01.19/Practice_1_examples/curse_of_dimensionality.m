% curse of dimensionality
f = 0:0.01:1;
d = 1:1:10;

length_f = length(f);
length_d = length(d);

fh(1) = figure(1);
subplot(2,2,1)
xc=0.5; yc=0.5; zc=0.5;    % coordinated of the center
L=1;                 % cube size (length of an edge)
alpha=0.1;           % transparency (max=1=opaque)

X = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
Y = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
Z = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];

C='blue';                  % unicolor

X = L*(X-0.5) + xc;
Y = L*(Y-0.5) + yc;
Z = L*(Z-0.5) + zc; 

fill3(X,Y,Z,C,'FaceAlpha',alpha);    % draw cube
hold on
xc=0.1; yc=0.1; zc=0.1;
L=0.2;
C = 'red';
X = L*(X-0.5) + xc;
Y = L*(Y-0.5) + yc;
Z = L*(Z-0.5) + zc;
fill3(X,Y,Z,C,'FaceAlpha',alpha);    % draw cube
hold on
view([33,33])
axis equal

subplot(2,2,2)
for i=1:length_d
    for j=1:length_f
        e_Df(j) =f(j)^(1/d(i));
    end
    plot(f, e_Df,'b')
    hold on
end
grid on
axis on
xlabel('Fraction of the data in meighborhood')
ylabel('Edge length of the cube')
%print('cube_edge_lengs_vs_data_fracton.pdf','-dpdf','-bestfit')


subplot(2,2,3)
plot([0,0],[0,1],'b')
hold on
plot([0,1],[1,1],'b')
hold on
plot([1,1],[1,0],'b')
hold on
plot([1,0],[0,0],'b')
hold on
theta=0:0.01:2*pi;
radius = 0.5;
x = radius * cos(theta) + 0.5;
y = radius * sin(theta) + 0.5;
plot(x, y)
axis equal

subplot(2,2,4)
clc
clear
[x y z] = sphere;
a=[0.5 0.5 0.5 0.5]
s1=surf(x*a(1,4)+a(1,1),y*a(1,4)+a(1,2),z*a(1,4)+a(1,3));
hold on
daspect([1 1 1])
xc=0.5; yc=0.5; zc=0.5;    % coordinated of the center
L=1;                 % cube size (length of an edge)
alpha=0.1;           % transparency (max=1=opaque)

X = [0 0 0 0 0 1; 1 0 1 1 1 1; 1 0 1 1 1 1; 0 0 0 0 0 1];
Y = [0 0 0 0 1 0; 0 1 0 0 1 1; 0 1 1 1 1 1; 0 0 1 1 1 0];
Z = [0 0 1 0 0 0; 0 0 1 0 0 0; 1 1 1 0 1 1; 1 1 1 0 1 1];

C='blue';                  % unicolor

X = L*(X-0.5) + xc;
Y = L*(Y-0.5) + yc;
Z = L*(Z-0.5) + zc; 

fill3(X,Y,Z,C,'FaceAlpha',alpha);    % draw cube
hold on
view(30,10)
print('curse_of_dimensionality_1.pdf','-dpdf','-bestfit')



        
    
