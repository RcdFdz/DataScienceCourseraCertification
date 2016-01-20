rankall <- function(outcome, num = "best") {
  ## Read outcome data
  outcomeData <- read.csv("outcome-of-care-measures.csv", colClasses = 'character')
  if (!outcome %in% c("heart attack","heart failure","pneumonia"))  stop ("invalid outcome")
  ## Check that state and outcome are valid
  ## Return hospital name in that state with lowest 30-day death
  aux <- outcomeData[,c(2,7,11,17,23)]
  names(aux)[3:5] <- c("heart attack","heart failure","pneumonia")
  
  stateUniq <- unique(outcomeData$State)
  m <- data.frame("","")
  names(m) <- c('Hospital.Name', 'State')
  
  for(i in 1:length(stateUniq)){
    auxiliar <- subset(aux, State == stateUniq[i])
    auxiliar[,outcome] <- suppressWarnings(as.double(auxiliar[,outcome]))
    auxiliar <- auxiliar[order(auxiliar[,outcome],auxiliar$Hospital.Name, decreasing = FALSE, na.last = TRUE),]
    if (num == "best") num = 1
    else if (num == "worst") num = length(auxiliar[,outcome]) - sum(is.na(auxiliar[outcome]))
    names(m)
    names(auxiliar[,1:2])
    m <- rbind(m,auxiliar[num,1:2])
  }
  m
}
