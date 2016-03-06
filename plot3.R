## Download the file from the url and unzip it
datSetFileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(datSetFileUrl,"Dataset.zip")
unzip("Dataset.zip")
message("Dataset download and extraction - DONE.")

message("Loading package: sqldf")
library(sqldf)

message("Loading package: datasets")
library(datasets)

message("Reading data from file . . .")
dataFileName <- "household_power_consumption.txt"
dataFile <- file(dataFileName)
query <- "select * from dataFile where Date in ('1/2/2007','2/2/2007')"
powerData <- sqldf(query, file.format= list(header=TRUE, sep=";"))
close(dataFile)

message("Generating png PLOT . . .")
png(filename = "plot3.png",width = 480, height = 480, units = "px")
xaxisData <- strptime(paste(powerData$Date, powerData$Time, sep=" "), "%d/%m/%Y %H:%M:%S") 
plot(xaxisData, powerData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(xaxisData,powerData$Sub_metering_2, col="orange", type="l")
lines(xaxisData,powerData$Sub_metering_3, col="blue", type="l")
legend("topright",c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty=1,col=c("black", "orange","blue"))
dev.off()
message("DONE - Please refer to plot3.png.")