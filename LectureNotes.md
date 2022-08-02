# Spatial Modeling Lecture Notes

------------------------------------------------------------------------

# Lecture 1 - Introduction and Methods

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
 - When you account for the dependence of the data, the variance (condfidence interval) increases because of pseudoreplication 
 	 - the variance of the **estimation** increases becuase you're making inferences from fewer independent observations
 - For geostatistical models, typically build upon an exponential decay structure
 - This is part of the Matern family
 
 
 
 
## For Grace
There are a lot of sloppy statistics out there. I think that most people don't understand the underlying assumptions of most statistical tests, and what violations of those tests mean for **inference vs. prediction** 

# Lecture 2 - Point Processes and GIS approaches

 - Spatial domain - extent of spatial inferences
 	 - Critical to not extract beyond spatial domain due to complexity of these processes
 	 - The exact model is not generalizable, but there may be components that can be
 	 - When data are not homogeneously distributed across space, can be hard to resolve one or another axis
 	 - Data need to be contiguous for something like an exponential decay variance structure
 - Practical approach for spatial data
 	 - Start with simple model, then check the residuals; can probably quickly rule out iid
 	 - Plot the $\hat{\epsilon}$ vs all covariates in and out of the model
 	 - Then plot the $\hat{\epsilon}$ on a map. If pattern, then address spatial dependence
 - How to check if iid $\phi_t$?
 	 - resid plots including $\hat{\phi_t}$ vs. t
 - If unlikely iid, the nhow to check what dependence structure (for time)?
 	 - Plot the (P)ACF of $\hat{\phi_t}$
 	 - If pattern is cyclical, it's AR
 - Spatial equivalent is $\hat{\epsilon_s}$ vs. s
 	 - ACF is approximately the variogram
 	 - (P)ACF is approximately the correlogram
 - Look at page 4 of the 698-01-geostat-intro-notes.pdf to get understanding of the nugget
 	 - basically divides the error structure into a nugget vs. iid noise
 	 - the nugget describes the spatially dependent component
 	 - the iid noise is critical to make the models estimable
 	 - this creates a separable structure between $\phi$ and $\theta$

# Lecture 3 - Spatial modeling vs GIS approaches

 - Geostatistical weighting
 	 - using things like thiessen polygons, voronoi polygons
 	 - can set/specify your own weighting - see [Moran's I](https://rspatial.org/terra/analysis/3-spauto.html#compute-morans-i)
 - Bivand Section 8.4
 	 - The variance and the covariance depend on the expectation
 	 	 - variance reference is population mean
 	 	 - covariance reference is each other - the variogram is the covariance between points
 	 - automap package fits a variogram function for you
 	 - Grace doesn't spend much time fitting different variograms. Goes straight to working with gaussian, etc.
 - Check out the directional variograms in [McIntyre 2017](https://rstudio-pubs-static.s3.amazonaws.com/278913_fe56260e076a494fb87904a5c2f226dd.html)
 - `r '%nin%' <- Negate('%in%')`
