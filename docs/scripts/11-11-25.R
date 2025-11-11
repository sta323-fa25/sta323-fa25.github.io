# Beta-binomial 
## Likelihood
# n - # of coin flips
# x - # of heads out of n flips
# p - probability of seeing a heads
# x ~ Binom(n, p)
#
# Prior
# a - # of pseudo-success (heads)
# b - # of pseudo-failures (tails)
# p ~ beta(a,b)
# 
# Bayes Theorem
# f(p|x) = f(x|p) f(p)
#.        -------------
#.            f(x)
# Posterior
## p | x ~ beta(a + x, b + n - x)


### App 

library(tidyverse)
library(shiny)
# Define UI for application
ui <- fluidPage(
  title = "Beta-Binomial Shiny App",
  titlePanel("Beta-Binomial Shiny App"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      h4("Data:"),
      sliderInput("n", h3("# of coin flips"),
                  min = 0, max = 100, value = 50),
      sliderInput("x", h3("# of heads"),
                  min = 0, max = 100, value = 25),
      h4("Prior:"),
      numericInput("a", 
                   h3("prior # of heads"), 
                   value = 1),
      numericInput("b", 
                   h3("prior # of tails"), 
                   value = 1) 
    ),
    

    mainPanel = mainPanel(
      plotOutput("plot")
    )
  )
)
# Define server logic
server <- function(input, output, session) {
  
 # make your app more robust
   observeEvent(
    # watch for a change in the input "n"
    input$n, {
      updateSliderInput(session, inputId = "x", max = input$n)
    }
  )
  
  output$plot = renderPlot({
    
    # likelihoods are not densities
    # so we have to rescale and put the input on the same magnitude
    dbinom_rescale = function(x, size, p) {
      c = integrate(dbinom, lower = 0, upper = 1, x = x, size = size)
      dbinom(x = x, size = size, p) / c$value
    }
    
    g = ggplot() +
      xlim(0, 1) +
      stat_function(aes(color = "prior"), fun = dbeta, args = 
                      list(shape1 = input$a, shape2 = input$b)) +
      stat_function(aes(color = "Likelihood"), fun = dbinom_rescale,
                    args = list(x = input$x, size = input$n)) +
      stat_function(aes(color = "posterior"), fun = dbeta, args = 
                      list(shape1 = input$a + input$x,
                           shape2 = input$b + input$n - input$x))
    g
  })

}
# Build and run the application
shinyApp(ui = ui, server = server)