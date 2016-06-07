############################
#JHU DataSciuence 
#Exploring data Week4
#Assignment
############################

#question4
#Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)
#get the data 
getwd()
setwd("/Users/Sean/Desktop/exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#subset coal combustion data
coal_related<- grepl("coal", SCC$Short.Name, ignore.case=TRUE)

sub_coal_related <- SCC[(coal_related == TRUE),]

# Merge two data sets
sub_data <- merge(x=NEI, y=sub_coal_related, by='SCC')

#divide merge data to different group 
coal_change <- aggregate(Emissions ~ year, sub_data, sum)

#plot the graph to easy look at 
png("plot4.png", width=480, height=480)

#pay attention to change year to factor 
#Manually specify group = 1 indicates you want a single line connecting all the points.
g <- ggplot(coal_change, aes(factor(year), Emissions,  group=1))
g + geom_line(colour = "red", size = 1) + geom_point() + 
    labs(x="year", y="Coal Emissions") + 
    labs(title="Emissions from 1999–2008 for Coal Combustion")

dev.off()




