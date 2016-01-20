## Data Loader
data_loader <- function(filename_path="household_power_consumption.txt") {
  # Read the file from directory
  df <- read.table(filename_path,
                   header = TRUE,
                   sep = ";",
                   colClasses = c(rep("character",2), rep("numeric",7)),
                   na = "?")
  
  # Convert the first column to Date type so I can subset and extract the data 
  # avoiding to work with 2075259 elements
  df$Date <- as.Date(df$Date, "%d/%m/%Y")
  df <- subset(df, Date >= "2007-02-01" & Date <= "2007-02-02")
  
  # Join Date and Time columns and format them to timestamp format 
  df$Date <- paste(df$Date, df$Time)
  df$Date <- strptime(df$Date, "%Y-%m-%d %H:%M:%S")
  # Delete the Time column
  df <- df[,c(1,3:9)]
  
  return(df)
}