###########################
#Getting and Cleaning Data
#Week4 quiz
###########################


getwd()
setwd('./desktop/')

#question1 
#Apply strsplit() to split all the names of the data frame on the characters "wgtp".
#What is the value of the 123 element of the resulting list?

#load dataset
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./test.csv", method = "curl")
#read csv file
data <- read.csv("./test.csv")

name <- names(data) 
strsplit(name, "wgtp")[123]

#question2
#Remove the commas from the GDP numbers in millions of dollars and average them. What is the average?

#load and read the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
download.file(fileUrl,destfile = "./test2.csv", method = "curl")
data2 <- read.csv("./test2.csv", skip = 4, nrows = 215, stringsAsFactors = FALSE)

#remove the gdp value with "" and ".."
GDP = data$X.4[! data$X.4 == ""]
GDP = GDP[! GDP == ".."]

#remove commas from GDP
gdp <- as.numeric(gsub(",", "", GDP))

mean(gdp)

#question3 
#count the number of countries whose name begins with "United"?

summary(grepl("^United",data2$X.3))

#question4
#Match the data based on the country shortcode. 
#Of the countries for which the end of the fiscal year is available, how many end in June?

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
download.file(fileUrl,destfile = "./test3.csv", method = "curl")
data3 <- read.csv("./test3.csv", stringsAsFactors = FALSE)

data2$X 
data3$CountryCode
#rename first column name of data2
colnames(data2)[1] <- "CountryCode"
#merge by countrycode
data_mergred <- merge(data2, data3, all = TRUE, by = c("CountryCode"))
#find "fiscal year end"
fiscal_year_end <- data_mergred[grep("fiscal year end", tolower(data_mergred$Special.Notes)),]
#find "june
end_june <- grepl("june", tolower(fiscal_year_end$Special.Notes))

summary(end_june)

###alternative way
fiscal_year_end <- grepl("fiscal year end", tolower(data_mergred$Special.Notes))
end_june <- grepl("june", tolower(data_mergred$Special.Notes))
#this is a good practice to using table()
table(fiscal_year_end,end_june)
#print the result
data_mergred$Special.Notes[fiscal_year_end & end_june]


#question5
#How many values were collected in 2012? 
#How many values were collected on Mondays in 2012?

library(quantmod)
amzn = getSymbols("AMZN",auto.assign=FALSE)
sampleTimes = index(amzn)

library(lubridate)
year2012 <- subset(sampleTimes, year(sampleTimes) == 2012)
length(year2012) == 250
year2012monday <- subset(year2012, weekdays(year2012) == 'Monday')
length(year2012monday) == 47



