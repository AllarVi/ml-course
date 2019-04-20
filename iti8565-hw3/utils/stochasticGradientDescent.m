function weights = stochasticGradientDescent(train, learningRate, n_epoch, activationFunction, activationFunctionType)
    weights = zeros(1, size(train, 2) + 1); % add bias as first weight

    for i = 1:n_epoch
        sumError = 0;

        for j = 1:size(train, 1)
            row = train(j, :);

            prediction = activationFunction(row, weights, activationFunctionType);
            error = row(end) - prediction; % error -> cost?

            sumError = sumError + error^2;

            % update bias
            weights(1) = weights(1) + learningRate * error;

            % update weights
            for k = 1:size(row, 2)
                weights(k + 1) = weights(k + 1) + learningRate * error * row(k);
            end
        end
        fprintf('>epoch=%d, lrate=%.3f, error=%.3f \n', i, learningRate, sumError)
    end
end