############################
#JHU DataSciuence 
#Exploring data Week2 
#Quiz
############################

#Quesrtion2 
library(nlme)
library(lattice)
names(BodyWeight)
BodyWeight$Diet
xyplot(weight ~ Time | Diet, data = BodyWeight)

#Quesrtion4 
library(lattice)
library(datasets)
data(airquality)
p <- xyplot(Ozone ~ Wind | factor(Month), data = airquality)
#The object 'p' has not yet been printed with the appropriate print method
#so the plot will not be shown up 
print(p)

#Question5
#In the lattice system, which of the following functions can be 
#used to finely control the appearance of all lattice plots?
trellis.par.set()

#Question7
#examining how the relationship between ozone and wind speed varies across each month
library(datasets)
data(airquality)
airquality = transform(airquality, Month = factor(Month))
qplot(Wind, Ozone, data = airquality, facets = . ~ Month)


#Question9
library(ggplot2)
library(ggplot2movies)
#ggplot should know what type of layer to add to the plot, for example: geom_point()
g <- ggplot(movies, aes(votes, rating)) + geom_point()
print(g)





