// https://mc-stan.org/docs/2_22/stan-users-guide/linear-regression.html

data{
  
  int<lower=0> n;
  matrix[n, 6] Xmat; // associated with fixed effects
  vector[n] longe;
}

parameters{
  
  vector[6] beta; // fixed effects vector
  real<lower=0> sig;
}

model{
  
  longe ~ normal(Xmat * beta, sig); 

  // priors:

  beta ~ normal(0, 100); // beta0, beta1 ~iid N(0, 100^2)
  
  sig ~ lognormal(0, 10);
}
