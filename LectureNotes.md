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
 
# Lecture 4 - Spatial modeling vs prediction

 - Prediction using least-squares
 	 - use the Best Linear Unbiased Prediction (BLUP) if you want to look away from unbiasedness
 	 - Kriging
 	 	 - we can use universal kriging now which incorporates uncertainty due to the model
 - In Gelfand 2010, eq. 1.5 is SAR, and eq. 1.6 is CAR
 	 - SAR vs. CAR
 	 - The AR means your regressing something on itself
 	 - SAR means that the distribution of location i depends on the entire set of locations
 	 - CAR means that the distribution of location i only depends on it's "neighbors"
 	 	 - ICAR assumes $\alpha$ to be 1 - this just really speeds up computation
 	 	 - CAR does not require $\alpha$ to be 1
 - Gelfand 2010, sections 3.5 and 3.7
 	 - Grace recommends not stressing over getting the "right" semivariogram. Pick one, try it, and if it's not working out, pick another.
 	 - kriging is synonymous with spatial smoothing which is synonymous with spatial modeling
 - Bayesian kriging
 	 - Bayesian works so well because *everything* is a conditional statement
 - For Bayesian spatial modeling, always put the spatial correlation in the process level, not the data level
 - Kriging pushes the surface to make the standard error zero where the data points are - i.e., that the data are the truth (no uncertainty around the measurements)
 - CAR creates a sparse matrix by creating an adjacency matrix
 - The Morris et al 2019 slides show how to express an ICAR the absolute fastest
 
 
## How long did Challen's CAR+AR model take?
## What are the problems with assuming N-nearest neighbors for point data?

# Lecture 5 - Areal data, MRF models, and spatial models in ecology

 - Make sure to reference the misalignment of your response and covariates spatially (e.g., $y$ is per individual, $x$ is per quad) in [Gelfand Ch. 29](https://ebookcentral-proquest-com.proxy.wm.edu/lib/cwm/detail.action?docID=555701).
 - Markov Random Fields
 	 - Jargon in temporal models
 	 - Markov random fields is just a fancy way to say CAR model
 	 	 - MRF can be continuous while CAR is typically discrete
 	 - [MRF example](https://rpubs.com/chrisbrunsdon/sds3)
 	 - GAMs in mgcv can be useful for quick estimation of whether to include various terms/interactions
 - Ver Hoef paper:
 	 - SAR models do not require that the **W** matrix does not have to be symmetric
 	 	 - think about times where site 1 has more influence on site 2 than site 2 has on site 1
 	 	 
# Lecture 6 - Spatiotemporal modeling

 - spatautolm() in `spatialreg` provides a quick way of testing whether you even need a spatial model
 - For spatiotemporal, use muliplicative vs. additive for "separable" terms
 - conditional separability means fixing space and looking at time (sequentially) or fixing time and looking at space
 - Challen's presentation
 	 - Could you have settled on a finer bin distance and then done a SRS approach?
 	 - Offset is just a forced division in the model where the $\beta$ is set to 1
 	 - The weights matrix is dependent on the number of neighboring polygons
 	 - LOO starts to break down when you have autocorrelation among the covariance, where it can sort of infer what's missing in these systems, so you overestimate how well your model is doing
 	 - 
