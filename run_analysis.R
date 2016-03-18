## run_analysis.R script to merge the training and test data collected from the Human Activity
## Recognition using smartphones: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones,
## and creates a tidy data set with the average of each variable for each activity and subject


require("data.table")
require("dplyr")
require("reshape2")


## load_subject_data() - Returns the subject table for the specified data_set: "test" or "train"
##                       

load_subject_data <- function(data_set) {
    ## Construct full path to subject_test.txt or subject_train.txt
    subject_file <- file.path(".", "UCI HAR Dataset", data_set, paste0("subject_", data_set, ".txt"))
    subject_data <- read.table(subject_file)
    names(subject_data) <- "subject"
    
    ## return subject data
    subject_data
}

## load_activity_data() - Returns the activity table for the specified data_set: "test" or "train"
##                       

load_activity_data <- function(data_set) {
    ## Construct full path to y_test.txt or y_train.txt
    y_file <- file.path(".", "UCI HAR Dataset", data_set, paste0("y_", data_set, ".txt"))
    y_data <- read.table(y_file)
    names(y_data) <- "activity"
    
    ## return y data
    y_data
}

## load_X_data() - Returns the measurements on the mean and standard deviation table for the
##                 specified data_set: "test" or "train"

load_X_data <- function(data_set, features, mean_std_columns) {
    ## Construct full path to X_test.txt or X_train.txt
    X_file <- file.path(".", "UCI HAR Dataset", data_set, paste0("X_", data_set, ".txt"))
    X_data <- read.table(X_file)
    
    ## Assign column names to X_data
    names(X_data) <- features$name
    
    ## Extract only the mean and standard deviation measurement columns
    X_data <- X_data[, mean_std_columns]
}

## load_and_merge_data() - Returns merged data from subject, y and X tables
##

load_and_merge_data <- function(data_set, features, mean_std_columns) {
    subject_data <- load_subject_data(data_set)
    y_data <- load_activity_data(data_set)
    X_data <- load_X_data(data_set, features, mean_std_columns)
    
    merge_data <- cbind(subject_data, y_data, X_data)
}


## Load features table, and determine column names that contain "mean()" and "std()" 

features <- read.table("./UCI HAR Dataset/features.txt")
names(features) <- c("id", "name")
mean_std_columns <- grepl("mean\\(\\)|std\\(\\)", features$name)

## Load activity labels table, and order by activity Id
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt");
names(activity_labels) <- c("id", "label")
activity_labels <- arrange(activity_labels, id)

## Load and merge test data
test_data <- load_and_merge_data("test", features, mean_std_columns)

## Load and merge train data
train_data <- load_and_merge_data("train", features, mean_std_columns)

## Merge test and train data frames into a single data frame
test_and_train_data <- rbind(test_data, train_data)
## Replace activity id with descriptive activity name
test_and_train_data$activity <- factor(test_and_train_data$activity, labels=activity_labels$label)
melt_data <- melt(test_and_train_data, id=c("subject", "activity"))
## Apply mean function to dataset
tidy_data <- dcast(melt_data, subject+activity ~ variable, mean)

## Write the tidy_data set to a text file
write.table(tidy_data, file="tidy_data.txt", row.name = FALSE)   
