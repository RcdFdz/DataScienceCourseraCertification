# Import ggplot2 library
library(ggplot2)
# data_loader.R allow us to import the data
source("data_loader.R")

# Read data and convert to data.table
if(!exists("dataSCC")) dataSCC <- data_loader("Source_Classification_Code.rds")
if(!exists("dataNEI")) dataNEI <- data_loader("summarySCC_PM25.rds")

### Exercice Title:
## How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

# Subset by searching for vehicles in SCC Level Two column
isVehicle <- grepl(".*vehicle.*",dataSCC$SCC.Level.Two, ignore.case=TRUE)

# Obtaining SCC code from dataSCC and search for the code in dataNEI
dataVehicleSCC <- dataSCC[isVehicle,]$SCC
dataVehicleNEI <- dataNEI[dataNEI$SCC %in% dataVehicleSCC,]

# Subset data from dataVehicleNEI for Baltimore  
dataBaltimore <- dataVehicleNEI[dataVehicleNEI$fips=="24510",]

# Summrize years
totals <- dataBaltimore %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# define the png file
png("plot5.png", width=604, height=604)

# Define barplot, ajusted the emisions to Tons added color and labels
ggp <- ggplot(data=totals,aes(x = factor(year), y = total, label = total, fill = factor(year))) + 
  geom_bar(binwidth = 0.5, stat="identity") +  
  theme() +
  geom_text(aes(factor(year), 30, label = round(total,2), fill = NULL), data = totals) +
  guides(fill=FALSE) +
  labs(x = "year", y = expression("PM2.5 Total Emission (T)")) + 
  labs(title=expression("PM2.5 Total emissions from motor vehicle sources Baltimore 1999-2008")) 

print(ggp)

# swich off the dev
dev.off()
