library(tidyverse)
library(ggplot2)
library(dplyr)

# Nice formatted labels
get_x_labels <- function() {
  c(released_month = "Released Month",
    bpm = "Beats Per Minute",
    danceability = "Danceability Score",
    energy = "Energy Score",
    liveness = "Liveness Score",
    key = "Key"
  )
}

# Custom colors (non-default)
get_mode_colors <- function() {
  c(Major = "pink",
    Minor = "purple"
  )
}

# Clean mode into Major/Minor labels
add_mode_label <- function(df) {
  df %>%
    mutate(
      Mode = case_when(
        mode == 1 ~ "Major",
        mode == 0 ~ "Minor",
        mode %in% c("Major", "Minor") ~ as.character(mode),
        TRUE ~ NA_character_
      )
    )
}

# Build the plot (uses: dropdown var, min streams filter, checkbox)
make_spotify_plot <- function(df, xvar, min_streams, color_mode,
                              x_labels = get_x_labels(),
                              mode_cols = get_mode_colors()) {
  
  # Ensure min_streams is numeric (prevents NA/TRUE-FALSE errors)
  min_streams <- suppressWarnings(as.numeric(min_streams))
  if (is.na(min_streams)) min_streams <- 0
  
  # Clean Mode labels
  df <- add_mode_label(df) %>%
    mutate(AboveMin = streams_mill >= min_streams)
  
  # Always keep Y axis static
  y_lim <- range(df$streams_mill, na.rm = TRUE)
  
  # Only compute x limits if x is numeric
  x_is_numeric <- is.numeric(df[[xvar]])
  if (x_is_numeric) {
    x_lim <- range(df[[xvar]], na.rm = TRUE)
  }
  
  # Base plot: gray points below threshold + cutoff line
  p <- ggplot(df, aes(x = .data[[xvar]], y = streams_mill)) +
    geom_point(
      data = df %>% filter(!AboveMin),
      color = "gray",
      alpha = 0.7) +
    geom_hline(yintercept = min_streams, linewidth = 0.6) +
    labs(
      x = if (!is.null(x_labels[[xvar]])) x_labels[[xvar]] else xvar,
      y = "Streams (millions)") +
    theme_minimal()
  
  # Keep axes static: always lock y and lock x only when numeric
  if (x_is_numeric) {
    p <- p + coord_cartesian(xlim = x_lim, ylim = y_lim)
  } else {
    p <- p + coord_cartesian(ylim = y_lim)
  }
  
  # Above-threshold points: color by mode if checked; otherwise black
  if (isTRUE(color_mode)) {
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
}