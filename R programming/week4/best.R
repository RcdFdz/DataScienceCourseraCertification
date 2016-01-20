best <- function(state, outcome) {
  ## Read outcome data
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = 'character')
  if (!outcome %in% c("heart attack","heart failure","pneumonia"))  stop ("invalid outcome")
  if (!state %in% outcomeData$State)  stop ("invalid state")
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  ##columnsMeanSTD <- grep("Hospital.Name|state|^hospital.*mortality.*rate.*heart|^hospital.*mortality.*rate.*pneumonia", names(outcomeData), ignore.case = TRUE)
  ##aux = outcomeData[,columnsMeanSTD]
  aux <- outcomeData[,c(2,7,11+0,17+0,23+0)]
  names(aux)[3:5] <- c("heart attack","heart failure","pneumonia")
  aux <- subset(aux, State == state)
  aux[,outcome] <- suppressWarnings(as.double(aux[,outcome]))
  aux <- aux[order(aux[,outcome],aux$Hospital.Name, decreasing = FALSE, na.last = TRUE),]
  aux[1,1]
  ## rate
}