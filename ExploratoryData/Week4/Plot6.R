############################
#JHU DataSciuence 
#Exploring data Week4
#Assignment
############################

#question6
#Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#California (𝚏𝚒𝚙𝚜 == "𝟶𝟼𝟶𝟹𝟽"). Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
#get the data 
getwd()
setwd("/Users/Sean/Desktop/exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds") 

#find vehicle 
motor_related<- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
length(which(motor_related == TRUE))

#subset for cities 
sub_Baltimore  <-  subset(NEI, fips == "24510")
sub_Losangeles <-  subset(NEI, fips == "06037")

#add city variable to subdata set, will use in the facet_grid plot
sub_Baltimore$city <-  "Baltimore"
sub_Losangeles$city <- "Losangeles"



# Merge two data sets, the althernative way
motor_related_SCC <- SCC[motor_related,]$SCC
sub_data_Baltimore <- sub_Baltimore[sub_Baltimore$SCC %in% motor_related_SCC,]
sub_data_Losangeles <- sub_Losangeles[sub_Losangeles$SCC %in% motor_related_SCC,]

#combine two subdata set
two_sub_data <-  rbind(sub_data_Baltimore,sub_data_Losangeles)

#divide to different group by year
motor_change_Baltimore <- aggregate(Emissions ~ year, sub_data_Baltimore, sum)
motor_change_Losangeles <- aggregate(Emissions ~ year, sub_data_Losangeles, sum)

#plot
png("plot6.png", width=480, height=480)

g <- ggplot(two_sub_data, aes(x=factor(year), y=Emissions)) +
    geom_bar(aes(fill=year),stat="identity") +
    facet_grid( .~city) +
    theme(legend.position='none')+
    labs(x="year", y="Vehicle Emissions") + 
    labs(title="Emissions from 1999–2008 for motor vehicle in Baltimore and Los Angeles")

print (g)
dev.off()
