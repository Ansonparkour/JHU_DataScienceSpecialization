############################
#JHU DataSciuence 
#Exploring data Week4
#Assignment
############################
##question2: 
#Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (𝚏𝚒𝚙𝚜 == "𝟸𝟺𝟻𝟷𝟶") from 1999 
#to 2008? Use the base plotting system to make a plot answering this question.

getwd()
setwd("/Users/Sean/Desktop/exdata-data-NEI_data")
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#subset the dataset and divide to the different  group
sub_Baltimore  <-  subset(NEI, fips == "24510") 
Baltimore_change <- aggregate(Emissions ~ year, sub_Baltimore, sum)

png("plot2.png", width=480, height=480)

#use barplot
barplot(
    (Baltimore_change$Emissions),
    names.arg=Baltimore_change$year,
    xlab="Year",
    ylab="PM2.5 Emissions",
    main="Total PM2.5 Emissions @Baltimore vs Years"
)
dev.off()
