# data_loader.R allow us to import the data
source("data_loader.R")

# Verify if dataNEI exist if not import it usin data_loader from data_loader.R
if(!exists("dataNEI")) dataNEI <- data_loader("summarySCC_PM25.rds")

### Exercice Title:
## Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
## Using the base plotting system, make a plot showing the total PM2.5 emission from 
## all sources for each of the years 1999, 2002, 2005, and 2008.

# Agregate values by Year
yearEmissions <- aggregate(Emissions ~ year,dataNEI, sum)


# define the png file
png("plot1.png", width=604, height=604)

# Define barplot, added color and labels, adjunst Emissions value
bp <- barplot(yearEmissions$Emission/10^6,
        names.arg=yearEmissions$year,
        col = 'lightblue',
        xlab="Year",
        ylab="Emissions (10^6 T)",
        main="PM2.5 Total Emissions - US Sources")

# Add total label Emissions in 10^6 Tones for each bar
text(bp, 0, round(yearEmissions$Emissions/10^6, 2),pos=3)

# swich off the dev
dev.off()
