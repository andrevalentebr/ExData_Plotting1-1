###############################################################################
#
# Exploratory Data Analysis - Course Project 1
# Guido Valenzano
#
# plot3.R 
#
###############################################################################

# Download data set
#------------------------------------------------------------------------------
fileName <- "household_power_consumption.zip"
if(!file.exists(fileName)) {
  url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(url, fileName, method="curl")
}


# Extract data set
#------------------------------------------------------------------------------
dataName <- "household_power_consumption.txt"
if(!file.exists(dataName)) {
  unzip(fileName)
}


# Load necessary libraries
#------------------------------------------------------------------------------
library(data.table)


# Get data into R
#------------------------------------------------------------------------------
allData <- fread(dataName,
                 header = TRUE,
                 sep = ";",
                 dec = ".",
                 na.strings = "?",
                 stringsAsFactors = FALSE,
                 showProgress = TRUE,
                 data.table = FALSE)

powerSet <- allData[allData$Date %in% c("1/2/2007", "2/2/2007"), ]
powerTime <- strptime(paste(powerSet$Date, powerSet$Time), "%d/%m/%Y %H:%M:%S")
rm(allData)


###############################################################################


# Plot
#------------------------------------------------------------------------------
png("plot3.png", width=480, height=480)

plot(powerTime, 
    powerSet$Sub_metering_1, 
    type="n", 
    ylab="Energy sub metering", 
    xlab="")

lines(powerTime, powerSet$Sub_metering_1, col="black")
lines(powerTime, powerSet$Sub_metering_2, col="red")
lines(powerTime, powerSet$Sub_metering_3, col="blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       col=c("black", "red", "blue"), lwd=1)

dev.off()
