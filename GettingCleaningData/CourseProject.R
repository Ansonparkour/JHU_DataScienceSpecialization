####################################################
#JHU_Getting and Cleaning Data 
#Week4 Course Project
#Reference: hglennrock/getting-cleaning-data-project
####################################################

getwd()
setwd("/Users/Sean/Desktop")
setwd("./UCI HAR Dataset/")


#read features and labels data 
features     = read.table('./features.txt',header=FALSE)
activity_labels = read.table('./activity_labels.txt',header=FALSE)

#read the train data 
subject_train = read.table('./train/subject_train.txt',header=FALSE)
x_train       = read.table('./train/x_train.txt',header=FALSE)
y_train       = read.table('./train/y_train.txt',header=FALSE)

#read the test data
subject_test = read.table('./test/subject_test.txt',header=FALSE)
x_test       = read.table('./test/x_test.txt',header=FALSE)
y_test       = read.table('./test/y_test.txt',header=FALSE)

#rename the column name 
colnames(activity_labels)  = c('activityId','activity_labels')
colnames(subject_train)  = c("subjectId")
colnames(x_train)        = features[,2]
colnames(y_train)        = c("activityId")
colnames(subject_test) = c("subjectId")
colnames(x_test)       = features[,2]
colnames(y_test)       = c("activityId")



##1.Merges the training and the test sets to create one data set.
training = cbind(y_train,subject_train,x_train)
testing = cbind(y_test,subject_test,x_test)
# combine training and testing data 
data = rbind(training,testing)


##2.Extracts only the measurements on the mean and standard deviation for each measurement.
colNames  = colnames(data)
#grep mean and sd and activities name
logicalVector = (grepl("activity..",colNames) | grepl("subject..",colNames) | grepl("-mean..",colNames) & 
                     !grepl("-meanFreq..",colNames) & 
                     !grepl("mean..-",colNames) | grepl("-std..",colNames) & 
                     !grepl("-std()..-",colNames))
# subset data, extracts only the measurements
sub_data = data[logicalVector==TRUE]


#3.Uses descriptive activity names to name the activities in the data set
sub_data = merge(sub_data,activity_labels,by='activityId',all.x=TRUE)


#4.Appropriately labels the data set with descriptive variable names.
colNames  = colnames(sub_data)
for (i in 1:length(colNames)) 
{
    colNames[i] = gsub("\\()","",colNames[i])
    colNames[i] = gsub("-std$","StdDev",colNames[i])
    colNames[i] = gsub("-mean","Mean",colNames[i])
    colNames[i] = gsub("^(t)","time",colNames[i])
    colNames[i] = gsub("^(f)","freq",colNames[i])
    colNames[i] = gsub("([Gg]ravity)","Gravity",colNames[i])
    colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body",colNames[i])
    colNames[i] = gsub("[Gg]yro","Gyro",colNames[i])
    colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
    colNames[i] = gsub("([Bb]odyaccjerkmag)","BodyAccJerkMagnitude",colNames[i])
    colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
    colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
};
colnames(sub_data) = colNames


#5.From the data set in step 4, creates a second, independent tidy data set with 
#the average of each variable for each activity and each subject.

# get out of activity_labels column
sub_data  = sub_data[,names(sub_data) != 'activity_labels']

# Summarizing the sub_data  each activity and each subject
tidy_data = aggregate(sub_data[,names(sub_data) != c('activityId','subjectId')],
                      by=list(activityId=sub_data$activityId,subjectId = sub_data$subjectId),mean)

#get in the activity_labels
tidy_data = merge(tidyd_ata,activity_labels,by='activityId',all.x=TRUE)







