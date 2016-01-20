library(data.table)

## Data Loader
data_loader <- function(filename_path) {
  # Read the file from directory
  data <- data.table(readRDS(filename_path))
  return(data)
}