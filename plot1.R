fh <- file("household_power_consumption.txt")
# Read the file to read into household_epc
household_epc <- read.table(text = grep("^[1,2]/2/2007", readLines(fh), value = TRUE), col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), sep = ";", header = TRUE)
# convert the Date and Time variables to Date/Time classes
household_epc$Date <- as.Date(household_epc$Date, format="%d/%m/%y")
household_epc$Time <- strptime(household_epc$Time, format="%H:%M:%S")

# Generating Plot 1
png(filename="plot1.png", width=480, height=480)
hist(household_epc$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")
dev.off()
close(fh)