Sys.setlocale("LC_ALL", "C")
## Data loader allows you to clean the data.
source("data_loader.R")

## Please remember to pass the path directory with the file in case 
## this is not in you working directory load_data()
if(!exists("data_table")) data_table <- data_loader()

# define the png file
png("plot4.png", width=504, height=504)

# define the canvas
par(mfrow=c(2,2))

# first plot G.Active Power / Date
plot(data_table$Date, 
     data_table$Global_active_power, 
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power')

# second plot Voltage / Date
plot(data_table$Date, 
     data_table$Voltage, 
     type = 'l',
     xlab = 'datetime',
     ylab = 'Voltage')

# third plot E. sub metering / Date
plot(data_table$Date, 
     data_table$Sub_metering_1, 
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering')
lines(data_table$Date, data_table$Sub_metering_2, type = 'l', col = 'red')
lines(data_table$Date, data_table$Sub_metering_3, type = 'l', col = 'blue')
legend("topright",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1,
       box.lwd = 0)

# fourth plot G.Reactive Power / Date
plot(data_table$Date, 
     data_table$Global_reactive_power, 
     type = 'l',
     xlab="datetime", 
     ylab="Global_reactive_power")

# swich off the dev
dev.off()