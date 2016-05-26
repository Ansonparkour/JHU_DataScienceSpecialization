#Loading data
if (getwd() ==  "/Users/Sean/Desktop"){
    setwd( "/Users/Sean/")
}
source("/Users/Sean/desktop/load_data.R")
filename <- "household_power_consumption.txt"

plot3 <- function(data=NULL) {
    if(is.null(data))
        data <- load_data(filename)
    png("plot3.png", width=480, height=480)
    #plot first line
    plot(data$Time, data$Sub_metering_1, type="l", col="black",
         xlab="", ylab="Energy sub metering")
    #add more line to the plot
    lines(data$Time, data$Sub_metering_2, col="red")
    lines(data$Time, data$Sub_metering_3, col="blue")
    legend("topright",
           col=c("black", "red", "blue"),
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           lty=1)
    
    dev.off()
}