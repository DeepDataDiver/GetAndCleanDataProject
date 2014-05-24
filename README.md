GetAndCleanDataProject
======================

## Getting and Cleaning Data Course Project

**Purpose**   
``````````````````````````````````````````
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project.
``````````````````````````````````````````

**Sumission requirements**
`````````````````````````````````````````` 
You will be required to submit: 
1) a tidy data set  with the average of each variable for each activity and each subject.,   
2) a link to a Github repository with your script for performing the analysis, and   
3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. 
4) You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.
``````````````````````````````````````````
### Input   

Input dataset: Human Activity Recognition Using Smartphones Dataset v1

The input dataset is available at:   
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

**Human Activity Recognition Using Smartphones Experiment**
``````````````````````````````````````````  
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

``````````````````````````````````````````  

### Processing
 
Processing script: An R script (run_analysis.R) the following. 

1. Loads the input dataset from the web and unzips into the working directory
2. Assemble input file names and reads input data tables. 
`````````````````````````````````````````` 
Note that data from inertial signals is not read from their original data files but from the testSet and trainingSet that already aggregate them.
`````````````````````````````````````````` 
3. Appropiately labels column names in the data sets    
4. Merges the training and the test sets to create one data set.
5. Extracts only the measurements on the mean and standard deviation for each measurement. 
6. Uses descriptive activity names to name the activities in the data set
7. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


### Output
- A file named tdy.txt containts the data set resulting from the execution of the script run_analysis.R       

``````````````````````````````````````````  
A code book (CodeBook.md) describes the variables, the data, and any transformations or work performed to clean up the data
`````````````````````````````````````````` 