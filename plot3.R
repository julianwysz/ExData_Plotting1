library(data.table)

## Download Data

dataURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipFile <- "exdata_data_household_power_consumption.zip"
dataFile <- "household_power_consumption.txt"
if (!file.exists(zipFile)){
    download.file(dataURL, zipFile)}

if (!file.exists(dataFile)){
    unzip(zipFile)}


## read and format Data

housePwrConsum <- fread(dataFile, header=TRUE, na.strings = "?")

idxDates <- grepl("^1/2/2007|^2/2/2007", housePwrConsum$Date)
housePwrConsum <- housePwrConsum[idxDates,]

datesCol <- strptime(paste(housePwrConsum$Date, housePwrConsum$Time, sep= " "), format = "%d/%m/%Y %H:%M:%S")

housePwrConsum <- cbind(datesCol, housePwrConsum)

## Plot Data

png("plot3.png")

with(housePwrConsum, plot(Sub_metering_1 ~ datesCol, type= "n", xlab ="", ylab ="Energy sub metering"))
with(housePwrConsum, lines(Sub_metering_1 ~ datesCol, col= "black"))
with(housePwrConsum, lines(Sub_metering_2 ~ datesCol, col= "red"))
with(housePwrConsum, lines(Sub_metering_3 ~ datesCol, col= "blue"))
legend("topright", col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1)

dev.off()