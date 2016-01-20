# data_loader.R allow us to import the data
source("data_loader.R")

# Verify if dataNEI exist if not import it usin data_loader from data_loader.R
if(!exists("dataNEI")) dataNEI <- data_loader("summarySCC_PM25.rds")

### Exercice Title:
## Have total emissions from PM2.5 decreased in the Baltimore City, 
## Maryland (fips == "24510") from 1999 to 2008? 
##
## Use the base plotting system to make a plot answering this question. 

# Subset data from dataNEI for Baltimore  
dataBaltimore <- dataNEI[dataNEI$fips=="24510",]

# Agregate values by Year
baltimoreYearEmissions <- aggregate(Emissions ~ year, dataBaltimore,sum)

# define the png file
png("plot2.png", width=604, height=604)

# Define barplot, added color and labels
bp <- barplot(baltimoreYearEmissions$Emission,
              names.arg=baltimoreYearEmissions$year,
              col = 'lightblue',
              xlab="Year",
              ylab="Emissions (T)",
              main="PM2.5 Total Emissions - Baltimore")

# Add total label Emissions in Tones for each bar
text(bp, 0, round(baltimoreYearEmissions$Emissions,0),pos=3)

# swich off the dev
dev.off()
