library(tidyverse)
library(lubridate)
#pull data from directory
Project1Data <- read.table("household_power_consumption.txt",
                           sep=";",header=TRUE)

#use lubridate to format date and time
Project1Data$Date <- dmy(Project1Data$Date)
Project1Data$Time <- hms(Project1Data$Time)
#remove any NA data
Data <- na.omit(Project1Data)
#filter for data between 2007-02-01 and 2007-02-02
Data2 <- Data[Data$Date >= "2007-02-01" & Data$Date <= "2007-02-02", ]
#check data head
head(Data2)
#change data type to numeric for all columns
Data3 <- Data2 %>% mutate_if(is.character,as.numeric)
#check class of data in global active power column
class(Data3$Global_active_power)
#set variable for global active power column
Global_Active_Power <- Data3$Global_active_power
#export image of histogram
png(file="plot1.png", width = 480, height = 480)
hist(Global_Active_Power, main = "Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()
