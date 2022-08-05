// The input data is a vector 'y' of length 'N'.
data {
  int<lower=0> n; // sample size
  int<lower=0> m; // number of variables in Xmat
  matrix[n, m] Xmat; // model matrix
  int<lower=0> count[n]; // response
  int<lower=0> N_edges;
  int<lower=1, upper=n> node1[N_edges];
  int<lower=1, upper=n> node2[N_edges];
}

// The parameters accepted by the model. Our model
// accepts two parameters 'mu' and 'sigma'.
parameters {
  vector[m] beta; // fixed effects beta
  vector[n-1] phi_raw;
  real<lower=0> sigma;
}

transformed parameters {
  vector[n] phi;
  phi[1:(n-1)] = phi_raw;
  phi[n] = -sum(phi_raw);
}

// The model to be estimated. We model the output
// 'y' to be normally distributed with mean 'mu'
// and standard deviation 'sigma'.
model {
  // Likelihood
  count ~ poisson_log(Xmat * beta + phi * sigma);
  target += -0.5 * dot_self(phi[node1]-phi[node2]);
  // Priors
  beta ~ normal(0, 10);
  sigma ~ exponential(0.5);
}

