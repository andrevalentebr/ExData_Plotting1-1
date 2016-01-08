###############################################################################
#
# Exploratory Data Analysis - Course Project 1
# Guido Valenzano
#
# plot4.R 
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
png("plot4.png", width=480, height=480)
par(mfcol = c(2,2))

# 1
#------------------------------------------------------------------------------
plot(powerTime, 
     powerSet$Global_active_power, 
     xlab="",
     ylab="Global Active Power",
     type="l")

# 2
#------------------------------------------------------------------------------
plot(powerTime,
     powerSet$Sub_metering_1, 
     xlab="",
     ylab="Energy sub metering", 
     col="black",
     type="l")

lines(powerTime, powerSet$Sub_metering_2, col="red")
lines(powerTime, powerSet$Sub_metering_3, col="blue")

legend("topright", 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lwd=1,
       bty="n")

# 3
#------------------------------------------------------------------------------
plot(powerTime,
     powerSet$Voltage,
     type="l",
     xlab="datetime",
     ylab="Voltage")

# 4
#------------------------------------------------------------------------------
plot(powerTime, 
     powerSet$Global_reactive_power,
     type="l", 
     xlab="datetime", 
     ylab="Global_reactive_power")

dev.off()

