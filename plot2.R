#
# This script creates a plot of the Global Active Power (in kilowatts) over time
# for the dates 2007-02-01 and 2007-02-02.
#

# file with the data to be plotted
datafile <- "household_power_consumption.txt"

# does the file exists?
if (!file.exists(datafile))
    stop("missing data file")

# read file into the data data.frame (only read columns that are required for plot 2)
data <- read.table(datafile, header=TRUE, sep=";", na.strings="?", colClasses=c("character","character","numeric",rep("NULL",6)))

# convert Date and Time into Date-Time class in R
data$Time <- strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

# time period for the analysis
begin <- as.POSIXct("2007-02-01 00:00:00")
end <- as.POSIXct("2007-02-02 23:59:59")

# select rows that are in the correct time frame
select <- (data$Time >= begin & data$Time <= end)

# open graphic device
png("plot2.png")
# plot
with(data, 
     plot(Time[select], Global_active_power[select], type="l",
          main="", xlab="", ylab="Global Active Power (kilowatts)"))
# close graphic device
dev.off()