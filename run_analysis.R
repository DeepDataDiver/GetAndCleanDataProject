##########################################################################
##                                                                      ##
## Getting and Cleaning Data Course Project                             ##
##                                                                      ##
##########################################################################

# This is the original datasource for the project 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

# This script (R script run_analysis.R) performs the following tasks:
#  
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for 
#    each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of 
#    each variable for each activity and each subject.
# 

#------------------------------------------------------------------------
# Set working directory
#------------------------------------------------------------------------
# Set working directory to datasources location 
# (this will become the repo data location later)
setwd("./Project")

#------------------------------------------------------------------------
# access, load, and unzip data if necessary
#------------------------------------------------------------------------
# source input file location 
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
localZipFile <- "UCI_HAR_Dataset.zip"

# subdirectory where data resides
subdir <- "UCI HAR Dataset"

# read the file and unzip it into working directory (only once)
if (!file.exists(subdir)) {
   # download zip file
   download.file(fileURL, localZipFile)
   
   # unzip data
   unzip(localZipFile)
}

#------------------------------------------------------------------------
# assemble input file names 
#------------------------------------------------------------------------
activitiesFilename <- paste("./", subdir, "/", "activity_labels.txt", sep="")
featuresFilename <- paste("./", subdir, "/", "features.txt", sep="")

# training files
trainingSetFilename <- paste("./", subdir, "/", "train/X_train.txt", sep="")
trainingLabelsFilename <- paste("./", subdir, "/", "train/y_train.txt", sep="")
trainingSubjectFilename <- paste("./", subdir, "/", "train/subject_train.txt", sep="")

# test files
testSetFilename <- paste("./", subdir, "/", "test/X_test.txt", sep="")
testLabelsFilename <- paste("./", subdir, "/", "test/y_test.txt", sep="")
testSubjectFilename <- paste("./", subdir, "/", "test/subject_test.txt", sep="")

# total acelerometer
testTotalAcelerometerXFilename <- paste("./", subdir, "/", "test/Inertial Signals/total_acc_x_test.txt", sep="")
trainingTotalAcelerometerXFilename <- paste("./", subdir, "/", "train/Inertial Signals/total_acc_x_train.txt", sep="")
testTotalAcelerometerYFilename <- paste("./", subdir, "/", "test/Inertial Signals/total_acc_y_test.txt", sep="")
trainingTotalAcelerometerYFilename <- paste("./", subdir, "/", "train/Inertial Signals/total_acc_y_train.txt", sep="")
testTotalAcelerometerZFilename <- paste("./", subdir, "/", "test/Inertial Signals/total_acc_z_test.txt", sep="")
trainingTotalAcelerometerZFilename <- paste("./", subdir, "/", "train/Inertial Signals/total_acc_z_train.txt", sep="")

# body acelerometer
testBodyAcelerometerXFilename <- paste("./", subdir, "/", "test/Inertial Signals/body_acc_x_test.txt", sep="")
trainingBodyAcelerometerXFilename <- paste("./", subdir, "/", "train/Inertial Signals/body_acc_x_train.txt", sep="")
testBodyAcelerometerYFilename <- paste("./", subdir, "/", "test/Inertial Signals/body_acc_y_test.txt", sep="")
trainingBodyAcelerometerYFilename <- paste("./", subdir, "/", "train/Inertial Signals/body_acc_y_train.txt", sep="")
testBodyAcelerometerZFilename <- paste("./", subdir, "/", "test/Inertial Signals/body_acc_z_test.txt", sep="")
trainingBodyAcelerometerZFilename <- paste("./", subdir, "/", "train/Inertial Signals/body_acc_z_train.txt", sep="")

# body gyroscope 
testBodyGyroXFilename <- paste("./", subdir, "/", "test/Inertial Signals/body_gyro_x_test.txt", sep="")
trainingBodyGyroXFilename <- paste("./", subdir, "/", "train/Inertial Signals/body_gyro_x_train.txt", sep="")
testBodyGyroYFilename <- paste("./", subdir, "/", "test/Inertial Signals/body_gyro_y_test.txt", sep="")
trainingBodyGyroYFilename <- paste("./", subdir, "/", "train/Inertial Signals/body_gyro_y_train.txt", sep="")
testBodyGyroZFilename <- paste("./", subdir, "/", "test/Inertial Signals/body_gyro_z_test.txt", sep="")
trainingBodyGyroZFilename <- paste("./", subdir, "/", "train/Inertial Signals/body_gyro_z_train.txt", sep="")


#------------------------------------------------------------------------
# read data tables  
#------------------------------------------------------------------------
# get the activities and features lists 
activities <- read.table(activitiesFilename)
features <- read.table(featuresFilename)

# get training data 
trainingSet <- read.table(trainingSetFilename)
trainingLabels <- read.table(trainingLabelsFilename)
trainingSubject <- read.table(trainingSubjectFilename)

