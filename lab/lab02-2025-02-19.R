# ========================================================================= #
# R Session 5: Data Visualization with ggplot
# Author: Patrick
# Date: 19/02/2025
# ========================================================================= #


# Load packages and data --------------------------------------------------

library(tidyverse)
library(patchwork)
library(ggthemes)


# Base R loading csv data
qog <- read.csv("data/qog_bas_cs_jan25.csv")
class(qog)
qog

# Tidyverse loading csv data
qog <- read_csv("data/qog_bas_cs_jan25.csv")
class(qog)
qog


# Creating our first ggplot -----------------------------------------------

## Long version
ggplot(
  data = qog,
  mapping = aes(
    y = bti_su,
    x = mad_gdppc
  )
) +
  geom_point()

## Short version
ggplot(qog, aes(y = bti_su, x = mad_gdppc)) +
  geom_point()

## Let's look at globalization instead of GDP per capita
p1 <- ggplot(qog, aes(y = bti_su, x = dr_eg)) +
  geom_point()
p1

## What about democratization / form of government?
ggplot(qog, aes(y = bti_su, 
                x = dr_eg,
                color = as.factor(bmr_dem))) +
  geom_point() +
  geom_smooth(method = "lm")

## We can specify aesthetics specific for certain geometries
ggplot(qog, aes(y = bti_su, 
                x = dr_eg)) +
  geom_point(aes(color = as.factor(bmr_dem),
                 size = wdi_pop)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Sustainability and Globalization",
    subtitle = "Our first ggplot!",
    x = "Economic Globalization",
    y = "Sustainability",
    color = "Democracy",
    size = "Population Size"
  )

## Let's make this plot a little prettier
p2 <- qog %>%
  mutate(dem = recode_factor(bmr_dem,
                             '0' = "No",
                             '1' = "Yes")) %>% 
  filter(!is.na(dem)) %>% 
  ggplot(aes(y = bti_su, 
                x = dr_eg)) +
  geom_point(aes(color = dem,
                 size = wdi_pop/1e7)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Sustainability and Globalization",
    subtitle = "Our first ggplot!",
    x = "Economic Globalization",
    y = "Sustainability",
    color = "Democracy",
    size = "Population Size"
  ) +
  theme_bw()
p2
ggsave(file = "fig1.pdf", plot = p2, 
       width = 7, height = 5)

## We can combine plots using patchwork!
p1 + p2
p1 / p2
(p1 + p2)/p1

p2 + p1
ggsave("fig2.png", width = 9, height = 4)

# Explaining the pipe
# a %>% foo(na.rm = TRUE) is equivalent to foo(a, na.rm = TRUE)
#
# a <- foo(a)
# a <- bar(a)
# a <- bar2(a)
#
# is equivalent to
# 
# a <- a %>% 
#   foo() %>% 
#   bar() %>% 
#   bar2()

# We can also "edit" plots that we have already saved
p2 +
  scale_color_colorblind()

# The ggthemes package gives you a lot of additional themes and color scales for specific publications
help(package = "ggthemes")

p2 +
  theme_economist() +
  scale_color_economist()

