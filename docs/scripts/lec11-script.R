library(tidyverse)

x = c(75, 58, 68)
L = function(mu, x) {
  stopifnot(is.numeric(x))
  n = length(x)
  logLikelihood = 0
  sigma = 8
  for(i in 1:n){
    logLikelihood = logLikelihood - 
      (0.5 / (sigma ^ 2)) * ((x[i] - mu) ^ 2)
  }
  return(logLikelihood)
}

ggplot() +
  xlim(c(50, 83)) +
  stat_function(fun = L, args = list(x = x)) +
  theme_bw() +
  labs(x = expression(mu), y = "likelihood") +
  geom_vline(xintercept = 67, col = "red")

                