# get test set 
testSet <- read.table(testSetFilename)
testLabels <- read.table(testLabelsFilename)
testSubject <- read.table(testSubjectFilename)

# get total accelerometer data 
testTotalAcelerometerX <- read.table(testTotalAcelerometerXFilename)
trainingTotalAcelerometerX <- read.table(trainingTotalAcelerometerXFilename)
testTotalAcelerometerY <- read.table(testTotalAcelerometerYFilename)
trainingTotalAcelerometerY <- read.table(trainingTotalAcelerometerYFilename)
testTotalAcelerometerZ <- read.table(testTotalAcelerometerZFilename)
trainingTotalAcelerometerZ <- read.table(trainingTotalAcelerometerZFilename)

# get body accelerometer
testBodyAcelerometerX <- read.table(testBodyAcelerometerXFilename)
trainingBodyAcelerometerX <- read.table(trainingBodyAcelerometerXFilename)
testBodyAcelerometerY <- read.table(testBodyAcelerometerYFilename)
trainingBodyAcelerometerY <- read.table(trainingBodyAcelerometerYFilename)
testBodyAcelerometerZ <- read.table(testBodyAcelerometerZFilename)
trainingBodyAcelerometerZ <- read.table(trainingBodyAcelerometerZFilename)

# get body gyro data
testBodyGyroX <- read.table(testBodyGyroXFilename)
trainingBodyGyroX <- read.table(trainingBodyGyroXFilename)
testBodyGyroY <- read.table(testBodyGyroYFilename)
trainingBodyGyroY <- read.table(trainingBodyGyroYFilename)
testBodyGyroZ <- read.table(testBodyGyroZFilename)
trainingBodyGyroZ <- read.table(trainingBodyGyroZFilename)

#------------------------------------------------------------------------
# Task 4: Appropriately labels data sets (done in advance for convenience)
#------------------------------------------------------------------------
# 'activity_labels.txt': Links the class labels with their activity name.
names(activities) = c("ACTIVITY_ID", "ACTIVITY_NM")    
# 'features.txt': List of all features.
names(features) = c("FEATURE_ID", "FEATURE_NM") 

# 'test/y_test.txt': Test labels. Each row identifies the activity performed 
# Its range is from 1 to 6  
names(testLabels) = c("ACTIVITY_ID")
names(trainingLabels) = c("ACTIVITY_ID")

# 'test/X_test.txt': Test set.
names(testSet) = features[, 2]
names(trainingSet) = features[,2]

# train/subject_train.txt': Each row identifies the subject who performed 
# the activity for each window sample. Its range is from 1 to 30. 
names(testSubject) = c("SUBJECT_ID")
names(trainingSubject) = c("SUBJECT_ID")

# 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the
# smartphone accelerometer X axis in standard gravity units 'g'. Every row shows 
# a 128 element vector. The same description applies for the 'total_acc_x_train.txt' 
# and 'total_acc_z_train.txt' files for the Y and Z axis. 


# 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal 
# obtained by subtracting the gravity from the total acceleration. 


# 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector 
# measured by the gyroscope for each window sample. The units are radians/second.
 

#------------------------------------------------------------------------
# assemble test data set  
#------------------------------------------------------------------------
testData <- cbind(testLabels, testSubject, testSet)

#------------------------------------------------------------------------
# assemble training data set  
#------------------------------------------------------------------------
trainingData <- cbind(trainingLabels, trainingSubject, trainingSet)

#------------------------------------------------------------------------
# Task 1: Merges the training and the test sets to create one data set
#------------------------------------------------------------------------
data <- rbind(testData, trainingData)

#------------------------------------------------------------------------
# Task 2: Extracts only the measurements on the mean and standard 
#         deviation for each measurement
#------------------------------------------------------------------------
columnNames <- as.data.frame(sapply(features$FEATURE_NM, 
                               function(x) if(grepl("mean()", x) | grepl("std()", x)) 
                                 as.character(x) else "NA"))
names(columnNames) <- c("NAME")
selected <- c(c("ACTIVITY_ID", "SUBJECT_ID"), 
              as.character(columnNames$NAME[columnNames$NAME!="NA"]))
data <- data[,selected]

#------------------------------------------------------------------------
# Task 3: Uses descriptive activity names to name the activities in the 
#         data set
#------------------------------------------------------------------------
data$ACTIVITY_ID <- factor(data$ACTIVITY_ID, labels=activities$ACTIVITY_NM)

#------------------------------------------------------------------------
# Task 4: Appropriately labels data sets
#------------------------------------------------------------------------
# completed earlier for convenience

#------------------------------------------------------------------------
# Task 5: Creates a second, independent tidy data set with the average of 
#         each variable for each activity and each subject
#------------------------------------------------------------------------
data <- data[order(data$ACTIVITY_ID, data$SUBJECT_ID),]
tidy <- aggregate(. ~ ACTIVITY_ID + SUBJECT_ID, data=data, mean)

