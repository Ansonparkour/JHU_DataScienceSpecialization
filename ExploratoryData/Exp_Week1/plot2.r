#Loading data
if (getwd() ==  "/Users/Sean/Desktop"){
    setwd( "/Users/Sean/")
}
source("/Users/Sean/desktop/load_data.R")
filename <- "household_power_consumption.txt"

plot2 <- function(data=NULL) {
    if(is.null(data))
        data <- load_data(filename)
    png("plot2.png", width=480, height=480)
    plot(data$Time, data$Global_active_power,
         type="l",
         xlab="",
         ylab="Global Active Power (kilowatts)")
    
    dev.off()
}