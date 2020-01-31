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

## Plot Data

png("plot1.png")
with(housePwrConsum, hist(Global_active_power, main = "Global Active Power", col = 'red', xlab ="Global Active Power (kilowatts)"))
dev.off()