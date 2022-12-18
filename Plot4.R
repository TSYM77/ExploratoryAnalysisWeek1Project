library(tidyverse)
library(lubridate)
#pull data from directory
Project1Data <- read.table("household_power_consumption.txt",
                           sep=";",header=TRUE)
#use lubridate to format date and time
Project1Data$Date <- dmy(Project1Data$Date)
#filter for data between 2007-02-01 and 2007-02-02
Project1Data <- Project1Data[Project1Data$Date >= "2007-02-01" & Project1Data$Date <= "2007-02-02", ]
#remove any NA data
Project1Data <- na.omit(Project1Data)
#combine date time columns into one
Project1Data$date_time = ymd_hms(paste(Project1Data$Date, Project1Data$Time))
#convert global columns to numeric
Project1Data$Global_active_power <- as.numeric(as.character(Project1Data$Global_active_power))
Project1Data$Voltage<- as.numeric(as.character(Project1Data$Voltage))
Project1Data$Global_reactive_power<- as.numeric(as.character(Project1Data$Global_reactive_power))
Project1Data$Sub_metering_1<- as.numeric(as.character(Project1Data$Sub_metering_1))
Project1Data$Sub_metering_2<- as.numeric(as.character(Project1Data$Sub_metering_2))
Project1Data$Sub_metering_3<- as.numeric(as.character(Project1Data$Sub_metering_3))
#export png
png(file="plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plotA <- with(Project1Data, plot(Project1Data$date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power"))
plotB <- with(Project1Data, plot(Project1Data$date_time, Project1Data$Voltage, type="l", xlab="datetime", ylab="Voltage"))
PlotC <- plot(Project1Data$date_time, Project1Data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(Project1Data$date_time, Project1Data$Sub_metering_2, type="l", col = "red")
lines(Project1Data$date_time, Project1Data$Sub_metering_3, type="l", col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       cex=0.7,
       lty = 1)
plotD <- with(Project1Data, plot(Project1Data$date_time, Project1Data$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power"))
dev.off()
