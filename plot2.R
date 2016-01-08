###############################################################################
#
# Exploratory Data Analysis - Course Project 1
# Guido Valenzano
#
# plot2.R 
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
png("plot2.png", width=480, height=480)

plot(powerTime, 
     powerSet$Global_active_power, 
     xlab="", 
     ylab="Global Active Power (kilowatts)", 
     type="l")

dev.off()
