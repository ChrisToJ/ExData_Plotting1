#
# This script creates a plot of Energy sub-metering over time
# for the dates 2007-02-01 and 2007-02-02.
#

# file with the data to be plotted
datafile <- "household_power_consumption.txt"

# does the file exists?
if (!file.exists(datafile))
    stop("missing data file")

# read file into the data data.frame
data <- read.table(datafile, header=TRUE, sep=";", na.strings="?", colClasses=c("character","character",rep("numeric",7)))

# convert Date and Time into Date-Time class in R
data$Time <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# time period for the analysis
begin <- as.POSIXct("2007-02-01 00:00:00")
end <- as.POSIXct("2007-02-02 23:59:59")

# select rows that are in the correct time frame
select <- (data$Time >= begin & data$Time <= end)

# open graphic device
png("plot4.png")
par(mfrow=c(2,2))
# plot
attach(data)
plot(Time[select], Global_active_power[select], type="l", main="", xlab="", ylab="Global Active Power")

plot(Time[select], Voltage[select], type="l", main="", xlab="daytime", ylab="Voltage")

plot(Time[select], Sub_metering_1[select], type="l", main="", xlab="", ylab="Energy sub metering")
lines(Time[select], Sub_metering_2[select], col="red")
lines(Time[select], Sub_metering_3[select], col="blue")
legend("topright", legend=colnames(data)[7:9], col=c("black","red","blue"), lwd=1, bty="n")

plot(Time[select], Global_reactive_power[select], type="l", main="", xlab="daytime", ylab="Global_reactive_power")
detach(data)
# close graphic device
dev.off()