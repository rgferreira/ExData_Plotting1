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

plot_3 <- function() {
        plot(dataSet$DateTime,dataSet$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
        lines(dataSet$DateTime,dataSet$Sub_metering_2,col="red")
        lines(dataSet$DateTime,dataSet$Sub_metering_3,col="blue")
        legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1), cex=.6,pt.cex=3, inset=c(0.33,0), box.col = 0)
        dev.copy(png, file="plot3.png", width=480, height=480)
        dev.off()
}
plot_3()