library(dplyr)

data <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, sep = ";",
                   header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
twoday <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]
twoday <- select(twoday, Date, Time, Global_active_power)
twoday$newdate <- strptime(paste(twoday$Date, twoday$Time), format = "%Y-%m-%d %H:%M:%S")
class(twoday$Global_active_power) <- "numeric"
plot(twoday$newdate, twoday$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")
dev.copy(png, filename = "plot2.png")
dev.off()
