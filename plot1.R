#
# This script creates a histogram of the Global Active Power (household global minute-averaged active power in kilowatts)
# for the dates 2007-02-01 and 2007-02-02.
#

# file with the data to be plotted
datafile <- "household_power_consumption.txt"

# does the file exists?
if (!file.exists(datafile))
    stop("missing data file")

# read file into the data data.frame (only read columns that are required for plot 1)
data <- read.table(datafile, header=TRUE, sep=";", na.strings="?", colClasses=c("character","NULL","numeric",rep("NULL",6)))

# convert Date to Date class in R
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# open graphic device
png("plot1.png")
# plot the histogram
with(data, 
     hist(Global_active_power[Date=="2007-02-01" | Date=="2007-02-02"], col="red",
          main="Global Active Power", xlab="Global Active Power (kilowatts)"))
# close graphic device
dev.off()