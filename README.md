# Batter App

Batter App is an interactive R Shiny application for exploring, visualizing, and analyzing MLB batter statistics from 2008 to 2024. It allows fans and analysts to compare a batter's performance across seasons using line graphs and a data table.

## Author

Jashvin Reddy Gundala

I developed this app independently for Statistical Programming Methods at the University of Illinois Urbana-Champaign.

## Features

- Select a range of seasons, a team, and a player.
- Choose a statistic and view how it changes over time.
- Explore batting records in a table.
- Calculate stolen base attempts, stolen base success rates, and strikeout rates.

## Data

The data was collected using the baseballr package and saved in `data/daily-batting.csv`. The app reads this local file when it starts; it does not download the data on each launch.

The dataset covers seasons from 2008 to 2024. The app excludes records whose team field lists multiple teams within a season. Available statistics include games played, plate appearances, at bats, runs, hits, home runs, strikeouts, stolen bases, and batting average.

The helper functions also calculate:

- `sb_attempts`: stolen bases plus times caught stealing.
- `sb_perc`: stolen bases divided by stolen base attempts, stored as a proportion.
- `so_rate`: strikeouts divided by plate appearances.

## Technologies

R, Shiny, tidyverse, ggplot2, dplyr, and baseballr.

## Run the app

Download the repository and open its folder in RStudio. Install the packages below if needed:

```r
install.packages(c("shiny", "tidyverse", "markdown"))
```

Run this command from the project folder:

```r
shiny::runApp(".")
```

The included CSV is enough to start the app. The separate `data/baseball-data.R` script uses baseballr to collect data; running that script requires the baseballr package and internet access.

## Project files

- `app.R`: Shiny interface and application logic.
- `R/helper-functions.R`: data cleaning and batting metric calculations.
- `data/baseball-data.R`: data collection script.
- `data/daily-batting.csv`: batting dataset.
- `about.Rmd`: description displayed in the app's About tab.
- `baseball-app.Rproj`: RStudio project file.

## References

- [baseballr](https://billpetti.github.io/baseballr/)
- [Shiny components](https://shiny.posit.co/r/components/)
