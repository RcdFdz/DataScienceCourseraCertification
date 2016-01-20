pollutantmean <- function(directory, pollutant, id = 1:332) {
  
  filenames <- list.files(directory, pattern = "*.csv", full.names = TRUE)
  df <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  
  data <- data.frame()
  
  for (i in id) {
    data <- rbind(data, subset(df, ID == i, select = pollutant))
  }
  
  mean(data[,pollutant], na.rm = TRUE)
}
# pollutantmean("specdata", "sulfate", 1:10)
# pollutantmean("specdata", "nitrate", 70:72)
# pollutantmean("specdata", "nitrate", 23)