library(faraway)

fruitfly$activity
iso <- ifelse(fruitfly$activity=="isolated", 1, 0)
one <- ifelse(fruitfly$activity=="one", 1, 0)
low <- ifelse(fruitfly$activity=="low", 1, 0)
many <- ifelse(fruitfly$activity=="many", 1, 0)
high <- ifelse(fruitfly$activity=="high", 1, 0)
Umat <- data.frame(iso, one, low, many, high)
View(Umat)

Xmat <- model.matrix( longevity ~ thorax, data=fruitfly)

n <- nrow(Umat)



library(rstan)

options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

dat <- list( longe=fruitfly$longevity,
             Xmat=Xmat, Umat=Umat,
             n=n)

mod <- stan_model("lmm_fast.stan")


fit <- sampling(mod,
                 data = dat,
                 iter = 16000,  ## `iter` _includes_ `warmup` count
                 warmup = 10000,
                 chains = 2,  ## default is 4
                 thin = 2, ## default is 1
                 # control = list(adapt_delta = .9) ## https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
)

traceplot(fit, pars=c("beta", "sig", "sig_g"))
plot(fit, pars=c("gamma"))

fit_par <- extract(fit)

plot(density(fit_par$rho, adjust=2), type="l", col="red",
     xlim=c(0,1), xlab="rho", 
     main=paste("marginal posterior for rho\n with median and 95% credible interval"))

abline(v=quantile(fit_par$rho, probs=c(.025,.5, .975)))
