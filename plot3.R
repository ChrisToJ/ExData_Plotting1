#
# This script creates a plot of Energy sub-metering over time
# for the dates 2007-02-01 and 2007-02-02.
#

# file with the data to be plotted
datafile <- "household_power_consumption.txt"

# does the file exists?
if (!file.exists(datafile))
    stop("missing data file")

# read file into the data data.frame (only read columns that are required for plot 3)
data <- read.table(datafile, header=TRUE, sep=";", na.strings="?", colClasses=c("character","character",rep("NULL",4),rep("numeric",3)))

# convert Date and Time into Date-Time class in R
data$Time <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# time period for the analysis
begin <- as.POSIXct("2007-02-01 00:00:00")
end <- as.POSIXct("2007-02-02 23:59:59")

# select rows that are in the correct time frame
select <- (data$Time >= begin & data$Time <= end)

# open graphic device
png("plot3.png")
# plot
attach(data)
plot(Time[select], Sub_metering_1[select], type="l", main="", xlab="", ylab="Energy sub metering")
lines(Time[select], Sub_metering_2[select], col="red")
lines(Time[select], Sub_metering_3[select], col="blue")
legend("topright", legend=colnames(data)[3:5], col=c("black","red","blue"), lwd=1)
detach(data)
# close graphic device
dev.off()