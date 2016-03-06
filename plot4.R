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

## Generating Plot 4
png(filename="plot4.png", width=480, height=480)
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(epc, {
    plot(Global_active_power ~ Datetime, type = "l", 
         ylab = "Global Active Power", xlab = "")
    plot(Voltage ~ Datetime, type = "l", ylab = "Voltage", xlab = "datetime")
    plot(Sub_metering_1 ~ Datetime, type = "l", ylab = "Energy sub metering",
         xlab = "")
    lines(Sub_metering_2 ~ Datetime, col = 'Red')
    lines(Sub_metering_3 ~ Datetime, col = 'Blue')
    legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
           bty = "n",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ Datetime, type = "l", 
         ylab = "Global_rective_power", xlab = "datetime")
})

dev.off()