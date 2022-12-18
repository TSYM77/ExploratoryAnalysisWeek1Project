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
#convert global active power column to numeric
Project1Data$Global_active_power <- as.numeric(as.character(Project1Data$Global_active_power))
#export png
png(file="plot2.png", width = 480, height = 480)
plot2 <- with(Project1Data, plot(Project1Data$date_time, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
dev.off()