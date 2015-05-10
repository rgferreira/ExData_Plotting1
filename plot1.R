if(!file.exists("exdata-data-household_power_consumption.zip")) {
        temp <- tempfile()
        download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
        file <- unzip(temp)
        unlink(temp)
}
dataSet <-read.table(file, sep=";", header = TRUE)
dataSet$Date <- as.Date(dataSet$Date, format="%d/%m/%Y")
dataSet <- dataSet[(dataSet$Date=="2007-02-01") | (dataSet$Date=="2007-02-02"),]
dataSet$Global_active_power <- as.numeric(as.character(dataSet$Global_active_power))
dataSet$Sub_metering_1 <- as.numeric(as.character(dataSet$Sub_metering_1))
dataSet$Sub_metering_2 <- as.numeric(as.character(dataSet$Sub_metering_2))
dataSet$Sub_metering_3 <- as.numeric(as.character(dataSet$Sub_metering_3))
dataSet <- transform(dataSet, DateTime=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:$M:$S")

plot_1 <- function() {
        hist(dataSet$Global_active_power, main = paste("Global Active Power"), col="red", xlab="Global Active Power (kilowatts)")
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
}
plot_1()
