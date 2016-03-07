rm(list = ls(all = TRUE))
# loading all neccessary packages
library(plyr)
library(data.table) 
library(dplyr)

# downloading all the files into my computer
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",temp)
unzip(temp, list = TRUE) #This provides the list of variables and I choose the ones that are applicable for this data set
y.test <- read.table(unzip(temp, "UCI HAR Dataset/test/y_test.txt"))
x.test <- read.table(unzip(temp, "UCI HAR Dataset/test/X_test.txt"))
subj.test <- read.table(unzip(temp, "UCI HAR Dataset/test/subject_test.txt"))
y.train <- read.table(unzip(temp, "UCI HAR Dataset/train/y_train.txt"))
x.train <- read.table(unzip(temp, "UCI HAR Dataset/train/X_train.txt"))
subj.train <- read.table(unzip(temp, "UCI HAR Dataset/train/subject_train.txt"))
features <- read.table(unzip(temp, "UCI HAR Dataset/features.txt"))
unlink(temp)

#fixing column names

colnames(x.train) <- t(features[2])
colnames(x.test) <- t(features[2])

#merging x and y train sets
x.train$activities <- y.train[, 1]
x.train$participants <- subj.train[, 1]
x.test$activities <- y.test[, 1]
x.test$participants <- subj.test[, 1]

#task 1: merging train and test sets
combined <- rbind(x.train, x.test)
duplicated(colnames(combined))
combined <- combined[, !duplicated(colnames(combined))]

#task 2: " Extracts only measurements on the mean and standard deviation

Mean <- grep("mean()", names(combined), value = FALSE, fixed = TRUE)
Mean <- append(Mean, 471:477)
instrument.mean.matrix <- combined[Mean]
# For Standard deviations
sd <- grep("std()", names(combined), value = FALSE)
instrument.sd.matrix<- combined[sd]


#task 3: Use descriptive activity names to name the activities

combined$activities <- as.character(combined$activities)
combined$activities[combined$activities == 1] <- "Walking"
combined$activities[combined$activities == 2] <- "Walking Upstairs"
combined$activities[combined$activities == 3] <- "Walking Downstairs"
combined$activities[combined$activities == 4] <- "Sitting"
combined$activities[combined$activities == 5] <- "Standing"
combined$activities[combined$activities == 6] <- "Laying"
combined$activities <- as.factor(combined$activities)


#task 4: Appropriate lables for the data set

names(combined) <- gsub("Acc", "Accelerator", names(combined))
names(combined) <- gsub("Mag", "Magnitude", names(combined))
names(combined) <- gsub("Gyro", "Gyroscope", names(combined))
names(combined) <- gsub("^t", "time", names(combined))
names(combined) <- gsub("^f", "frequency", names(combined))

combined$participants <- as.character(combined$participants)
combined$participants[combined$participants == 1] <- "Participant 1"
combined$participants[combined$participants == 2] <- "Participant 2"
combined$participants[combined$participants == 3] <- "Participant 3"
combined$participants[combined$participants == 4] <- "Participant 4"
combined$participants[combined$participants == 5] <- "Participant 5"
combined$participants[combined$participants == 6] <- "Participant 6"
combined$participants[combined$participants == 7] <- "Participant 7"
combined$participants[combined$participants == 8] <- "Participant 8"
combined$participants[combined$participants == 9] <- "Participant 9"
combined$participants[combined$participants == 10] <- "Participant 10"
combined$participants[combined$participants == 11] <- "Participant 11"
combined$participants[combined$participants == 12] <- "Participant 12"
combined$participants[combined$participants == 13] <- "Participant 13"
combined$participants[combined$participants == 14] <- "Participant 14"
combined$participants[combined$participants == 15] <- "Participant 15"
combined$participants[combined$participants == 16] <- "Participant 16"
combined$participants[combined$participants == 17] <- "Participant 17"
combined$participants[combined$participants == 18] <- "Participant 18"
combined$participants[combined$participants == 19] <- "Participant 19"
combined$participants[combined$participants == 20] <- "Participant 20"
combined$participants[combined$participants == 21] <- "Participant 21"
combined$participants[combined$participants == 22] <- "Participant 22"
combined$participants[combined$participants == 23] <- "Participant 23"
combined$participants[combined$participants == 24] <- "Participant 24"
combined$participants[combined$participants == 25] <- "Participant 25"
combined$participants[combined$participants == 26] <- "Participant 26"
combined$participants[combined$participants == 27] <- "Participant 27"
combined$participants[combined$participants == 28] <- "Participant 28"
combined$participants[combined$participants == 29] <- "Participant 29"
combined$participants[combined$participants == 30] <- "Participant 30"
combined$participants <- as.factor(combined$participants)


#task 5: Create a tidy data set

combined.dt <- data.table(combined)
TidyData <- combined.dt[, lapply(.SD, mean), by = 'participants,activities']
write.table(TidyData, file = "Tidy.txt", row.names = FALSE)
