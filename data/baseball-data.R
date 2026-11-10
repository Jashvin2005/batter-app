# Load Packages
library(baseballr)
library(tidyverse)

# "bref_daily_batter" gets batter information from a single season
# Batter information for 2008 season stored in "all_batting_data"
all_batting_data = bref_daily_batter("2008-04-01", "2008-10-31")

start_year = 2009
end_year = 2024

# Merging batter information from 2009 to 2024 into "all_batting_data"
for (year in start_year:end_year) {
  start_date = paste0(year, "-04-01")
  end_date = paste0(year, "-10-31")
  
  # Collecting batter information from a particular season using "bref_daily_batter"
  season_data = bref_daily_batter(start_date, end_date)
  
  # Merging batter information from a particular season into "all_batting_data"
  all_batting_data = bind_rows(all_batting_data, season_data)
}

# Writing the final "all_batting_data" into the directory data/daily-batting.csv
write_csv(all_batting_data, "data/daily-batting.csv")