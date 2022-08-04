library(faraway)

thorax <- unstack(fruitfly[,-2])
longevity <- unstack(fruitfly[,-1])

thorax$many <- c(thorax$many,0) # use `0` not `NA` to prevent Stan from complaining
thorax <- t(as.data.frame(thorax))
thorax <- thorax[c(1:3,5,4),]

longevity$many <- c(longevity$many,0) # use `0` not `NA` to prevent Stan from complaining
longevity <- t(as.data.frame(longevity))
longevity <- longevity[c(1:3,5,4),]

library(rstan)

options(mc.cores = parallel::detectCores())

dat <- list(thorax=thorax,
            longevity=longevity)

mod <- stan_model("lmm_readable.stan")

options(mc.cores = parallel::detectCores())

fit <- sampling(mod,
                 data = dat,
                 iter = 30000,  ## `iter` _includes_ `warmup` count
                 warmup = 10000,
                 chains = 2,  ## default is 4
                 thin = 2, ## default is 1
                 control = list(adapt_delta = .9) ## https://mc-stan.org/misc/warnings.html#divergent-transitions-after-warmup
)

fit_par <- extract(fit)

plot(density(fit_par$rho, adjust=2), type="l", col="red",
     xlim=c(0,1), xlab="rho", 
     main=paste("marginal posterior for rho\n with median and 95% credible interval"))

abline(v=quantile(fit_par$rho, probs=c(.025,.5, .975)))
