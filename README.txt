# Visualizing Spotify Data 

**Author:** Alyson Barsalou

This Shiny application provides an interactive way to explore Spotify song data using a scatter plot visualization. Users can select an independent variable, filter songs by a minimum number of streams, and optionally color points by musical mode (Major or Minor). The app is designed to demonstrate interactive data visualization in R.

Features
- Select an independent variable from a drop-down menu
- Filter songs by minimum streams (in millions)
- Scatter plot visualization of Spotify song data
- Optional color-coding by mode (Major/Minor)
- Gray points for songs below the selected stream threshold
- Horizontal cutoff line showing the filter value

Files in this project
- ui.R 
- server.R
- functions.R
- data/spotify.csv
- README.md
- data 

Required Packages 
- shiny
- tidyverse 