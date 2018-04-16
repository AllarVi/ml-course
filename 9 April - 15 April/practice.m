D = rand(2, 800);

figure(1)
plot(D(1, :), D(2, :), '+r')


net = selforgmap([5, 6]);
net = configure(net, D);

figure(2)
plotsompos(net)

net.trainParam.epochs = 10;
net = train(net, D);

figure(3)
plotsompos(net)

