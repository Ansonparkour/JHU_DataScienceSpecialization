###########################
#JHU_Data Science with R
#Getting and Cleaning Data 
#Week3
###########################


###############
#question 1
##############
##read data first
getwd()
if (!file.exists("data")) {
    dir.create("data")
}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv"
filePath <- file.path(getwd(),"./data/test.csv")
download.file(fileUrl, destfile = filePath, method = "curl")
#read csv file
data <- read.csv(filePath)
#return the logical data 
agricultureLogical <- data$ACR == 3 & data$AGS == 6
which(agricultureLogical)[1:3]

#return the row data 
agriculture_1 <- data[(data$ACR ==3 & data$AGS ==6),]
#return the row data  and which can get out of NA automatically 
agriculture_2 <- data[which(agricultureLogical),]  

                           

###############
#question 2
##############
#Using the jpeg package read in the following picture
library(jpeg)
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg"
filePath <- file.path(getwd(), "jeff.jpg")
download.file(fileUrl, filePath, mode = "wb")
picture <- readJPEG(filePath, native = TRUE)
quantile(picture, probs = c(0.3, 0.8))



###############
#question 3
##############
#read product data 
fileUrl_GDP <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv"
filePath_GDP <- file.path(getwd(),"./data/GDP.csv")
download.file(fileUrl_Product, filePath_Product, method = 'curl')

#skip first 5 rows, only read 190 countries, header = F
GDP  <- read.csv(filePath_Product,skip = 5, nrows = (195-5), header = F)
#we only need 1,2,4,5 column data
GDP <- GDP[, c(1, 2, 4, 5)]
colnames(GDP) <- c("CountryCode","Rank","Long.Name","GDP" )

#read education data
fileUrl_Education <- "https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv"
filePath_Education <- file.path(getwd(),"./data/education.csv")
download.file(fileUrl_Education, filePath_Education )
#header = T, this is different with GDP data
education <- read.csv(filePath_Education)

#Match the data based on the country shortcode.
GDP_education <- merge(GDP, education, by.x = "CountryCode", by.y = "CountryCode")

#How many of the IDs match?
dim(GDP_education)
#Sort the data frame in descending order by GDP rank (so United States is last)
library(plyr)
#sort data use rank
arrange(GDP_education, desc(Rank))[13, 3]

###############
#question 4 
##############
#average GDP ranking for the "High income: OECD" and "High income: nonOECD" group?
mean(GDP_education[GDP_education$Income.Group == "High income: OECD",]$Rank)
mean(GDP_education[GDP_education$Income.Group == "High income: nonOECD",]$Rank)


###############
#question 5
##############
#Cut the GDP ranking into 5 separate quantile groups. Make a table versus Income.Group.
library(Hmisc)
#Cut Ranks into 5 groups 
GDP_education$Rank.Groups = cut2(GDP_education$Rank, g = 5)
##How many countries are Lower middle income but among the 38 nations with highest GDP?
table(GDP_education$Income.Group, GDP_education$Rank.Groups)


