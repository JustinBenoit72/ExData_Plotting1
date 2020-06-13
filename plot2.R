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
png(filename = "plot2.png", width = 480, height = 480)

#Add the plot to the current png graphics device
with(pow_data, plot(ymd(Date) + hms(Time), Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)"))
with(pow_data, lines(ymd(Date) + hms(Time), Global_active_power))

#Close the graphics device to save the file
dev.off()