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

#concetenate the data tables by rows
dataSubj <- rbind(subj.train, subj.test)
data.activity<-rbind(y.train, y.test)
data.feat<- rbind(x.train, x.test)

#fixing column names
names(dataSubj)<-c("Subject")
names(data.activity)<-c("Activity")
names(data.feat)<-features$V2


#task 1: merging train and test sets

combined <- cbind(dataSubj,data.activity)
Fulldata<-cbind(data.feat,combined) #dim = 10299 obs of 563 variables

#task 2: " Extracts only measurements on the mean and standard deviation
subset.Feature.Names<-features$V2[grep("mean\\(\\)|std\\(\\)",features$V2)]
selected.Names <-c(as.character(subset.Feature.Names),"Subject","Activity")
Extracted.data<-subset(Fulldata, select = selected.Names) #dim 10299 obs of 68 variables


#task 3: Use descriptive activity names to name the activities

Extracted.data$Activity <- as.character(Extracted.data$Activity)
Extracted.data$Activity[Extracted.data$Activity == 1] <- "Walking"
Extracted.data$Activity[Extracted.data$Activity == 2] <- "Walking Upstairs"
Extracted.data$Activity[Extracted.data$Activity == 3] <- "Walking Downstairs"
Extracted.data$Activity[Extracted.data$Activity == 4] <- "Sitting"
Extracted.data$Activity[Extracted.data$Activity == 5] <- "Standing"
Extracted.data$Activity[Extracted.data$Activity == 6] <- "Laying"
Extracted.data$Activity <- as.factor(Extracted.data$Activity)


#task 4: Appropriate lables for the data set

names(Extracted.data) <- gsub("Acc", "Accelerator", names(Extracted.data))
names(Extracted.data) <- gsub("Mag", "Magnitude", names(Extracted.data))
names(Extracted.data) <- gsub("Gyro", "Gyroscope", names(Extracted.data))
names(Extracted.data) <- gsub("^t", "time", names(Extracted.data))
names(Extracted.data) <- gsub("^f", "frequency", names(Extracted.data))



#task 5: Create a tidy data set with independent dat set with average values

Average.value.data <- aggregate(.~Subject + Activity, Extracted.data, mean)
tidy.data <- Average.value.data[order(Average.value.data$Subject,Average.value.data$Activity),]
write.table(tidy.data, file = "Tidy.txt", row.names = FALSE)
