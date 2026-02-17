# load necessary packages
# and source your functions.R file

library(shiny)
library(tidyverse)

source('functions.R')

server <- function(input, output){
  
  # Load data once
  df <- read.csv("data/spotify.csv")
  
  #Improves labels (not raw labels from the dataset)
  x_labels <- c(
    released_month = "Released Month",
    key            = "Key",
    bpm            = "Beats Per Minute",
    danceability   = "Danceability Score",
    energy         = "Energy Score",
    liveness       = "Liveness Score"
  )
  # Custom (non-default) colors for mode
  mode_cols <- c(
    Major = "pink",  
    Minor = "purple"
  )
  
  output$plot1 <- renderPlot({
    req(input$search_str, input$myvar)
   
    df <- df %>%
      mutate(
        #Adds clean labels
        Mode = case_when(
          mode == 1 ~ "Major",
          mode == 0 ~ "Minor",
          mode %in% c("Major", "Minor") ~ as.character(mode),
          TRUE ~ NA_character_
        ),
        # Flag above/below the minimum streams input value
        AboveMin = streams_mill >= input$search_str
      )
  
    #Plot: keeps all points and grays out the ones below the input value 
    p <- ggplot(df, 
                aes(x = .data[[input$myvar]], 
                    y = streams_mill)) +
      geom_point(
        data = df %>% filter(!AboveMin),
        color = "gray",
        alpha = 0.7
      ) +
      geom_hline(yintercept = input$search_str, linewidth = 0.6) +
      labs(
        x = x_labels[[input$myvar]],
        y = "Streams (millions)"
      ) +
      theme_minimal()
    
    # Above-threshold points: color by mode if checked; otherwise black
    if (isTRUE(input$color_mode)) {
      p <- p +
        geom_point(
          data = df %>% filter(AboveMin),
          aes(color = Mode),
          alpha = 0.85
        ) +
        scale_color_manual(values = mode_cols, name = "Mode")
    } else {
      p <- p +
        geom_point(
          data = df %>% filter(AboveMin),
          color = "black",
          alpha = 0.85
        )
    }
    
    p
  })
}