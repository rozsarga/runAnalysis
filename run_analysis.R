## This script works with data collected from the accelerometers from the Samsung Galaxy S smartphone
## Data has to be stored in "UCI HAR Dataset" folder in the working directory
## Function Returns the uci_har data table with combined and labeled test and train data  

run_analysis.R <- function () {
  
  ## checks if the folder is available
  if (!file.exists("UCI HAR Dataset")) {
    stop("UCI HAR Dataset is not available in the working directory")
  }
  library(dbplyr)
  ## loads all files into data tables
  
      ## Activity label 
      activity_labels <- read.csv("UCI HAR Dataset/activity_labels.txt", sep="", header = FALSE, col.names = c("id", "activity"))
      
      ## Feature labels 
      feature_labels <- read.csv("UCI HAR Dataset/features.txt", sep="", header = FALSE, col.names = c("id", "feature"))
      
      ## Test data 
      test_data <- read.csv("UCI HAR Dataset/test/X_test.txt", sep="", header = FALSE, col.names = feature_labels$feature)
      test_data_dt <- tbl_df(test_data)
      rm(test_data)
      sub_id <- readLines("UCI HAR Dataset/test/subject_test.txt")
      act_id <- readLines("UCI HAR Dataset/test/y_test.txt")
      test_data_dt <- mutate(test_data_dt, subjectid= sub_id, activityid =act_id, category ="test")
      
      ## Train data 
      train_data <- read.csv("UCI HAR Dataset/train/X_train.txt", sep="", header = FALSE, col.names = feature_labels$feature)
      train_data_dt <- tbl_df(train_data)
      rm(train_data)
      sub_id <- readLines("UCI HAR Dataset/train/subwrject_train.txt")
      act_id <- readLines("UCI HAR Dataset/train/y_train.txt")
      train_data_dt <- mutate(train_data_dt, subjectid= sub_id, activityid =act_id, category = "train")
  
  ## 1. Merges the training and the test sets to create one data set
      uci_har <- rbind(test_data_dt, train_data_dt)
      
  ## 2. Extracts only the measurements on the mean and standard deviation for each measurement
  ## 3. Uses descriptive activity names to name the activities in the data set
      uci_har <- uci_har %>% 
        merge(activity_labels, by.x = "activityid", by.y = "id") %>%
        select(subjectid, activity, category, contains("mean"), contains("std"))

  ## 4. Appropriately labels the data set with descriptive variable names
      names(uci_har) <- sub("\\.\\.\\.", "_", names(uci_har))
      names(uci_har) <- gsub("\\.", "", names(uci_har))
      names(uci_har) <- sub("Acc", "Accelerometer", names(uci_har))
      names(uci_har) <- sub("Gyro", "Gyroscope", names(uci_har))
      names(uci_har) <- sub("Mag", "Magnitude", names(uci_har))
      names(uci_har) <- sub("^f", "FFT", names(uci_har))
      
  ## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable 
  ## for each activity and each subject.
     library (tidyr)
     tidy_uci_har <- uci_har %>% 
       gather(feature, measure, -subjectid, - activity, -category) %>%
       separate (feature, c("feature", "3-axialSignal"), sep= "_", remove=TRUE, convert = TRUE) %>%
       group_by(subjectid, activity, feature) %>% 
       summarise(mean_measure = mean(measure))
       
  return(tidy_uci_har)
}
