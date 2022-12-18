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
Project1Data$Sub_metering_1<- as.numeric(as.character(Project1Data$Sub_metering_1))
Project1Data$Sub_metering_2<- as.numeric(as.character(Project1Data$Sub_metering_2))
Project1Data$Sub_metering_3<- as.numeric(as.character(Project1Data$Sub_metering_3))
#export png
png(file="plot3.png", width = 480, height = 480)
plot3 <- plot(Project1Data$date_time, Project1Data$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
lines(Project1Data$date_time, Project1Data$Sub_metering_2, type="l", col = "red")
lines(Project1Data$date_time, Project1Data$Sub_metering_3, type="l", col = "blue")
legend("topright",
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),
       lty = 1)
dev.off()

            