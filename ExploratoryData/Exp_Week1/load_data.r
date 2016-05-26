#load_data function 
getwd()
setwd("./desktop/")

load_data <- function(filename){
    data <- read.table(filename,
                       header=TRUE,
                       sep=";",
                       colClasses=c("character", "character", rep("numeric",7)),
                       na="?")
    
    # convert date and time variables to Date/Time class
    data$Time =strptime(paste(data$Date, data$Time,collapes="",sep = ""),"%d/%m/%Y%H:%M:%S")
    #convert data to "%Y-%m-%d" formate
    data$Date <- as.Date(data$Date, "%d/%m/%Y")
    # extract data: 2007-02-01 and 2007-02-02
    sub_dates <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
    sub_data <- subset(data, Date %in% sub_dates)
    return (sub_data)
}


