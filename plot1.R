# Reads entire file into R
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE)

# Converts Date column into Date class
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

# Creates vector of dates in given date range; converts these dates to Date class; subsets data to rows
# only in date range
dates <- c("2007-02-01", "2007-02-02")
dates <- as.Date(dates, format="%Y-%m-%d")
data <- subset(data, data$Date %in% as.Date(dates, "%Y/%m/%d"))

# Converts column to numeric class for plotting
data$Global_active_power <- as.numeric(data$Global_active_power)

# Saves plot to png
png(filename = "plot1.png", width = 480, height = 480)
hist(data[,3], col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()