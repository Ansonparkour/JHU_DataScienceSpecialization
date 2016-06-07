############################
#JHU DataSciuence 
#Exploring data Week4
#Assignment
############################

#question5
#How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)
#get the data 
getwd()
setwd("/Users/Sean/Desktop/exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#find vehicle 
motor_related<- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
length(which(motor_related == TRUE))

#subset for Baltimore 
sub_Baltimore  <-  subset(NEI, fips == "24510") 

# Merge two data sets, the althernative way
motor_related_SCC <- SCC[motor_related,]$SCC
sub_data <- sub_Baltimore[sub_Baltimore$SCC %in% motor_related_SCC,]

#divide to different group by year
motor_change <- aggregate(Emissions ~ year, sub_data, sum)

#plot
png("plot5.png", width=480, height=480)

g <- ggplot(motor_change, aes(factor(year), Emissions,  group=1))

#geom_text add the digital lable, and hjust/vjust adjust the position of digital number 
#theme(legend.position='none') make sure no additional legend
g + geom_line(colour = "red", size = 1) + geom_point() + 
    geom_text(aes(label=round(Emissions,digits=1), size=1, hjust=1.5, vjust=1.5)) +
    theme(legend.position='none') +
    labs(x="year", y="Vehicle Emissions") + 
    labs(title="Emissions from 1999–2008 for motor vehicle")

dev.off()


