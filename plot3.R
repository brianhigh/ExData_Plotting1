# plot3.R - Plot Energy Sub Metering line graph

# Store the name of the extracted raw data file for later use
rawfile <- "household_power_consumption.txt"

# Check the size of the raw data file in MB to estimate the memory consumed
# print(file.info(rawfile)$size / 1024^2)
## [1] 126.8013

# Import raw data file (127 MB) into a data frame (143 MB)
colclasses <- c("character", "character", "numeric", 
                "numeric", "numeric", "numeric", 
                "numeric", "numeric", "numeric")
consumptiondf <- read.table(rawfile, header = TRUE, sep = ";",
                            colClasses=colclasses, 
                            na.strings = "?",
                            stringsAsFactors = FALSE)

# Check the memory consumption of the data frame in MB
# print(object.size(consumptiondf), units="MB")
## 142.7 Mb

# Add a (POSIX) datetime column parsed from Date and Time columns
consumptiondf$datetime <- strptime(paste(consumptiondf$Date, 
                                         consumptiondf$Time), 
                                   "%d/%m/%Y %H:%M:%S")

# Add a (Date) mydate column parsed from Date columns
consumptiondf$mydate <- as.Date(consumptiondf$Date, format="%d/%m/%Y")

# Filter data frame by only those two dates to be used for the plot
twodaydf <- consumptiondf[consumptiondf$mydate %in% as.Date(c('2007-02-01', 
                                                              '2007-02-02')),]

# Make the plot and save as a PNG image file
png("plot3.png", width = 480, height = 480)
plot(twodaydf$datetime, twodaydf$Sub_metering_1, xlab="", sub="", 
     ylab = "Energy sub metering", type = "l", col = "black")
lines(twodaydf$datetime, twodaydf$Sub_metering_2, col = "red")
lines(twodaydf$datetime, twodaydf$Sub_metering_3, col = "blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty=c(1,1), col=c("black", "blue","red"))
dev.off()