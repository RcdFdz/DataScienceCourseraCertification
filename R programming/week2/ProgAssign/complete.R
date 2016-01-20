complete <- function(directory, id = 1:332) {
  
  filenames <- list.files(directory, pattern = "*.csv", full.names = TRUE)
  df <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  data <- data.frame()
  dat <- data.frame()
  
  for (i in id) {
    tmp <- subset(df, ID == i)
    dat <- rbind(dat,data.frame("id" = i, "nobs" = sum(complete.cases(tmp))))
  }
  dat
}
# complete("specdata", 1)
# complete("specdata", 3)
