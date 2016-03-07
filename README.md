# GETTING-AND-CLEANING-DATA-PEER-ASSESSMENT-PROJECT

The entire code required for this project is available at the "run_analysis.R".

First, assign a working directory for this project and then source the file : source("run_analysis.R") into the console.

The code performs the following steps:
Step 1: 
The code downloads the data files from "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip".
Step 2:
It unzip the files and reads all the data and stores it in corresponding variables
Step 3:
Then the following tasks are performed:
1.Merges the training and the test sets to create one data set.
2.Extracts only the measurements on the mean and standard deviation for each measurement. 
3.Uses descriptive activity names to name the activities in the data set
4.Appropriately labels the data set with descriptive variable names. 
5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
