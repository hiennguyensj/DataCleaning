# *Getting and Cleaning Data Course Project*

## Project Description
The purpose of this project is to create a tidy data set from the Human Activity Recognition Using Smartphones Data Set (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).  The data was collected from 30 volunteers wearing smartphones (Samsung Galaxy S II) on their waists, and performed six different activities: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING. 

## Files in Github repository
* __CodeBook.md__ : Contains information about the collected data
* __run_analysis.R__ : R script to merge the collected test and train data sets, and to create a tidy data set text file
* __README.md__ : Describe how the script works

## run_analysis.R script functions
* Merges the training and test data sets to create one data set
* Extracts only the mean and standard deviation measurement variables
* Uses descriptive activity names: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING and LAYING
* Appropriately labels the data set with descriptive variable names
* Create a tidy data set with the average of each variable for each activity and subject

## How to run the run_anlysis.R script
1. Download data for the project from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, and extract the contents to the `UCI HAR Dataset` folder where the run_analysis.R script is located
2. The script requires data.table, plyr and reshape2 packages installed
3. Open a R console, and set the working directory to the script location
4. Source run_analysis.R file. `source('run_analysis.R')`
5. The script will generate the tidy_data.txt which contains the tidy data set 
