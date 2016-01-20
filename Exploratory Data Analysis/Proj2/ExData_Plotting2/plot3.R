# Import ggplot2 library
library(ggplot2)
# data_loader.R allow us to import the data
source("data_loader.R")

# Verify if dataNEI exist if not import it usin data_loader from data_loader.R
if(!exists("dataNEI")) dataNEI <- data_loader("summarySCC_PM25.rds")

### Exercice Title:
## Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
## variable, which of these four sources have seen decreases in emissions from 1999–2008 
## for Baltimore City? Which have seen increases in emissions from 1999–2008? 
##
## Use the ggplot2 plotting system to make a plot answer this question.

# Subset data from dataNEI for Baltimore  
dataBaltimore <- dataNEI[dataNEI$fips=="24510",]

# define the png file
png("plot3.png", width=604, height=604)

# Define barplot, define labels colors and width, grid type and scales and labels, removed 
# legend title
ggp <- ggplot(dataBaltimore,aes(x = factor(year) , y = Emissions)) +
  geom_bar(stat="identity",aes(fill = factor(year)), width = 0.7) +
  facet_grid(.~type, scales = "fixed") + 
  guides(fill=guide_legend(title=NULL)) +
  labs(x = "year", y = expression("PM2.5 Total Emission (T)")) + 
  labs(title=expression("PM2.5 Total Emissions Baltimore 1999-2008 "))

print(ggp)

# swich off the dev
dev.off()
