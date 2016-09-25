library(dplyr)

data <- read.table("household_power_consumption.txt", stringsAsFactors = FALSE, sep = ";",
                   header = TRUE)
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
twoday <- data[(data$Date == "2007-02-01" | data$Date == "2007-02-02"),]
twoday <- select(twoday, Date, Global_active_power)
class(twoday$Global_active_power) <- "numeric"
hist(twoday$Global_active_power, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
     main = "Global Active Power", col = "red")
dev.copy(png, filename = "plot1.png")
dev.off()
