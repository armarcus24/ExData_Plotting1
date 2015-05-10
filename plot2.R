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
data$Date <- as.POSIXct(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")

# Creates plot; saves to png
png(filename = "plot2.png", width = 480, height = 480)
plot(data$Global_active_power ~ data$Date, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()