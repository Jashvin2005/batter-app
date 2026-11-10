# Load Packages
library(tidyverse)

# Loading Data from the given directory
batting_data = function(directory) {
  # Reading the csv file based on the given directory
  info = read_csv(file = directory)
  
  # Removing players' data who have switched into multiple teams in a season
  info = info[!grepl(",", info$Team), ]
  
  # Modifying the pre-existing data by removing some columns(since they are too many)
  info = info %>%
    select(-Level, -bbref_id, -X1B, -X2B, -X3B, -RBI, -BB, -IBB, -uBB, -OBP, -SLG, -OPS)
  
  # Returning modified data
  return(info)
}

# The number of attempts to steal bases and the percentage of stolen base
# attempts that were successful in a particular season and team
sb_attempts_perc = function(data) {
  data %>%
    mutate(sb_attempts = SB + CS) %>%
    mutate(sb_perc = round((SB / sb_attempts), 3))
}

# Strike Out Rate for a particular season and team
strike_out_rate = function(data) {
  data %>%
    mutate(so_rate = round((SO / PA), 3))
}