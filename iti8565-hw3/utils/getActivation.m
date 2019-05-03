function activation = getActivation(row, weights, activationFunction)
% prediction/activation
prediction = LinearRegression.predict(row, weights);

if (activationFunction == "binaryStep")
    if (prediction >= 0.0)
        activation = 1.0;
    else
        activation = 0.0;
    end
elseif (activationFunction == "logistic")
    activation = 1.0 / (1.0 + exp(-prediction));
else
    error('Error. Invalid "activationFunction" parameter!')
end
end