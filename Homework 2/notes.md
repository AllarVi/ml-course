---
mainfont: Helvetica Neue
mainfontoptions: 
- BoldFont=Helvetica Neue Bold
- ItalicFont=Helvetica Neue Italic
- BoldItalicFont=Helvetica Neue Bold Italic
---
# Home Assignment 2 - Notes

Allar Viinamäe - 163578IAPM

## k-nearest neighbors algorithm

### Ideas For Extensions

This section provides you with ideas for extensions that you could apply and investigate with the Python code you have implemented as part of this tutorial.

* Regression: You could adapt the implementation to work for regression problems (predicting a real-valued attribute). The summarization of the closest instances could involve taking the mean or the median of the predicted attribute.
* Normalization: When the units of measure differ between attributes, it is possible for attributes to dominate in their contribution to the distance measure. For these types of problems, you will want to rescale all data attributes into the range 0-1 (called normalization) before calculating similarity. Update the model to support data normalization.
* Alternative Distance Measure: There are many distance measures available, and you can even develop your own domain-specific distance measures if you like. Implement an alternative distance measure, such as Manhattan distance or the vector dot product.

[tutorial](https://machinelearningmastery.com/tutorial-to-implement-k-nearest-neighbors-in-python-from-scratch/)

* Instance-based
  * model the problem using data instances
* competitive learning
  * internally uses competition between model elements
* lazy learning
  * does not build a model until the time that a prediction is required