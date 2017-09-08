## download the file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
## unzip the file and get a folder named as "UCI HAR Dataset"
## task 1: merge the training set and the test set


## reaed the variable names
vr <- read.table("./UCI HAR Dataset/features.txt", nrow=561)
## read both dataset files separately as tables
train<- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=vr$V2)
test<- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=vr$V2)
comb<- rbind(train, test)

## comb is the combined dataset for both training and test datasets. 

## task 2: Extracts only the measurements on the mean and standard deviation for each measurement.
## extract the variables for only mean and std

mnst<- comb[, grepl(("mean|std"), names(comb))]
## need to remove the varialbes that contain meanfrequency
mnst2<- mnst[, !grepl("meanFreq", names(mnst))]

## task 3: Uses descriptive activity names to name the activities in the data set
lab_test<- read.table("./UCI HAR Dataset/test/y_test.txt")
lab_train<- read.table("./UCI HAR Dataset/train/y_train.txt")
lab_comb<- rbind(lab_train, lab_test)
lab<- read.table("./UCI HAR Dataset/activity_labels.txt",col.names= c("label", "activity") )
merg_act<- merge(lab_comb,lab, by.x="V1", by.y="label")

activity<- merg_act$activity

# act_merg is the activities for the merged test and training data

withact_comb <- cbind(activity, mnst2)

# so in the withact_comb, the first column is the "activity", and the rest columns are variable related to mean and std.


## task 4: Appropriately labels the data set with descriptive variable names.

## The varialbe names are descriptive through the previous tasks. 

## task 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
## combine the subject info
sub_train<- read.table("./UCI HAR Dataset/train/subject_train.txt")
sub_test<- read.table("./UCI HAR Dataset/test/subject_test.txt")
sub_comb<- rbind(sub_train, sub_test)

alldata<- cbind(sub_comb, withact_comb) 
colnames(alldata) [1] <- "subject"


melt_data<- melt(alldata, id.vars=c("subject", "activity"))
tidy_data<- dcast(melt_data, subject + activity ~variable, mean)
write.table(tidy_data, file="./tidy.data.txt", row.name=FALSE)
