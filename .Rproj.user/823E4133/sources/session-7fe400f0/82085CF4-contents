# Quick Reference

This Shiny App allows you to Spotify music data files. It detects which variables are text-based, and sets up a drop-down to choose one such variable and then provides a text entry to search and filter the data sets. 
[Shiny Gallery for Quick Reference](https://shiny.posit.co/r/gallery/)

### Layout description
- Title and description across the top 
- Drop down menu towards the bottom left of the title that will allow the user to select the independent variable of their choice
- To the right of the drop down there will be a number input to filter the plot by removing songs with streams below the value that was put
- A large scatter plot graph in the center of the page displaying results
- A check box beneath the plot that allows the user to color the points of the plot by the songs "mode" (Major/Minor)

### Inputs
The bullets below take the general form:

> shiny Component  |  **variable_name** | optional: args

* selectedInput | **myvar** | choices: "released_month","key","bpm","danceability","energy","liveness"
* numericInput | **search_str** | minimum streams threshold (millions)
* checkboxInput | **color_mode** | TRUE/FALSE toggle to color points by Mode

### Outputs
The bullets below take the general form:

> Shiny Component  |  **variable_name**  | (inputs required)  | optional: function used

* plotOutput | **plot1** | "myvar", "search_str", "color_mode" | renderPlot(), ggplot2 

### Reactive components and Server

> component type | **variable_name(s)** | Events that trigger 

* renderPlot() | **output$plot1** | changes to "input$myvar", "input$search_str", "input$color_mode"
* Data transformation | **Mode, AboveMin columns** | recalculated whenever search_str changes


### Functions and Set up

> **function_name**  |  (inputs)  | purpose

* read.csv() | **"data/spotify.csv"** | loads the Spotify dataset into memory
* mutate() | **mode, streams_mill** | creates Mode (Major/Minor) and AboveMin (TRUE/FALSE)
* ggplot() + geom_point() | **myvar, streams_mill** | draws scatter plot of selected x-variable vs streams
* geom_hline() | **search_str** | draws line showing the minimum streams threshold
* scale_color_manual() | **mode_cols** | applies custom non-default colors (pink/purple) for Mode
