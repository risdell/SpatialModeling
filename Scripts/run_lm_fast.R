library(faraway)

data(fruitfly)
View(fruitfly)

lmod <- lm(longevity ~ thorax + activity, data=fruitfly)
Xmat <- model.matrix(lmod)

n <- nrow(Xmat)



library(rstan)

options(mc.cores = parallel::detectCores())
rstan_options(auto_write = TRUE)

dat <- list( longe=fruitfly$longevity,
             Xmat=Xmat,
             n=n)

mod <- stan_model("lm_fast.stan")


fit <- sampling(mod,
                 data = dat,
                 iter = 6000,  ## `iter` _includes_ `warmup` count
                 warmup = 1000,
                 chains = 2,  ## default is 4
                 thin = 2, ## default is 1
                 # control = list(adapt_delta = .9) ## https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
)

traceplot(fit, pars=c("beta", "sig"))
plot(fit, pars=c("beta", "sig"))

