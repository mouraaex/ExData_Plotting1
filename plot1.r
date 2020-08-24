library(data.table)
library(tseries)
library(lubridate)

#Load data file as csv2
arq.elet = "Coursera/household_power_consumption.txt"
df = read.csv2(arq.elet, header = T, stringsAsFactors = F)

#Convert data type according variables descriptions
df$Date = as.Date(df$Date, "%d/%m/%Y")
df$Global_active_power = as.numeric(df$Global_active_power)
df$Global_reactive_power = as.numeric(df$Global_reactive_power)
df$Voltage = as.numeric(df$Voltage)
df$Global_intensity = as.numeric(df$Global_intensity)
df$Sub_metering_1 = as.numeric(df$Sub_metering_1)
df$Sub_metering_2 = as.numeric(df$Sub_metering_2)
df$Sub_metering_3 = as.numeric(df$Sub_metering_3)

#Subsetting data according date mentioned
df.plot = df[df$Date == as.Date("2007-02-01", "%Y-%m-%d") | df$Date == as.Date ("2007-02-02", "%Y-%m-%d"),]

#Open png file
png("Coursera/plot1.png", width = 480, height = 480)

#Create histogram as requested 
hist(df.plot$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = 'red')

#Close png file
dev.off()