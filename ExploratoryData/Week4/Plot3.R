############################
#JHU DataSciuence 
#Exploring data Week4
#Assignment
############################

##question3
#Of the four types of sources indicated by the 𝚝𝚢𝚙𝚎 (point, nonpoint, onroad, nonroad) variable, which of these 
#four sources have seen decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in 
#emissions from 1999–2008? Use the ggplot2 plotting system to make a plot answer this question.

library(ggplot2)
#get the data 
getwd()
setwd("/Users/Sean/Desktop/exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#subset the dataset and divide to the different  group
sub_Baltimore  <-  subset(NEI, fips == "24510") 

png("plot3.png", width=480, height=480)

#pay attention to change year to factor 
g <- ggplot(sub_Baltimore, aes(factor(year), Emissions))
g + geom_bar(stat="identity") + facet_grid(. ~ type) +
    labs(x="year", y="Emissions") + 
    labs(title="Emissions from 1999–2008 for Baltimore City")

dev.off()
