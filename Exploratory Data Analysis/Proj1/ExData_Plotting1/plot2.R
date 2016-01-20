Sys.setlocale("LC_ALL", "C")
## Data loader allows you to clean the data.
source("data_loader.R")

## Please remember to pass the path directory with the file in case 
## this is not in you working directory load_data()
if(!exists("data_table")) data_table <- data_loader()

# define the png file
png("plot2.png", width=504, height=504)

# contruct the plot, Date - G. Active Power, type line without x label and y with label
plot(data_table$Date, 
     data_table$Global_active_power, 
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')

# swich off the dev
dev.off()