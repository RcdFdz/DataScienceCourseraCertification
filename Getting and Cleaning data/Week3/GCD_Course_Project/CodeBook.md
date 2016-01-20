CodeBook
---------------------------------------------------------------
## Introduction

 1. Merges the training and the test sets to create one data set.
 2. Extracts only the measurements on the mean and standard deviation for each measurement.
 3. Uses descriptive activity names to name the activities in the data set
 4. Appropriately labels the data set with descriptive variable names.
 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Original Dataset

The data used for the development of this project has been obtained from "Human Activity Recognition Using Smartphones Data Set". The data has been collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site  to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained. [Original dataset description](http//archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) and [Original dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)


###Description of the Original files

* `README.txt`

* `features_info.txt`: Shows information about the variables used on the feature vector.

* `features.txt`: List of all features.

* `activity_labels.txt`: Links the class labels with their activity name.

* `train/X_train.txt`: Training set.

* `train/y_train.txt`: Training labels.

* `test/X_test.txt`: Test set.

* `test/y_test.txt`: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent.

* `train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.

* `train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in standard gravity units `g`. Every row shows a 128 element vector. The same description applies for the `total_acc_x_train.txt` and `total_acc_z_train.txt` files for the Y and Z axis.

* `train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from the total acceleration.

* `train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second.


## Labels transformation
For a better understanding of the data the original labels had been renamed as is shown bellow, manly has been added a Subject and Activity column name, these variables identify the unique subject/activity pair the variables; and has been renamed the Features columns by using `regex`.

###Column names

* `Subject` column: the integer subject ID

* `Activity` column: the string activity name:

  |Old|New                 |
  |:---|:------------------|
  |`1`|`WALKING`           |
  |`2`|`WALKING_UPSTAIRS`  |
  |`3`|`WALKING_DOWNSTAIRS`|
  |`4`|`SITTING`           |
  |`5`|`STANDING`          |
  |`6`|`LAYING`            |


* Features column: all features variables are the mean of a measurement for each subject and activity. This is indicated by the initial Mean in the variable name. All values are floating point numbers. Moreover, the name of the features column has been changed by using a `regex` for a better understanding by using the following roles:

   Original Regex      | Replaced
   --------------------|--------------
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

Example of the changes:

 Old      | New
 ------------|--------------
`tBodyAcc-mean()-X`          | `TimeBodyAccelerometerMean()-X`
`tBodyAcc-mean()-Y`          | `TimeBodyAccelerometerMean()-Y`
`tBodyAcc-mean()-Z`      | `TimeBodyAccelerometerMean()-Z`
`tBodyAcc-std()-X`       | `TimeBodyAccelerometerSTD()-X`
`tBodyAcc-std()-Y`         | `TimeBodyAccelerometerSTD()-Y`
`tBodyAcc-std()-Z`     | `TimeBodyAccelerometerSTD()-Z`


## Data values

### Measurement meaning

All variables are the mean of a measurement for each subject and activity and are floating point numbers.

From the original dataset:

>The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

>Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

>These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

>Note: features are normalized and bounded within [-1,1].

### Column meaning:
* Time domain body acceleration along X, Y, and Z axes
    * Mean
        - `TimeBodyAccelerometerMean()-X`
        - `TimeBodyAccelerometerMean()-Y`
        - `TimeBodyAccelerometerMean()-Z`
    * Standard deviation
        - `TimeBodyAccelerometerSTD()-X`
        - `TimeBodyAccelerometerSTD()-Y`
        - `TimeBodyAccelerometerSTD()-Z`
* Time domain gravity acceleration along X, Y, and Z axes
    * Mean
        - `TimeGravityAccelerometerMean()-X`
        - `TimeGravityAccelerometerMean()-Y`
        - `TimeGravityAccelerometerMean()-Z`
    * Standard deviation
        - `TimeGravityAccelerometerSTD()-X`
        - `TimeGravityAccelerometerSTD()-Y`
        - `TimeGravityAccelerometerSTD()-Z`
* Time domain body jerk along X, Y, and Z axes
    * Mean
        - `TimeBodyAccelerometerJerkMean()-X`
        - `TimeBodyAccelerometerJerkMean()-Y`
        - `TimeBodyAccelerometerJerkMean()-Z`
    * Standard deviation
        - `TimeBodyAccelerometerJerkSTD()-X`
        - `TimeBodyAccelerometerJerkSTD()-Y`
        - `TimeBodyAccelerometerJerkSTD()-Z`
* Time domain gyroscope along X, Y, and Z axes
    * Mean
        - `TimeBodyGyroscopeMean()-X`
        - `TimeBodyGyroscopeMean()-Y`
        - `TimeBodyGyroscopeMean()-Z`
    * Standard deviation
        - `TimeBodyGyroscopeSTD()-X`
        - `TimeBodyGyroscopeSTD()-Y`
        - `TimeBodyGyroscopeSTD()-Z`
* Time domain gyroscope jerk along X, Y, and Z axes
    * Mean
        - `TimeBodyGyroscopeJerkMean()-X`
        - `TimeBodyGyroscopeJerkMean()-Y`
        - `TimeBodyGyroscopeJerkMean()-Z`
    * Standard deviation
        - `TimeBodyGyroscopeJerkSTD()-X`
        - `TimeBodyGyroscopeJerkSTD()-Y`
        - `TimeBodyGyroscopeJerkSTD()-Z`
* Time domain body acceleration magnitude
    * Mean
        - `TimeBodyAccelerometerMagnitudeMean()`
   * Standard deviation
        - `TimeBodyAccelerometerMagnitudeSTD()`
* Time domain gravity acceleration magnitude
    * Mean
        - `TimeGravityAccelerometerMagnitudeMean()`
    * Standard deviation
        - `TimeGravityAccelerometerMagnitudeSTD()`
* Time domain body jerk acceleration magnitude
    * Mean
        - `TimeBodyAccelerometerJerkMagnitudeMean()`
    * Standard deviation
        - `TimeBodyAccelerometerJerkMagnitudeSTD()`
* Time domain gyroscope magnitude
    * Mean
        - `TimeBodyGyroscopeMagnitudeMean()`
    * Standard deviation
        - `TimeBodyGyroscopeMagnitudeSTD()`
* Time domain gyroscope jerk
    * Mean
        - `TimeBodyGyroscopeJerkMagnitudeMean()`
    * Standard deviation
        - `TimeBodyGyroscopeJerkMagnitudeSTD()`
* Frequency domain body along X, Y, and Z axes
    * Mean
        - `FrequencyBodyAccelerometerMean()-X`
        - `FrequencyBodyAccelerometerMean()-Y`
        - `FrequencyBodyAccelerometerMean()-Z`
    * Standard deviation
        - `FrequencyBodyAccelerometerSTD()*X`
        - `FrequencyBodyAccelerometerSTD()-Y`
        - `FrequencyBodyAccelerometerSTD()-Z`
* Frequency domain body along X, Y, and Z axes
    * Mean
        - `FrequencyBodyAccelerometerMeanFreq()-X`
        - `FrequencyBodyAccelerometerMeanFreq()-Y`
        - `FrequencyBodyAccelerometerMeanFreq()-Z`
* Frequency domain body jerk along X, Y, and Z axes
    * Mean
        - `FrequencyBodyAccelerometerJerkMean()-X`
        - `FrequencyBodyAccelerometerJerkMean()-Y`
        - `FrequencyBodyAccelerometerJerkMean()-Z`
    * Standard deviation
        - `FrequencyBodyAccelerometerJerkSTD()-X`
        - `FrequencyBodyAccelerometerJerkSTD()-Y`
        - `FrequencyBodyAccelerometerJerkSTD()-Z`
* Frequency domain body jerk frequency along X, Y, and Z axes
    * Mean
        - `FrequencyBodyAccelerometerJerkMeanFreq()-X`
        - `FrequencyBodyAccelerometerJerkMeanFreq()-Y`
        - `FrequencyBodyAccelerometerJerkMeanFreq()-Z`
* Frequency domain body Gyroscope along X, Y and Z axes
    * Mean
        - `FrequencyBodyGyroscopeMean()-X`
        - `FrequencyBodyGyroscopeMean()-Y`
        - `FrequencyBodyGyroscopeMean()-Z`
    * Standard deviation
        - `FrequencyBodyGyroscopeSTD()-X`
        - `FrequencyBodyGyroscopeSTD()-Y`
        - `FrequencyBodyGyroscopeSTD()-Z`
* Frequency domain body Gyroscope frequency along X, Y and Z axes
    * Mean
        - `FrequencyBodyGyroscopeMeanFreq()-X`
        - `FrequencyBodyGyroscopeMeanFreq()-Y`
        - `FrequencyBodyGyroscopeMeanFreq()-Z`
* Frequency domain body magnitude
    * Mean
        - `FrequencyBodyAccelerometerMagnitudeMean()`
    * Standard deviation
        - `FrequencyBodyAccelerometerMagnitudeSTD()`
* Frequency domain body magnitude frequency
    * Mean
        - `FrequencyBodyAccelerometerMagnitudeMeanFreq()`
* Frequency domain body jerk magnitude
    * Mean
        - `FrequencyBodyAccelerometerJerkMagnitudeMean()`
    * Standard deviation
        - `FrequencyBodyAccelerometerJerkMagnitudeSTD()`
* Frequency domain body jerk magnitude frequency
    * Mean
        - `FrequencyBodyAccelerometerJerkMagnitudeMeanFreq()`
* Frequency domain body gyroscope magnitude
    * Mean
        - `FrequencyBodyGyroscopeMagnitudeMean()`
    * Standard deviation
        - `FrequencyBodyGyroscopeMagnitudeSTD()`
* Frequency domain body gyroscope magnitude frequency
    * Mean
        - `FrequencyBodyGyroscopeMagnitudeMeanFreq()`
* Frequency domain body gyroscope jerk magnitude
    * Mean
        - `FrequencyBodyGyroscopeJerkMagnitudeMean()`
    * Standard deviation
        - `FrequencyBodyGyroscopeJerkMagnitudeSTD()`
* Frequency domain body gyroscope jerk magnitude frequency
    * Mean
        - `FrequencyBodyGyroscopeJerkMagnitudeMeanFreq()`
* Angle time domain
    * Body mean* Gravity
        - `Angle(TimeBodyAccelerometerMean,Gravity)`
    * Body jerk mean - Gravity mean
        - `Angle(TimeBodyAccelerometerJerkMean),GravityMean)`
    * Body gyroscope mean - Gravity mean
        - `Angle(TimeBodyGyroscopeMean,GravityMean)`
    * Body gyroscope jerk mean - Gravity mean
        - `Angle(TimeBodyGyroscopeJerkMean,GravityMean)`
    * X, Y and Z axes - Gravity Mean
        - `Angle(X,GravityMean)`
        - `Angle(Y,GravityMean)`
        - `Angle(Z,GravityMean)`
