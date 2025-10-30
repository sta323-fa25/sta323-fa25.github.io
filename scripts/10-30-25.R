set.seed(323)
## Practice at end of class
N = 1E5
x = rnorm(N, mean = 5, sd = sqrt(3))
h = function(x) {
  y = x[x < 1 | x > 9]
  z = x[x > 1 & x < 9]
  y = rep(0, length(y))
  z = log(z)
  hx = c(y, z)
  return(hx)
}
mean(h(x)) / sqrt(2 * pi * 3)