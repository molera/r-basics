# ===================================
# Title: Load and Recode ANES Data
# Author: Patrick
# Date: 12/03/25
# ===================================



# Packages ----------------------------------------------------------------

library(here)
library(tidyverse)



# Load raw data -----------------------------------------------------------

raw <- read_csv(here("data/anes_timeseries_2020_csv_20220210.csv"))

# There were some encoding issues but they don't affect variables we use
# problems(raw)
# colnames(raw)[1509]



# Data recoding -----------------------------------------------------------

table(raw$V202541a, useNA = "always")

anes <- raw %>% 
  mutate(
    across(starts_with("V202541"),
           ~ ifelse(.x >= 0, .x, NA)
    )
  ) %>% 
  transmute(
    ## Survey meta info
    id = V200001,
    mode = recode_factor(V200002,
                         `3` = "Web",
                         `2` = "Phone",
                         `1` = "Video"),
    
    ## Sociodemographics: age, gender, education
    age = na_if(V201507x, -9),
    female = na_if(V201600, -9) - 1,
    edu = recode(V201510,
                 `-9` = NA_real_,
                 `-8` = NA_real_,
                 `95` = NA_real_),
    college = as.numeric(edu >= 6),
    
    ## Social media exposure
    social = rowSums(across(V202541a:V202541h)) / 8,
    # social = (V202541a + V202541b + V202541c + V202541d + 
    #   V202541e + V202541f + V202541g + V202541h) / 8,
    
    ## Misinformation index: high values = belief in conspiracies
    
  )

table(raw$V202541i, anes$social, useNA = "always")


