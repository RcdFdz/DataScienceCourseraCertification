corr <- function(directory, threshold = 0) {
  filenames <- list.files(directory, pattern = "*.csv", full.names = TRUE)
  df <- do.call("rbind", lapply(filenames, read.csv, header = TRUE))
  c_result <- c()
  for (i in 0:max(df$ID)) {
    tmp <- subset(df, ID == i)
    num_complete_cases <- sum(complete.cases(tmp))
    if (num_complete_cases > threshold){
      correlation <- cor(tmp$sulfate , tmp$nitrate, use="complete.obs")
      c_result <- c(c_result, correlation)
    }
  }
  c_result
}
# cr <- corr("specdata", 150)
# head(cr)
# summary(cr)
# cr <- corr("specdata", 400)
# head(cr)
# summary(cr)
# cr <- corr("specdata", 5000)
# summary(cr)
# length(cr)
# cr <- corr("specdata")
# summary(cr)
# length(cr)

