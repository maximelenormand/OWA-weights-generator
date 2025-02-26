# Generating OWA weights using truncated distributions

## Description

This project contains several R function to generate ordered weighted averaging
(OWA) weights using truncated distributions as described in 
[[1]](https://onlinelibrary.wiley.com/doi/full/10.1002/int.21963). 
In this paper, we introduce an OWA determination method based on truncated 
distributions that enables intuitive generation of OWA weights according to a 
certain level of risk and trade-off. These two dimensions are represented by 
the two first moments of the truncated distribution. We illustrate our approach 
with the well-know normal distribution and the definition of a continuous 
parabolic decision-strategy space. We finally study the impact of the number 
of criteria on the results.

## Contents of the package

The R script **owg.R** proposes several functions to generate OWA weights 
according to a certain level of risk and trade-off using truncated normal 
distributions.

The R script **ED.R** proposes several functions to design an experimental 
design and automatically generate OWA weights according to a certain number 
of criteria and a list of couple of risk and trade-off values.

## Example

An example of use of these scripts in a GIS-MCDA context can be found in 
[this study](https://www.sciencedirect.com/science/article/pii/S0198971520302490). 
Code and data used in this study are available 
[here](https://github.com/maximelenormand/gis-mcda-owa).

## Interactive web application

A Shiny application has also been developed to visualize the obtained 
distribution, to download the associated weights and to design experimental 
deigns. This repository contains all the materials (R scripts, Rdata and www data
folder) needed to run [the app](https://owa.sk8.inrae.fr).

## Reference and citation

If you use this code, please cite the following reference:

[1] Lenormand M (2018) [Generating OWA weights using truncated distributions.](https://onlinelibrary.wiley.com/doi/full/10.1002/int.21963) 
*International Journal of Intelligent Systems* 33, 791–801. [[arXiv](https://arxiv.org/abs/1709.04328)]

If you need help, find a bug, want to give me advice or feedback, please contact me!

## Repository mirrors

This repository is mirrored on both GitLab and GitHub. You can access it via the following links:

- **GitLab**: [https://gitlab.com/maximelenormand/OWA-weights-generator](https://gitlab.com/maximelenormand/OWA-weights-generator)  
- **GitHub**: [https://github.com/maximelenormand/OWA-weights-generator](https://github.com/maximelenormand/OWA-weights-generator)  

The repository is archived in Software Heritage:

[![SWH](https://archive.softwareheritage.org/badge/origin/https://github.com/maximelenormand/OWA-weights-generator/)](https://archive.softwareheritage.org/browse/origin/?origin_url=https://github.com/maximelenormand/OWA-weights-generator)
