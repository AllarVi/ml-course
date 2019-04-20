clear
clc

x_min = -2;
x_max = 2;
y_min = -2;
y_max = 2;
%h= 0.2;
steps = 20;
weights = [0.5, 2];

xx = linspace(x_min, x_max, steps); % creates 1x20 matrix

yy = linspace(y_min, y_max, steps); % 1x20

[x, y] = meshgrid(xx, yy); % x = 20x20 and y = 20x20

z_actuals = SurfaceGenerator(x, y, weights); % z = 20x20

fh(1) = figure(1);
clf(fh(1));
surf(x, y, z_actuals)
grid on
print('neuron_surface.pdf', '-dpdf', '-bestfit')


z_noise = rand(steps, steps) * 0.05; % add some noise
z_actuals = z_actuals + z_noise;

fh(1) = figure(1);
clf(fh(1));
surf(x, y, z_actuals)
grid on
print('initial_surface.pdf', '-dpdf', '-bestfit')

XY = [reshape(x, [], 1), reshape(y, [], 1)];

[L, ~] = size(XY);
learningRate = 2; % learning constant
weights = [3.5, 5];

%fh(2)=figure(2);
n_epoch = 67;

for epochIdx = 1:n_epoch
    z_predictions = SurfaceGenerator(x, y, weights);
    
    errors = z_actuals - z_predictions;
    errorsSqr = errors.^2;
    
    NeuronTrainingVisualisation(x, y, z_actuals, z_predictions, errors, errorsSqr);
    %clf(fh(2))
    %mesh(x,y,z,'FaceAlpha',0.1)
    %hold on
    %surf(x,y,z_current,'FaceAlpha',0.7)
    %hold on
    SSE(epochIdx) = sum(sum(errorsSqr));
    
    z_actuals_vector = reshape(z_actuals, [], 1); % reshape matrix to one vector by columns
    
    % compute Jacobian
    for l = 1:L
        for k = 1:2
            %compute exp
            current_exp = exp(weights(1) * XY(l, 1) + weights(2) * XY(l, 2));
            
            jcb(l, k) = 2 * ((-z_actuals_vector(l) * XY(l, k) * current_exp) / ((current_exp + 1)^2) + (XY(l, k) * (current_exp^2)) / (current_exp + 1)^3);
        end
    end
    
    errors_vector = reshape(errors, [], 1);
    
    weights = weights - (inv(jcb'*jcb + learningRate * eye(2))* (2 * jcb'* errors_vector))'; % update weights
    
    weightsHistory(epochIdx, :) = weights;
    
    pause(0.1)
end

fh(3) = figure(3);
clf(fh(3))
plot(weightsHistory(:, 1))
hold on
plot(weightsHistory(:, 2))
hold on
grid on
xlabel('Epoch')
ylabel('weightsHistory')
print('weights_evolution.pdf', '-dpdf', '-bestfit')
