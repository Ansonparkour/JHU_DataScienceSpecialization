############################
#JHU DataSciuence 
#Exploring data Week4
#Assignment
############################
##question1: 
#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

#get the data 
getwd()
setwd("/Users/Sean/Desktop/exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#divide NEI data to subset data by year, then sum the NEI$Emission
emission_change <- aggregate(Emissions ~ year,NEI, sum)

png("plot1.png", width=480, height=480)

#use barplot
barplot(
    (emission_change$Emissions),
    names.arg=emission_change$year,
    xlab="Year",
    ylab="PM2.5 Emissions",
    main="Total PM2.5 Emissions vs Years"
)
dev.off()



