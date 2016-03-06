## Getting full dataset
epc_full <- read.csv("household_power_consumption.txt", header = T, sep = ';', 
                     na.strings = "?", nrows = 2075259, check.names = F, 
                     stringsAsFactors = F, comment.char = "", quote = '\"')
epc_full$Date <- as.Date(epc_full$Date, format = "%d/%m/%Y")

## Subsetting the data
epc <- subset(epc_full, subset = (Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(epc_full)

## Converting dates
datetime <- paste(as.Date(epc$Date), epc$Time)
epc$Datetime <- as.POSIXct(datetime)
## Generating Plot 3
png(filename="plot3.png", width=480, height=480)
with(epc, {
    plot(Sub_metering_1 ~ Datetime, type = "l", 
         ylab = "Global Active Power (kilowatts)", xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
