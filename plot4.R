#Load essential packages
library(lubridate)

#Read in data set
total_pow_data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)

#Convert Date column to Date object for easy subsetting
total_pow_data[,1] <- as.Date(total_pow_data[,1], format = "%d/%m/%Y")

#Subset full data set to obtain only data from 2007-02-01 to 2007-02-02
pow_data <- subset(total_pow_data, Date >= "2007-02-01" & Date <= "2007-02-02")

#Convert numeric columns to numeric type
for (i in 3:9) {
    pow_data[,i] <- as.numeric(pow_data[,i])
}

#Open the png graphics device and initialize the file name and size
png(filename = "plot4.png", width = 480, height = 480)

#Setup the plots to display as a 2x2 matrix of plots
par(mfrow = c(2,2))

#Add the first plot
with(pow_data, plot(ymd(Date) + hms(Time), Global_active_power, type = "n", xlab = "", ylab = "Global Active Power"))
with(pow_data, lines(ymd(Date) + hms(Time), Global_active_power))

#Add the second plot
with(pow_data, plot(ymd(Date) + hms(Time), Voltage, type = "n", xlab = "datetime", ylab = "Voltage"))
with(pow_data, lines(ymd(Date) + hms(Time), Voltage))

#Add the third plot
with(pow_data, plot(ymd(Date) + hms(Time), Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering"))
with(pow_data, lines(ymd(Date) + hms(Time), Sub_metering_1, col = "black"))
with(pow_data, lines(ymd(Date) + hms(Time), Sub_metering_2, col = "red"))
with(pow_data, lines(ymd(Date) + hms(Time), Sub_metering_3, col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1, 1, 1), bty = "n")

with(pow_data, plot(ymd(Date) + hms(Time), Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power"))
with(pow_data, lines(ymd(Date) + hms(Time), Global_reactive_power))

#Close the graphics device to save the file
dev.off()