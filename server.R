# load necessary packages
# and source your functions.R file

library(shiny)
library(tidyverse)

source("functions.R")

server <- function(input, output){
  
  # Load data once
  df <- read.csv("data/spotify.csv")
  
  output$plot1 <- renderPlot({
    req(input$myvar, input$search_str)
    
    make_spotify_plot(
      df = df,
      xvar = input$myvar,
      min_streams = input$search_str,
      color_mode = input$color_mode
    )
  })
}