library(ggplot2)
library(data.table)
# Read data and convert to data.table
data_NEI <- data.table(readRDS("summarySCC_PM25.rds"))
data_SCC <- data.table(readRDS("Source_Classification_Code.rds"))

## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 

## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

# Agregate values by Year
yearEmissions <- aggregate(Emissions ~ year,data_NEI, sum)
# Define barplot, ajusted the emisions to Tons added color and labels
# define the png file
png("plot1.png", width=504, height=504)
bp <- barplot(yearEmissions$Emission/10^6,
        names.arg=yearEmissions$year,
        col = 'lightblue',
        xlab="Year",
        ylab="Emissions (10^6 T)",
        main="PM2.5 Total Emissions - US Sources")
# Add total label Emissions in Tones for each bar
text(bp, 0, round(yearEmissions$Emissions/10^6, 2),pos=3)
# swich off the dev
dev.off()
## As is shown in the graphic the emiisions has decreased from 7.33T to 3.46T