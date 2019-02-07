% NB! this script is not finished


view([33,33])
axis equal

subplot(2,2,2)

for i=1:length_d
    for j=1:length_f
        e_Df(j)=f(j)^(1/d(i));
    end
    plot(f,e_Df, 'b')
    hold on
end

grid on
axis on

xlabel('Fraction of the data in neighborhood')
ylabel('Edge length of the cube')