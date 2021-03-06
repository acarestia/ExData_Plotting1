#plot 4
#downloading and unzipping the file 
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "household_power_consumption.zip")
unzip("household_power_consumption.zip")
data <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", dec = ".")

#subsetting data from 2007-02-01 to 2007-02-02
subsetData <- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

#creating a day colum 
dateTime <- strptime(paste(subsetData$Date, subsetData$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
subsetData <- cbind(dateTime, subsetData)

#plotting 
par(mfrow = c(2,2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(subsetData, {
  plot(Global_active_power ~ dateTime, type="l", xlab="", ylab="Global Active Power")
  plot(Voltage ~ dateTime, type = "l", ylab = "Voltage")
  plot(Sub_metering_1~dateTime, type="l", ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
  legend("topright", col = c("black", "red", "blue"), lwd = c(1, 1, 1),
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power ~ dateTime, type = "l", ylab = "Global_reactive_power")
})

#saving as png
dev.copy(png, "plot4.png", width = 480, height = 480)
dev.off()
