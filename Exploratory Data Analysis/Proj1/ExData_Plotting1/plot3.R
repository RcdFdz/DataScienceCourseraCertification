Sys.setlocale("LC_ALL", "C")
## Data loader allows you to clean the data.
source("data_loader.R")

## Please remember to pass the path directory with the file in case 
## this is not in you working directory load_data()
if(!exists("data_table")) data_table <- data_loader()

# define the png file
png("plot3.png", width=504, height=504)

# contruct the plot, Date - G. Sub. Metering 1-3, type line without x label and with y label
# notices that metering 2-3 is added with line and colors red and blue
plot(data_table$Date, 
     data_table$Sub_metering_1, 
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering')
lines(data_table$Date, data_table$Sub_metering_2, type = 'l', col = 'red')
lines(data_table$Date, data_table$Sub_metering_3, type = 'l', col = 'blue')
# specified legend for the graph.
legend("topright",
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = 1)
  
# swich off the dev
dev.off()