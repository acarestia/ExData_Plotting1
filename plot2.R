#Plot 2
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
with(subsetData, plot(Global_active_power ~ dateTime, type="l", xlab = " ", ylab="Global Active Power (kilowatts)"))

#save as png
dev.copy(png, "plot2.png", width = 480, height = 480)
dev.off()
