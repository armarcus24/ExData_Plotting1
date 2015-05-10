# Reads entire file into R
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Converts Date column into Date class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Creates vector of dates in given date range; converts these dates to Date class; subsets data to rows
# only in date range
dates <- c("2007-02-01", "2007-02-02")
dates <- as.Date(dates, format="%Y-%m-%d")
data <- subset(data, data$Date %in% as.Date(dates, "%Y/%m/%d"))

# Converts column to numeric class for plotting; combines Date and Time columns into POSIXct class
data$Global_active_power <- as.numeric(data$Global_active_power)
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)
data$Voltage <- as.numeric(data$Voltage)
data$Global_reactive_power <- as.numeric(data$Global_reactive_power)
data$Date <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

png(filename = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))

#Creates plot 1
plot(data$Global_active_power ~ data$Date, type = "l", xlab = "", ylab = "Global Active Power")

#Creates plot 2
plot(data$Voltage ~ data$Date, type = "l", xlab = "datetime", ylab = "Voltage")

#Creates plot 3
plot(data$Sub_metering_1 ~ data$Date, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data$Sub_metering_2 ~ data$Date, type = "l", col = "red")
lines(data$Sub_metering_3 ~ data$Date, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd = 1, col = c("black", "red", "blue"), bty = "n")

#Creates plot 4
plot(data$Global_reactive_power ~ data$Date, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()