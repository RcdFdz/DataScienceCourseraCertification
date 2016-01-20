# Check if the work directory exist and the data is already unziped
existRawDataDir = file.exists("./raw_data")
existRawDataFile = file.exists("./raw_data/UCI HAR Dataset/")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# If the working directory doesn't exist is created
if(!existRawDataDir){
  dir.create("./raw_data")
} 

# If the file doesn't exist is downloaded and unziped
if(!existRawDataFile){
  download.file(fileUrl,destfile="./raw_data/RawData.zip",method="curl")
  unzip(zipfile="./raw_data/RawData.zip", exdir = "raw_data")
} 

# Read training data
testDataSubject <- read.table("./raw_data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, nrows = 2947)
testDataActivity <- read.table("./raw_data/UCI HAR Dataset/test/Y_test.txt", header = FALSE, nrows = 2947)
testDataFeatures  <- read.table("./raw_data/UCI HAR Dataset/test/X_test.txt", header = FALSE, nrows = 2947)

# Read train data
trainDataSubject <- read.table("./raw_data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, nrows = 7352)
trainDataActivity <- read.table("./raw_data/UCI HAR Dataset/train/Y_train.txt", header = FALSE, nrows = 7352)
trainDataFeatures <- read.table("./raw_data/UCI HAR Dataset/train/X_train.txt", header = FALSE, nrows = 7352)

# Merge by row, train and test data considering each context subjects, features and activities
subjects <- rbind(trainDataSubject, testDataSubject)
activities<- rbind(trainDataActivity, testDataActivity)
features<- rbind(trainDataFeatures, testDataFeatures)

# Read features Names from the features.txt
featuresNames <- read.table("./raw_data/UCI HAR Dataset/features.txt", head = FALSE, colClasses = c("NULL", "character") )

# Naming features, activities and subjects
colnames(features) <- t(featuresNames)
colnames(subjects) <- "Subject"
colnames(activities) <- "Activity"

# Merge all data into only table
mergedData <- cbind(subjects, activities, features)

# Select the Subject, Activity, means and std from the full data
columnsMeanSTD <- grep(".*subject.*|.*activity.*|.*mean.*|.*std.*", names(mergedData), ignore.case = TRUE)
dataMeansSTD <- mergedData[columnsMeanSTD]

# Read Activities Labels from activity_labels.txt
activityLabels <- read.table("./raw_data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Naming the activities, maping from 1,2,3,4,5,6 to real names obtained in the previous step
for(i in 1:6){
  dataMeansSTD$Activity[dataMeansSTD$Activity == i] <- as.character(activityLabels[i,2])
}

# Re-naming the features column for an easier understanding
# Matrix old - new 
subs <- matrix(c("^t","^f","Acc","Gyro","Mag","BodyBody","tBody","-mean()","-std()","-freq()","angle","gravity",
                 "Time","Frequency","Accelerometer","Gyroscope","Magnitude","Body","TimeBody","Mean","STD","Frequency","Angle","Gravity"), ncol = 2 )

# Dinamyc changing subs[i,1] is the regex to search and subs[i,2] the new word
for(i in 1:nrow(subs)){
  names(dataMeansSTD)<-gsub(subs[i,1], subs[i,2], names(dataMeansSTD))
}

# Load plyr library
library(plyr);

# Create a data set with average activity and subject. Ordering by Subject and Activity
tidyData <- aggregate(. ~Subject + Activity, dataMeansSTD, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]

# Writing the tidy_data
write.table(tidyData, file = "tidy_data.txt", row.name=FALSE)
