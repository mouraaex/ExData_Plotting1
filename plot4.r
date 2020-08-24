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

#Join columns date and time and create new colum data.hora to plot it in the graphic
data.hora = strptime(paste(df.plot$Date, df.plot$Time), "%Y-%m-%d %H:%M:%S")
df.plot = cbind(data.hora, df.plot)

#Open png file
png("Coursera/plot4.png", width = 480, height = 480)

#Prepare to plot 4 graphics
par(mfrow=c(2,2))

#Plot 1st one
plot (df.plot$data.hora, df.plot$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")

#Plot 2nd one
plot (df.plot$data.hora, df.plot$Voltage, type = "l", xlab = "", ylab = "Voltage")

#Plot the 3rd one
plot (df.plot$data.hora, df.plot$Sub_metering_1, type = "l", xlab = "", ylab = "Energy metering", col = "black")
lines (df.plot$data.hora, df.plot$Sub_metering_2, type = "l", col = "red")
lines (df.plot$data.hora, df.plot$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty = "n")

#plot the 4th one
plot (df.plot$data.hora, df.plot$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

#Close png file
dev.off()
