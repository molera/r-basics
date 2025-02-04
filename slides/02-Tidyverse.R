## ----setup, include=FALSE---------------------------------------------------------------------------------------
options(htmltools.dir.version = FALSE)


## ----eval = FALSE-----------------------------------------------------------------------------------------------
# leave_house(get_dressed(
#   get_out_of_bed(wake_up(me)), jacket = TRUE))


## ----eval = FALSE-----------------------------------------------------------------------------------------------
# me %>%
#   wake_up() %>%
#   get_out_of_bed() %>%
#   get_dressed(jacket = TRUE) %>%
#   leave_house()


## ----message=FALSE----------------------------------------------------------------------------------------------
library(tidyverse)


## ---------------------------------------------------------------------------------------------------------------
mpg


## ----p1, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point()


## ----ref.label = 'p1', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ----p2, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(mpg, aes(x = displ, y = hwy, col = class)) +
  geom_point()


## ----ref.label = 'p2', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ----p3, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  facet_wrap(~class, nrow = 2)


## ----ref.label = 'p3', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ----p4, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_smooth()


## ----ref.label = 'p4', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ----p5, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(mpg, aes(x = displ, y = hwy, col = drv)) +
  geom_point() +
  geom_smooth()


## ----ref.label = 'p5', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ----p6, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(aes(col = drv)) +
  geom_smooth()


## ----ref.label = 'p6', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ---------------------------------------------------------------------------------------------------------------
diamonds


## ----p7, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(diamonds, aes(x = cut)) +
  geom_bar()


## ----ref.label = 'p7', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ----p8, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(diamonds, aes(x = cut, 
                     y = after_stat(prop), 
                     group = 1)) +
  geom_bar()


## ----ref.label = 'p8', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ----p9, fig.show = 'hide'--------------------------------------------------------------------------------------
ggplot(diamonds, aes(x = cut, fill = clarity)) +
  geom_bar()


## ----ref.label = 'p9', echo = FALSE, message=FALSE, warning=FALSE-----------------------------------------------


## ----p10, fig.show = 'hide'-------------------------------------------------------------------------------------
ggplot(diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "fill")


## ----ref.label = 'p10', echo = FALSE, message=FALSE, warning=FALSE----------------------------------------------


## ----p11, fig.show = 'hide'-------------------------------------------------------------------------------------
ggplot(diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")


## ----ref.label = 'p11', echo = FALSE, message=FALSE, warning=FALSE----------------------------------------------


## ---------------------------------------------------------------------------------------------------------------
library(tidyverse)
library(nycflights13)

flights


## ---------------------------------------------------------------------------------------------------------------
flights %>%
  filter(arr_delay > 120 | dep_delay > 120)


## ---------------------------------------------------------------------------------------------------------------
flights %>%
  arrange(desc(month), day)


## ---------------------------------------------------------------------------------------------------------------
flights %>%
  select(dep_time, sched_dep_time)


## ---------------------------------------------------------------------------------------------------------------
flights_sml <- flights %>%
  select(year:day, ends_with("delay"), distance, air_time) %>%
  mutate(gain = dep_delay - arr_delay,
         speed = distance / air_time * 60)
flights_sml


## ---------------------------------------------------------------------------------------------------------------
flights %>%
  transmute(gain = dep_delay - arr_delay,
            hours = air_time / 60,
            gain_per_hour = gain / hours)


## ---------------------------------------------------------------------------------------------------------------
flights %>%
  group_by(year, month, day) %>%
  summarise(delay = mean(dep_delay, na.rm = TRUE))


## ---------------------------------------------------------------------------------------------------------------
flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE))


## ----p12, fig.show = 'hide'-------------------------------------------------------------------------------------
flights %>% 
  group_by(dest) %>% 
  summarise(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)) %>%
  filter(count > 20, dest != "HNL") %>%
  ggplot(aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)


## ----ref.label = 'p12', echo = FALSE, message=FALSE, warning=FALSE----------------------------------------------


## ---------------------------------------------------------------------------------------------------------------
anes2016a <- read_csv(here::here("data/anes_timeseries_2016.csv"))
anes2016a


## ---------------------------------------------------------------------------------------------------------------
library(haven)
anes2016b <- read_dta(here::here("data/anes_timeseries_2016.dta"))
anes2016b


## ---------------------------------------------------------------------------------------------------------------
library(rio)
anes2016c <- import(here::here("data/anes_timeseries_2016.dta"))
identical(anes2016b, anes2016c)


## ---------------------------------------------------------------------------------------------------------------
tibble(anes2016c)


## ---------------------------------------------------------------------------------------------------------------
table1


## ---------------------------------------------------------------------------------------------------------------
table2


## ---------------------------------------------------------------------------------------------------------------
table2


## ---------------------------------------------------------------------------------------------------------------
table2 %>%
  pivot_wider(names_from = "type", 
              values_from = "count")


## ---------------------------------------------------------------------------------------------------------------
table1


## ---------------------------------------------------------------------------------------------------------------
table1 %>%
  pivot_longer(-country:-year, 
               names_to = "type", 
               values_to = "count")

