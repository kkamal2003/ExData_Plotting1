# Load the required packages
library(dplyr)

# Get data from the specified URL and unzip it to the current working directory
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "household_power_consumption.zip")
unzip("household_power_consumption.zip")

# Read the data file with proper separator and NA strings
dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("?", ""), stringsAsFactors = FALSE)

# Create truncated dataset by subsetting specified dates
data <- dat %>% filter(Date == "1/2/2007" | Date == "2/2/2007")

# Remove dat from the environment to free up RAM
rm(dat)

# Convert date and time to proper formats
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$timetemp <- paste(data$Date, data$Time)
data$Time <- as.POSIXct(data$timetemp, format="%Y-%m-%d %H:%M:%S")

# Create a histogram of global active power
# Create a PNG plotting device
png(file = "plot1.png", width = 480, height = 480)

# Create the histogram plot
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")

# Close the PNG device
dev.off()

