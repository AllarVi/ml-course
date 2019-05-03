function derivative = getSigmoidDerivative(sigmoidOutput)
    derivative = sigmoidOutput * (1.0 - sigmoidOutput);
end