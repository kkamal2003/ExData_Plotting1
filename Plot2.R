# Load the required packages
library(dplyr)

# Get data
dat <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings=c("?", ""))

# Create truncated dataset by subsetting specified dates
data <- dat %>% filter(Date %in% c("1/2/2007", "2/2/2007"))

# Remove dat from the environment to free up RAM
rm(dat)

# Convert date and time to proper formats
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$timetemp <- paste(data$Date, data$Time)
data$Time <- as.POSIXct(data$timetemp, format="%Y-%m-%d %H:%M:%S")

# Create a line plot across time of global active power
png(file="plot2.png", width=480, height=480)
plot(data$Time, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()
