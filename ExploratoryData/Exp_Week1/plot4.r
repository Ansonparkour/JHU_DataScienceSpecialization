#Loading data
if (getwd() ==  "/Users/Sean/Desktop"){
    setwd( "/Users/Sean/")
}
source("/Users/Sean/desktop/load_data.R")
filename <- "household_power_consumption.txt"

plot4 <- function(data=NULL) {
    if(is.null(data))
        data <- load_data(filename)
    #open device
    png("plot4.png", width=480, height=480)
    #layout for four plot
    par(mfrow=c(2,2))
    #topleft plot
    plot(data$Time, data$Global_active_power, 
         type="l", xlab="", ylab="Global Active Power")
    #topright plot
    plot(data$Time, data$Voltage, 
         type="l", xlab="datetime", ylab="Voltage")
    #bottomleft plot
    plot(data$Time, data$Sub_metering_1, 
         type="l", col="black", xlab="", ylab="Energy sub metering")
    lines(data$Time, data$Sub_metering_2, col="red")
    lines(data$Time, data$Sub_metering_3, col="blue")
    legend("topright", col=c("black", "red", "blue"), 
           c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, box.lwd=0)
    #bottomtight plot
    plot(data$Time, data$Global_reactive_power, type="n",
         xlab="datetime", ylab="Global_reactive_power")
    lines(data$Time, data$Global_reactive_power)
    #device close
    dev.off()
    
}