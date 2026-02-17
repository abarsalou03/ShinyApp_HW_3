# Build your UI page here


ui <- fluidPage(
  # Fill in your details here
  h1("Visualizing Spotify Data"),
  p("In this Shiny App, we will interactively explor song data from a spotify data set. You will be able to choose an independent variable using a drop-down menu, remove songs under a certain minimum streams value, and use a checkbox to color the songs by mode."),
  

  br(),
  fluidRow( 
    column(6, selectInput("myvar", 
                          "Choose your independent variable:",
                          choices = list("Released Month"= "released_month",
                                         "Key" = "key",
                                         "Beats Per Minute" = "bpm",
                                         "Danceability Score" = "danceability",
                                         "Energy Score" = "energy",
                                         "Liveness Score" = "liveness"))),
    column(6, numericInput("search_str",
                            "Filter by this minimum number of streams:",
                            value = 1000,
                            min = 0,
                            step = 50)
    )
  ),
  
  br(),
  
  fluidRow(
    column(12, plotOutput("plot1", height = "600px"))
  ),
  
  br(),
  
  checkboxInput("color_mode", "Check to color by mode", value = TRUE)
)
