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


## arrange() -----------------------------------------------------------------

qog %>% 
  arrange(vdem_gender)

qog %>% 
  arrange(desc(vdem_gender))

qog %>% 
  arrange(year, desc(vdem_gender))


## mutate() and transmute() ----------------------------------------------------------------

qog %>% 
  mutate(
    index = (vdem_gender + vdem_libdem) / 2,
    gender_dummy1 = vdem_gender > median(vdem_gender, 
                                         na.rm = T),
    gender_dummy2 = as.numeric(gender_dummy1)
  )

tmp <- qog %>% 
  transmute(
    index = (vdem_gender + vdem_libdem) / 2,
    gender_dummy1 = vdem_gender > median(vdem_gender, 
                                         na.rm = T),
    gender_dummy2 = as.numeric(gender_dummy1)
  )


## select() ----------------------------------------------------------------

raw %>% 
  select(year, cname, ht_region, vdem_gender, vdem_libdem)

raw %>% 
  select(cname:version)

raw %>% 
  select(!cname:version)

raw %>% 
  select(starts_with("vdem_"))

## other helper functions to select variables: 
## ends_with()
## contains()
## num_range("x", 1:3) -> match x1 x2 x3

raw %>% 
  select(where(is.character))


## rename() ------------------------------------------------------------------

qog %>% 
  rename(libdem = vdem_libdem)


## relocate() --------------------------------------------------------------

raw %>% 
  relocate(vdem_gender, vdem_libdem)

raw %>% 
  relocate(vdem_gender, vdem_libdem, .after = year)


raw %>% 
  relocate(starts_with("vdem_"), .before = cname)


# Why do we like the pipe? ------------------------------------------------

raw %>% 
  mutate(gender_dummy = as.numeric(vdem_gender > .9)) %>% 
  filter(gender_dummy == 1) %>% 
  select(cname, year, vdem_gender) %>% 
  arrange(year) %>% 
  distinct(cname, .keep_all = TRUE)


# Groups and group_by() ---------------------------------------------------

qog %>% 
  group_by(ht_region)

qog %>% 
  group_by(ht_region) %>% 
  summarize(
    avg_gender = mean(vdem_gender, na.rm = TRUE)
  )

qog %>% 
  summarize(
    avg_gender = mean(vdem_gender, na.rm = TRUE)
  )

qog %>% 
  summarize(
    avg_gender = mean(vdem_gender, na.rm = TRUE),
    .by = ht_region
  )

qog %>% 
  group_by(ht_region, year) %>% 
  summarize(
    avg_gender = mean(vdem_gender, na.rm = TRUE),
    sd_gender = sd(vdem_gender, na.rm = TRUE),
    n = n(),
    se_gender = sd_gender/sqrt(n),
    cilo = avg_gender - 1.96 * se_gender,
    cihi = avg_gender + 1.96 * se_gender
  ) %>% 
  na.omit() %>% 
  ggplot(aes(x = year, y = avg_gender,
             ymin = cilo, ymax = cihi)) +
  geom_line() +
  #geom_pointrange() +
  geom_ribbon(fill = "blue", alpha = .2) +
  facet_wrap(~ht_region, axes = "all") +
  theme_bw()

qog %>% 
  group_by(ht_region, year) %>% 
  summarize(
    avg_gender = mean(vdem_gender, na.rm = TRUE)
  ) %>% 
  ungroup() %>% 
  summarize(avg = mean(avg_gender, na.rm = TRUE))


## slice() -----------------------------------------------------------------

tmp <- qog %>% 
  filter(year == 2010) %>% 
  group_by(ht_region) %>% 
  slice_max(vdem_gender, n = 1)
tmp

tmp %>% 
  filter(ht_region == 5) %>% 
  pull(vdem_gender)

## There are several slicing commands
## slice_max(x, n = 1) takes the row with the largest value of column x
## slice_min(x, n = 1) takes the row with the smallest value of column x
## slice_head(n = 1) takes the first row of each group
## slice_tail(n = 1) takes the last row of each group
## slice_sample(n = 1) takes a random row


# Data tidying with tidyr -------------------------------------------------

tmp <- qog %>% 
  group_by(year, ht_region) %>% 
  summarize(avg_gender = mean(vdem_gender, na.rm = T)) %>% 
  na.omit()

wide <- tmp %>% 
  pivot_wider(names_from = "year",
              values_from = "avg_gender")

long <- wide %>% 
  pivot_longer(-ht_region,
               names_to = "yearX",
               values_to = "gender") %>% 
  na.omit()


