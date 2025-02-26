# ========================================================================= #
# R Session 6: Data Cleaning
# Author: Patrick
# Date: 26/02/2025
# ========================================================================= #

library(tidyverse)
library(haven)
library(labelled)

raw <- read_dta("data/qog_bas_ts_jan23_stata14.dta") 
raw


# Data overview -----------------------------------------------------------

summary(raw$vdem_gender)

ggplot(raw, aes(x = vdem_gender)) +
  geom_histogram(aes(y = after_stat(density)),
                 fill = "white", col = "black") +
  geom_density()

var_label(raw$vdem_gender)
val_labels(raw$vdem_gender)

ggplot(raw, aes(y = vdem_gender,
                x = vdem_libdem)) +
  geom_point(alpha = .1)


# Data transformation with dplyr ------------------------------------------

# Let' select a few variables before we start

qog <- raw %>% 
  select(year, cname, ht_region, vdem_gender, vdem_libdem)


## filter() ----------------------------------------------------------------

qog %>% 
  filter(vdem_gender == max(vdem_gender, na.rm = T))

qog %>% 
  filter(vdem_gender >= quantile(vdem_gender, .95, na.rm = T))

qog %>% 
  filter(vdem_gender > .95)

qog %>% 
  filter(vdem_gender > .95 & ht_region == 5)

qog %>% 
  filter(vdem_gender > .95 & (ht_region == 5 | ht_region == 1))

qog %>% 
  filter(vdem_gender > .95 & ht_region %in% c(5, 1))

high_empowerment <- qog %>% 
  filter(vdem_gender > .95 & ht_region %in% c(5, 1))
high_empowerment


# arrange() -----------------------------------------------------------------

qog %>% 
  arrange(vdem_gender)

qog %>% 
  arrange(desc(vdem_gender))

qog %>% 
  arrange(year, desc(vdem_gender))
