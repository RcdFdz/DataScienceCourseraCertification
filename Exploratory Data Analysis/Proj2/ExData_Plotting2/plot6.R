# Import ggplot2 library
library(ggplot2)
# data_loader.R allow us to import the data
source("data_loader.R")

# Read data and convert to data.table
if(!exists("dataSCC")) dataSCC <- data_loader("Source_Classification_Code.rds")
if(!exists("dataNEI")) dataNEI <- data_loader("summarySCC_PM25.rds")

### Exercice Title:
## Compare emissions from motor vehicle sources in Baltimore City with emissions 
## from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

# Subset by searching for vehicles in SCC Level Two column
isVehicle <- grepl(".*vehicle.*",dataSCC$SCC.Level.Two, ignore.case=TRUE)

# Obtaining SCC code from dataSCC and search for the code in dataNEI
dataVehicleSCC <- dataSCC[isVehicle,]$SCC
dataVehicleNEI <- dataNEI[dataNEI$SCC %in% dataVehicleSCC,]

# Subset data from dataVehicleNEI for Baltimore and add column City
dataBaltimore <- dataVehicleNEI[dataVehicleNEI$fips=="24510",]
dataBaltimore$city <- "Baltimore City"

# Subset data from dataVehicleNEI for Los Angeles and add column City
dataLosAngeles <- dataVehicleNEI[dataVehicleNEI$fips=="06037",]
dataLosAngeles$city <- "Los Angeles County"

# Merge Baltimor and Los Angeles
dataBalLA <- rbind(dataBaltimore,dataLosAngeles)

# Define barplot, ajusted the emisions to Tons added color and labels
# define the png file
png("plot6.png", width=604, height=604)

ggp <- ggplot(dataBalLA,aes(x = factor(year) , y = Emissions)) +
  geom_bar(stat="identity",aes(fill = factor(year)), width = 0.7) +
  facet_grid(.~city, scales = "fixed") + guides(fill=FALSE) +
  labs(x = "year", y = expression("PM2.5 Total Emission (T)")) + 
  labs(title=expression("PM2.5 Total motor vehicle sources Baltimore - LA (1999-2008)"))

print(ggp)
# swich off the dev
dev.off()
