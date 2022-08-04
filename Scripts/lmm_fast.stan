// https://mc-stan.org/docs/2_22/stan-users-guide/linear-regression.html

data{
  
  int<lower=0> n;
  matrix[n, 2] Xmat; // associated with fixed effects
  matrix[n, 5] Umat; // associated with random effects
  vector[n] longe;
}

parameters{
  
  vector[2] beta; // fixed effects vector
  vector[5] gamma; // random effects vector
  real<lower=0> sig;
  real<lower=0> sig_g;
}

transformed parameters{
  
  real rho;

  rho = sig_g^2 / (sig^2 + sig_g^2); 
}
  
model{
  
  gamma ~ normal(0, sig_g); // gamma[i] ~iid N(0, sig_g^2)
  
  longe ~ normal(Umat * gamma + Xmat * beta, sig); 

  // priors:

  beta ~ normal(0, 100); // beta0, beta1 ~iid N(0, 100^2)
  
  sig ~ lognormal(0, 10);
  sig_g ~ lognormal(0, 10);
}
