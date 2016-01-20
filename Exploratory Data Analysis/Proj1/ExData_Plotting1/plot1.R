Sys.setlocale("LC_ALL", "C")
## Data loader allows you to clean the data.
source("data_loader.R")

## Please remember to pass the path directory with the file in case 
## this is not in you working directory load_data()
if(!exists("data_table")) data_table <- data_loader()

# define the png file
png("plot1.png", width=504, height=504)

# contruct the histogram G.Active Power, red color, title and x labels
hist(data_table$Global_active_power, 
     col = 'red', 
     main = 'Global Active Power', 
     xlab = 'Global Active Power (kilowatts)')

# swich off the dev
dev.off()
