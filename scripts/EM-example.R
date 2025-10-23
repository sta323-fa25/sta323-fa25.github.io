library(tidyverse)

#####################
### simulate data ###
#####################
set.seed(5)
N = 250
trueLambda = 0.01
xcomplete = rexp(N, rate = trueLambda) %>% round(digits = 3)
c = 100 # censor time

x = xcomplete
x[x >= 100] = 100

y = x[x < 100]
z = x[x == 100]
xdf = data.frame("obs" = xcomplete)

################################
## E-step and M-step combined ##
################################

lambda = 1
N = length(x)
Nc = length(z)
for (i in 1:100) {
  numerator = N
  denominator = sum(y) + (Nc * (c + 1 / lambda))
  lambda = numerator / denominator
}

lambda #EM

###########################################
### Compare to traditional MLE estimate ###
########################################### 

mle = N / sum(x) # without modeling censoring

######################
#### some visuals ####
######################

xdf %>%
  ggplot(aes(x = obs)) + 
  geom_histogram(bins = 30, aes(y = ..density..), alpha = 0.5) +
  stat_function(fun=dexp, args = list(rate = lambda), aes(color = "Censoring MLE")) +
  xlim(0, 120) +
  stat_function(fun=dexp, args = list(rate = mle), aes(color = "Naive MLE")) +
  stat_function(fun=dexp, args = list(rate = trueLambda), aes(color = "truth")) +
  labs(x = "complete data", title = "Estimated and true exponential curves") +
  scale_color_manual(values = c("Censoring MLE" = "steelblue", "Naive MLE" = "red", "truth" = "black"))

# red: traditional MLE
# blue: our EM approach w/ censoring modeled
# black: true curve from which data are simulated
  

