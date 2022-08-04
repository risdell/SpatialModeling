// https://mc-stan.org/docs/2_22/stan-users-guide/linear-regression.html
// reformat `fruitfly` so that
// `thorax` and `longevity` are each 5x25 matrices
// where `many` (i=5) has 1 `NA`  

data{
  real<lower=0> thorax[5,25];  
  real<lower=0> longevity[5,25];
}

parameters{
  real beta0i[5];
  real beta0;
  real beta1;
  real<lower=0> sig;
  real<lower=0> sig_g;
}

transformed parameters{
  
  real rho;
  
  rho = sig_g^2 / (sig^2 + sig_g^2); 
}

model{
  for(i in 1:4){
    for(j in 1:25){
      longevity[i,j] ~ normal(beta0i[i] + beta1 * thorax[i,j], sig);
    }
  }
  
  for(j in 1:24){
    longevity[5,j] ~ normal(beta0i[5] + beta1 * thorax[5,j], sig);
  }
  
  for(i in 1:5){
    beta0i[i] ~ normal(beta0, sig_g);
  }
  
  beta0 ~ normal(0, 100);
  beta1 ~ normal(0, 100);
  
  sig ~ lognormal(0, 10);
  sig_g ~ lognormal(0, 10);
}
