# runAnalysis

Analysis Using Smartphones Dataset
==================================================================
Version 1.0
Author: Rozsa Sarga

The purpose of this project is to work with and clean data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data
==================================================================
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The data needs to be downloaded and extracted into the "UCI HAR Dataset" folder within the R working directory.
The "run_analysis.R" script reads the dataset and transforms it into a data table. 
Output of the script is stored in the project folder in the run_analysis_output.csv file.

Original project description
=================================================================
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

"run_analysis.R" script  actions
=================================================================
1. Reads data into tables 
files used for this analysis are: 
  activity_labels.txt - used as aa separate table to match activity id and acitiviy name
  features.txt - used as column name for test and train data
  test\x_test.txt - test dataset
  test\subject_test.txt - added as a column to test data set, represents the subject who performed the measures
  train\x_train.txt - train dataset
  train\subject_train.txt - added as a column to train data set, represents the subject who performed the measures
  train\y_train.txt - added as a column to train data set, represents the activity when measures were taken

2. Merges the training and the test sets to create one data set called uci_har.
category variable is created to flag each row as test or train in the new data set

3. Extracts only the measurements on the mean and standard deviation for each measurement.
4. Uses descriptive activity names to name the activities in the data set
5. Appropriately labels the data set with descriptive variable names.
tra
Following transformations applied:
- three dots replaced with "_" to be used as a separator during data tidy up
- all dots removed
- Acc replaced by Accelerometer, Gyro by Gyroscope, Mag by Magnitude and variables starting with f replaced by FFT

6. From the data set in step 5, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Tidy data is created by creating a column for features and measure for their values and moving the 561 feature columns into appropriate rows with one observation in each. Also the 3-Axial signal has been separated into a new column. 

The tidy dataset has been grouped by subject, activity and feature and avarage was created for each feature.

Output
=================================================================
This output is saved in the run_analysis_data.csv file.
