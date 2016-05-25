################
# Question 1:
################
getwd()
setwd('./desktop/')
if (!file.exists("data")) {
    dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
download.file(fileUrl, destfile = "./data/test.csv", method = "curl")
list.files()
#download time
dateDownloaded <- date()
#read csv file
test_data <- read.csv("./data/test.csv")
#find which column is about 'VAL'
names(test_data) 
#sum val>10,000,000
sum(!is.na(test_data[test_data$VAL >= 24, 37 ]))

################
# Question 3:
################
setwd('./desktop/')
if (!file.exists("data")) {
    dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FDATA.gov_NGAP.xlsx"
download.file(fileUrl, destfile = "./data/gov_NGAP.xlsx", method = "curl")
#need library to read xlsx file
library(xlsx)
dat <- read.xlsx("./data/gov_NGAP.xlsx",sheetIndex = 1,rowIndex = 18:23, colIndex = 7:15)
sum(dat$Zip*dat$Ext,na.rm=T)

################
# Question 4:
################
setwd("./desktop")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Frestaurants.xml"
download.file(fileUrl,destfile = "./data/restaurants.xml", method = "curl")
library(XML)
xml_data <- xmlTreeParse("./data/restaurants.xml", useInternal = TRUE)
rootNode <- xmlRoot(xml_data)
sum(xpathSApply(rootNode, "//zipcode", xmlValue) == "21231")


################
# Question 5:
################
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06pid.csv"
download.file(fileUrl,destfile = "./data/pid.csv", method = "curl" )
library(data.table)
#read file use data.table
DT <- fread("./data/pid.csv")












