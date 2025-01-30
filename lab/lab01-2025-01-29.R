# ========================================================================= #
# R Session 1: Introduction to base R & RStudio
# Author: Patrick
# Date: 22/01/2025
# ========================================================================= #

ls()
rm(list = ls())

# Basic arithmetic operations ---------------------------------------------

3 + 3 # R works just like a calculator R
sqrt(8)


# Objects in R ------------------------------------------------------------

x = 5
(y <- 3 + 3)
z <- x * y
z

Y <- "5"
try(Y/3)

class(y)
class(Y)

as.numeric(Y)/3


## Vectors ----

x <- c(1, 2, 5)
x <- c(1, 2, y)
x <- c(1, 2, as.numeric(Y))

cntry <- c("FRA", "USA", "NED")

y <- 1:10

y * 2
a <- y * x

## We can select (sets of) elements from vectors

a[6]
a[5:8]
a[-5]

a[a < 5 | a >= 40 | a == 7]

x
names(x)
names(x) <- cntry
x

x["USA"]


### Exercise 1 ###

# Every time a section begins with "### Exercise 1 ###"
# there is a small problem that you should solve

# Generate three objects:
# a) a should contain the number pi (try out command pi)
# b) b should contain the numbers 1 to 10
# c) c should contain the multiplication of 1*pi, 2*pi, ..., 10*pi

a <- pi
b <- 1:10
c <- a*b


## Matrices ----

m1 <- rbind(x, c(23, 45, 67))
m1

m1 <- rbind(1:3, c(23, 45, 67))
m1

m2 <- cbind(x, 5:7)
m2

### Exercise 2 ### 

# combine pi and the vector b in a matrix called m2 (column wise)
# calculate pi * b and add it to your matrix as an additional column
# Note: try to solve this task by only creating one object (m2).
# Call the result of 4*pi from the matrix

m2 <- cbind(pi, b)
m2 <- cbind(m2, pi*b)

m2[1 , 1]
m2[3 , 2]
m2[m2[, 3] > 15, ]

x[c(FALSE, TRUE, TRUE)]

selection <- m2[, 3] > 15
m2[selection, ]

rm(m2)


## Data frames ----

df <- data.frame(x = 1:3, 
                 y = 10:12, 
                 cntry)

1:10
seq(from = 10, to = 100, by = 5)

df[1, 3]
df[ , 3]
df[1,  ]
df[ , "y"]

df$y
df$cntry[1:2]


### Exercise 3 ###

# Select observations from df
# a) where y is greater than 10
# b) where x is odd and y is smaller than 12

df[df$y > 10, ]

obs.a <- df$y > 10
df[obs.a, ]

selection1 <- df$x %% 2 != 0
selection2 <- df$y < 12

df[df$x %% 2 != 0 & df$y < 12, ]
df[selection1 & selection2, ]


## Lists ----

list1 <- list(x, y, cntry, df)
list1

list1[[4]]
list1[[1]][2:3]

names(list1)
names(list1) <- c("X", "Y", "Country", "Data")

list1$Data
list1$X

reg <- lm(y ~ x, data = df)
reg

ls(reg)

reg$residuals
reg$coefficients
reg$model


## Functions ----

# myfunction <- function(input1, input2, ..., inputN){
#   
#   ## Define / compute output based on the inputs
#   
#   return(output)
#   
# }

my_summary <- function(x){
  if(class(x) == "character"){
    stop("This function only works for numeric vectors")
  }
  
  s_out <- sum(x)
  l_out <- length(x)
  m_out <- s_out / l_out
  out <- c(sum = s_out, 
           length = l_out, 
           mean = m_out)
  return(out)
}

my_summary(1:100)
my_summary(c("a", "b", "c"))


## Loops

x <- 0
for(i in 1:10){
  x <- x + i
  print(x)
  cat(paste0("x = ", x, "\n"))
}


## if else conditions

x <- 0
for(i in 1:10){
  if(x %% 2 == 0){
    x <- x + i
  } else if(x %% 2 == 1){
    x <- x - i
  } else {
    x <- x * i
  }
  cat(paste0("x = ", x, "\n"))
}

x <- 1:10
ifelse(x %% 2 == 0, x, -x)



# Working with data frames ------------------------------------------------



## Summarizing data ----



## Missing values ----



## Recoding data ----


### Exercise 4 ###

# a) recode the 'survived' variable in the titanic dataset
#    to a new numeric dummy, where 1 indicates survivors and 0 non-survivors
# b) recode the 'class' variable in the titanic dataset
#    to a new dichotomous factor variable indicating "passenger" and "crew"
# c) generate a variable in students indicating the number of different 
#    softwares each of you have learned previously



## Exporting datasets ----



# Basic Plotting Functions ------------------------------------------------



## Scatterplot ----



## Bar Plot ----



## Histogram ----



## Density plots ----



## Exporting figures ----



# Packages & Getting Help -------------------------------------------------



## Example: Creating crosstabs with percentages ----







