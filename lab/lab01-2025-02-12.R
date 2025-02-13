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
try(my_summary(c("a", "b", "c")))


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


# working directories
getwd()
setwd("E:/BasicR/r-basics-main/data/")
getwd()
dir()

tmp <- "E:/BasicR/r-basics-main/lab"

setwd(tmp)
dir()

## remove objects in environment
rm(list = ls())

## load native R data
load("../data/titanic.Rdata")

## get an overview of the data
titanic
head(titanic)
class(titanic)
class(titanic$sex)
class(titanic$class)

## comma delimited data (.csv)
cars <- read.csv("../data/cars.csv", 
                 sep = "\t")
cars <- read.csv("../data/cars.csv")
head(cars)


## Summarizing data ----

colnames(titanic)
nrow(titanic)
ncol(titanic)
dim(titanic)
length(titanic$survived)
mean(titanic$survived, na.rm = TRUE)
median(titanic$survived, na.rm = TRUE)
table(titanic$sex)
mean(titanic$sex == "Male")

m1 <- lm(survived ~ sex, data = titanic)
summary(m1)

var(cars$speed)
sd(cars$speed)

table(titanic$sex,
      titanic$survived)

attach(titanic)
table(sex, survived)
detach(titanic)

View(titanic)
summary(titanic)
str(titanic)

class(titanic$survived)
mode(titanic$survived)

titanic2 <- read.csv("../data/titanic.csv")

table(titanic$survived,
      titanic$class)

prop.table(table(titanic$survived,
                 titanic$class))

prop.table(table(titanic$survived,
                 titanic$class), margin = 1)

prop.table(table(titanic$survived,
                 titanic$class), 2)

women <- subset(titanic, sex == "Female")
men <- subset(titanic, sex != "Female")

prop.table(table(women$survived,
                 women$class), 2)

prop.table(table(men$survived,
                 men$class), 2)


## Missing values ----

mean(titanic$survived)
mean(titanic$survived, na.rm = T)
table(titanic$survived)
table(titanic$survived, useNA = "always")

titanic_nomis <- na.omit(titanic)



## Recoding data ----

# Create new variables in a dataset
cars$ratio <- cars$speed / cars$dist
cars

# Recode categories
titanic$class_num <- NA
titanic$class_num[titanic$class == "3rd"] <- 0
titanic$class_num[titanic$class == "2nd"] <- 1
titanic$class_num[titanic$class == "1st"] <- 2

# Factors
class(titanic$class)
class(titanic$sex)
levels(titanic$class)
table(as.numeric(titanic$class))
table(as.numeric(titanic$sex))

titanic$sex_fct <- as.factor(titanic$sex)
table(titanic$sex_fct)

titanic$sex_fct <- factor(titanic$sex, 
                          levels = c("Male", "Female"))
table(titanic$sex_fct)

summary(m1)
m2 <- lm(survived ~ sex_fct, data = titanic)
summary(m2)


### Exercise 4 ###

# a) recode the 'survived' variable in the titanic dataset
#    to a new numeric dummy, where 1 indicates survivors and 0 non-survivors
# b) recode the 'class' variable in the titanic dataset
#    to a new dichotomous factor variable indicating "passenger" and "crew"

# a) 

titanic$survived_fct <- factor(titanic$survived,
                               labels = c("casualty",
                                          "survivor"))
table(titanic$survived_fct)
class(titanic$survived_fct)

# b) 

table(titanic$class)
titanic$passenger <- as.numeric(titanic$class != "Crew")
titanic$passenger <- as.numeric(
  titanic$class %in% c("1st", "2nd", "3rd")
)
table(titanic$passenger)


# Note two options to remove variables below:
colnames(titanic)
# titanic <- titanic[, colnames(titanic) != "passenger"]
# titanic <- subset(titanic, select = -passenger)


## Exporting datasets ----

## Save your entire environment as an RData file

save.image("../data/session04.Rdata")

## Save individual objects as and RData file

save(titanic, cars, file = "../data/session04.Rdata")

## Save one data frame as a csv file

write.csv(titanic, "../data/titanic_tmp.csv")



# Basic Plotting Functions ------------------------------------------------

head(cars)

## Scatterplot ----

plot(dist ~ speed, data = cars,
     xlab = "Speed in mph",
     ylab = "Breaking distance",
     main = "Car stopping distances")


## Bar Plot ----

table(titanic$class)
barplot(table(titanic$class),
        main = "Titanic Passengers and Crew",
        col = "blue")



## Histogram ----

hist(cars$speed,
     breaks = 10,
     col = "darkgreen",
     main = "Histogram of car speeds",
     xlab = "Mph")
abline(v = mean(cars$speed), col = "red")
abline(v = median(cars$speed), lty = "dashed")
legend("topright", 
       lty = c("solid", "dashed"),
       col = c("red", "black"),
       legend = c("Mean", "Median"))



## Density plots ----

plot(density(cars$dist))



## Exporting figures ----

pdf("../data/plot1.pdf", height = 4, width = 7)
hist(cars$speed,
     breaks = 10,
     col = "darkgreen",
     main = "Histogram of car speeds",
     xlab = "Mph")
abline(v = mean(cars$speed), col = "red")
abline(v = median(cars$speed), lty = "dashed")
legend("topright", 
       lty = c("solid", "dashed"),
       col = c("red", "black"),
       legend = c("Mean", "Median"))
dev.off()



# Packages & Getting Help -------------------------------------------------

# We can access help files directly in R
?lm
help(lm)
?plot
?plot.density

?summary
?summary.lm

# install.packages("haven")
library("haven")
titanic <- read_dta("../data/titanic.dta")

# side note: it's possible to use a command without loading a package
titanic <- haven::read_dta("../data/titanic.dta")

help(package = "haven")
apropos("read_")


## Example: Creating crosstabs with percentages ----

# install.packages("gmodels")
library(gmodels)

CrossTable(titanic$survived,
           titanic$class)
?CrossTable


