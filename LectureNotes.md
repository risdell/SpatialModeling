# Spatial Modeling Lecture Notes

------------------------------------------------------------------------

# Lecture 1 - TITLE

Date: 2022-07-26

 - Homework assignment 1:
Use pre-existing dataset and demonstrate how to graphically display the data

## Last lecture of MSCI 679
 - Point referenced data - data is from single point rather than areal
 - Data are spatially isolate/sparse, but we want to infer smooth continuous 2D map
 - The smoothing is an attempt to address the dependecy structure of the residuals
 	 - Note that inverting matrices can RAPIDLY become very computationally intensive
 - Markov random field modeling
 	 - Areal data where the dataset forms a contiguous surface

## Overview of methods
 - [Stanford Stats 253 Lectures](https://web.stanford.edu/class/stats253/lectures.html)
 - When you account for the dependence of the data, the variance (condfidence interval) increases because of pseudoreplication - the variance of the **estimation** increases becuase you're making inferences from fewer independent observations
 - For geostatistical models, typically build upon an exponential decay structure
 - This is part of the Matern family
 
 
 
 
## For Grace
There are a lot of sloppy statistics out there. I think that most people don't understand the underlying assumptions of most statistical tests, and what violations of those tests mean for **inference vs. prediction** 
