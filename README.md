Generating OWA weights using truncated distributions
========================================================================

## Description

This project contains several R function to generate ordered weighted averaging (OWA) weights using truncated distributions as described in [[1]](https://onlinelibrary.wiley.com/doi/full/10.1002/int.21963). In this paper, we introduce an OWA determination method based on truncated distributions that enables intuitive generation of OWA weights according to a certain level of risk and trade-off. These two dimensions are represented by the two first moments of the truncated distribution. We illustrate our approach with the well-know normal distribution and the definition of a continuous parabolic decision-strategy space. We finally study the impact of the number of criteria on the results.

## Contents of the package

The R script **owg.R** proposes several functions to generate OWA weights according to a certain level of risk and trade-off using the truncated normal distribution.

The R script  **ED.R** proposes several functions to design an experimental design and automatically generate OWA weights according to a certain number of criteria and a list of couple of risk and trade-off values.


## Interactive web application

A Shiny application has also been designed to visualize the obtained distribution, to download the associated weights and to design experimental deigns. 

https://maximelenormand.shinyapps.io/OWA_weights_generator/

## Citation

If you use this code, please cite:

[1] Lenormand M (2018) [Generating OWA weights using truncated distributions.](https://onlinelibrary.wiley.com/doi/full/10.1002/int.21963) *International Journal of Intelligent Systems* 33, 791–801.

If you need help, find a bug, want to give me advice or feedback, please contact me!
You can reach me at maxime.lenormand[at]irstea.fr
