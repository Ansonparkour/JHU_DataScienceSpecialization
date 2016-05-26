##Loading data
#due to in 'load_data' function, we change directory to desktop,
#so here cannot be desktop as directory
if (getwd() ==  "/Users/Sean/Desktop"){
    setwd( "/Users/Sean/")
}
source("/Users/Sean/desktop/load_data.R")
filename <- "household_power_consumption.txt"
#plot1
plot1 <- function(data=NULL) {
    if(is.null(data))
        data <- load_data(filename)
    #open device
    png("plot1.png", width=480, height=480)
    
    hist(data$Global_active_power,
         main="Global Active Power",
         xlab="Global Active Power (kilowatts)",
         ylab="Frequency",
         col="red")
    
    dev.off()
}