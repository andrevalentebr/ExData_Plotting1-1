###############################################################################
#
# Exploratory Data Analysis - Course Project 1
# Guido Valenzano
#
# plot1.R 
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
rm(allData)

# Plot
#------------------------------------------------------------------------------
png("plot1.png", width=480, height=480)

hist(powerSet$Global_active_power,
     col="red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")

dev.off()
