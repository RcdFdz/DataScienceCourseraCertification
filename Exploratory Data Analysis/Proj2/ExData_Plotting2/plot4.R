# Import ggplot2 library
library(ggplot2)
# data_loader.R allow us to import the data
source("data_loader.R")

# Read data and convert to data.table
if(!exists("dataSCC")) dataSCC <- data_loader("Source_Classification_Code.rds")
if(!exists("dataNEI")) dataNEI <- data_loader("summarySCC_PM25.rds")

### Exercice Title:
## Across the United States, how have emissions from coal combustion-related
## sources changed from 1999–2008?

# Subset by searching for coal and comb in Short Name column
isCoalCombustion <- grepl(".*(coal.*comb|comb.*coal).*", dataSCC$Short.Name, ignore.case=TRUE)

# Obtaining SCC code from dataSCC and search for the code in dataNEI
dataCoalCombSCC <- dataSCC[isCoalCombustion,]$SCC
dataCoalCombNEI <- dataNEI[dataNEI$SCC %in% dataCoalCombSCC,]

# Summrize years
totals <- dataCoalCombNEI %>%
  group_by(year) %>%
  summarize(total = sum(Emissions))

# define the png file
png("plot4.png", width=604, height=604)

# Define barplot, adjust Emissions to 10^5 Tons define labels colors and width, 
# grid type and scales and labels
ggp <- ggplot(data=totals,aes(x = factor(year), y = total/10^5, label = total, fill = factor(year))) + 
  geom_bar(binwidth = 0.5, stat="identity") +  
  theme() +
  geom_text(aes(factor(year), 0.5, label = round(total/10^5,2), fill = NULL), data = totals) +
  guides(fill=FALSE) +
  labs(x = "year", y = expression("PM2.5 Total Emission (10^5 T)")) + 
  labs(title=expression("PM2.5 Total emissions from coal combustion related US 1999-2008")) 

print(ggp)

# swich off the dev
dev.off()
