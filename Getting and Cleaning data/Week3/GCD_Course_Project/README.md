Getting and Cleaning Data Course Assignment
-------------------------------------------

##Goal

The purpose of this project is to demonstrate the ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. 
Aviable in this repor: 
    
1. A tidy data set as described below, 
2. A link to a Github repository with a script for performing the analysis, and 
3. A code book that describes the variables, the data, and any transformations or work made to performe clean up the data. 
4. Ascripts explaining how all of the scripts work and how they are connected.


In this repository:

- `run_analysis.R` : R code script used for obtain the cleaned *tidy_data.txt* file.

- `tidy_data.txt` : the cleaned data load, extracted and transformed from the original dataset.

- `CodeBook.md` : explanatory file referenced to the output dataset.

- `README.md` : the analysis of the code used to extract and transform the dats `run_analysis.R`

###Assumptions
The *run_analysis.R* script proceeds under the assumption that the source dataset hosted at [cloudfront](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) is aviable, it can be downloaded manually or by using the script. 

Note: The zip file is not provided in this repository so if it cannot be downloaded can not be used.

###Requirements

The libraries used in this operation are:

```{r, message=FALSE}
library(data.table)
library(dplyr)
```

## Code review
The foloowing lines are dedicated to explain the script `run_analysis.R` step by step.

###Pre-processing data
We check the file status, saveing in variables `existRawDataDir` and `existRawDataFile` if the *work directory* and the necessary data files are already downloaded and unziped. 

Also the URL is saved in `fileURL` for a future use.

```
existRawDataDir = file.exists("./raw_data")
existRawDataFile = file.exists("./raw_data/UCI HAR Dataset/")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
```

If the working directory `raw_data` doesn't exist is created.
```
if(!existRawDataDir){
  dir.create("./raw_data")
} 
```

As was mentioned before, if the file `RawData.zip` doesn't exist is downloaded and unziped from the provided url in *fileURL*.
```
if(!existRawDataFile){
  download.file(fileUrl,destfile="./raw_data/RawData.zip",method="curl")
  unzip(zipfile="./raw_data/RawData.zip", exdir = "raw_data")
} 
```
###Loading test and training datasets 
Reading test data from *subject_test.txt*, *Y_test.txt* and *X_test.txt*; and stored in `testDataSubject`, `testDataActivity` and `testDataFeatures`.

```
testDataSubject <- read.table("./raw_data/UCI HAR Dataset/test/subject_test.txt", header = FALSE, nrows = 2947)
testDataActivity <- read.table("./raw_data/UCI HAR Dataset/test/Y_test.txt", header = FALSE, nrows = 2947)
testDataFeatures  <- read.table("./raw_data/UCI HAR Dataset/test/X_test.txt", header = FALSE, nrows = 2947)
```

Reading test data from *subject_train.txt*, *Y_train.txt* and *X_train.txt*; and stored in `trainDataSubject`, `trainDataActivity` and `trainDataFeatures`.
```
trainDataSubject <- read.table("./raw_data/UCI HAR Dataset/train/subject_train.txt", header = FALSE, nrows = 7352)
trainDataActivity <- read.table("./raw_data/UCI HAR Dataset/train/Y_train.txt", header = FALSE, nrows = 7352)
trainDataFeatures <- read.table("./raw_data/UCI HAR Dataset/train/X_train.txt", header = FALSE, nrows = 7352)
```
###Merging the test and training sets to create one dataset
The data is merged by row using `rbind` method. Each data is merged considering each context subjects, activities and features.
```
subjects <- rbind(trainDataSubject, testDataSubject)
activities<- rbind(trainDataActivity, testDataActivity)
features<- rbind(trainDataFeatures, testDataFeatures)
```

Read the features names from the `features.txt` file and stored in `featuresNames`.
```
featuresNames <- read.table("./raw_data/UCI HAR Dataset/features.txt", head = FALSE, colClasses = c("NULL", "character") )
```

Naming features, activities and subjects in the dataset.
```
colnames(features) <- t(featuresNames)
colnames(subjects) <- "Subject"
colnames(activities) <- "Activity"
```
Merge all data into `mergedData`.
```
mergedData <- cbind(subjects, activities, features)
```
###Extracts the mean and standard deviation for each measurements
Extract the means and standard deviation from the full data by using `grep` method. The matching values ara stored in `columnsMeanSTD` variable.
```
columnsMeanSTD <- grep(".*subject.*|.*activity.*|.*mean.*|.*std.*", names(mergedData), ignore.case = TRUE)
```
Selecting all maches from `dataMeansSTD`.
```
dataMeansSTD <- mergedData[columnsMeanSTD]
```
###Uses of descriptive activity names in the activities column
Read activities labels from *activity_labels.txt*.
```
activityLabels <- read.table("./raw_data/UCI HAR Dataset/activity_labels.txt", header = FALSE)
```

Naming the activities, maping from *1,2,3,4,5,6* to real names obtained in the previous step.
```
for(i in 1:6){
  dataMeansSTD$Activity[dataMeansSTD$Activity == i] <- as.character(activityLabels[i,2])
}
```
###Appropriately labels the dataset with descriptive variable names
Re-naming the features column for an easier understanding. In order to acomplish this point, has been used a matrix *regex search - new name substitution*:

Original Regex      | Replaced
:--------------------|:--------------
`Acc`              | `Accelerometer`
`Gyro`           | `Gyroscope`
`Mag`          | `Magnitude`
`BodyBody`         | `Body`
`tBody`          | `TimeBody`
`-mean()`        | `Mean`
`-std()`       | `STD`
`-freq()`        | `Frequency`
`angle`        | `Angle`
`gravity`        | `Gravity`
`^t`           | `Time`
`^f`             | `Frequency`
Bellow the code:

```
subs <- matrix(c("^t","^f","Acc","Gyro","Mag","BodyBody","tBody","-mean()","-std()","-freq()","angle","gravity",                "Time","Frequency","Accelerometer","Gyroscope","Magnitude","Body","TimeBody","Mean","STD","Frequency","Angle","Gravity"), ncol = 2 )
```
Dinamyc changing `subs[i,1]` is the regex to search and `subs[i,2]` the new word using `names` function and `gsub` method.
```
for(i in 1:nrow(subs)){
  names(dataMeansSTD)<-gsub(subs[i,1], subs[i,2], names(dataMeansSTD))
}
```
###New independent tidy data set with the average of each variable for each activity and each subject
Load the *plyr* library 
Load plyr library.
```
library(plyr)
```
Create a data set with average activity and subject. Ordering by Subject and Activity

```
tidyData <- aggregate(. ~Subject + Activity, dataMeansSTD, mean)
tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
```
Writing the `tidy_data.txt` file using `write.table`

```
write.table(tidyData, file = "tidy_data.txt", row.name=FALSE)
```