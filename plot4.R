library(dplyr)

data <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, sep = ";",
                   header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
twoday <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]
twoday <- select(twoday, Date, Time, Global_active_power, Sub_metering_1, Sub_metering_2, 
                 Sub_metering_3, Voltage, Global_reactive_power)
twoday$datetime <- strptime(paste(twoday$Date, twoday$Time), format = "%Y-%m-%d %H:%M:%S")
class(twoday$Sub_metering_1) <- "numeric"
class(twoday$Sub_metering_2) <- "numeric"
class(twoday$Sub_metering_3) <- "numeric"
class(twoday$Global_active_power) <- "numeric"
class(twoday$Global_reactive_power) <- "numeric"
class(twoday$Voltage) <- "numeric"
par(mfrow = c(2,2), bg = "white")
plot(twoday$datetime, twoday$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")
with(twoday, plot(datetime, Voltage, type = "l"))
plot(twoday$datetime, twoday$Sub_metering_1, ylab = "Energy sub metering", xlab = "", type = "n")
points(twoday$datetime, twoday$Sub_metering_2, type = "l", col = "red")
points(twoday$datetime, twoday$Sub_metering_3, type = "l", col = "blue")
points(twoday$datetime, twoday$Sub_metering_1, type = "l")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, bty = "n",col=c("black", "red", "blue"))
with(twoday, plot(datetime, Global_reactive_power, type = "l"))
dev.copy(png, filename = "plot4.png")
dev.off()
