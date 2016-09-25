library(dplyr)

data <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, sep = ";",
                   header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
twoday <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]
twoday <- select(twoday, Date, Time, Sub_metering_1, Sub_metering_2, Sub_metering_3)
twoday$newdate <- strptime(paste(twoday$Date, twoday$Time), format = "%Y-%m-%d %H:%M:%S")
class(twoday$Sub_metering_1) <- "numeric"
class(twoday$Sub_metering_2) <- "numeric"
class(twoday$Sub_metering_3) <- "numeric"
par(bg = "white")
plot(twoday$newdate, twoday$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
points(twoday$newdate, twoday$Sub_metering_2, type = "l", col = "red")
points(twoday$newdate, twoday$Sub_metering_3, type = "l", col = "blue")
points(twoday$newdate, twoday$Sub_metering_1, type = "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, col=c("black", "red", "blue"))
dev.copy(png, filename = "plot3.png")
dev.off()
