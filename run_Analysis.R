## Data is from http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
## which holds data from a test done using Samsung Galaxy smartphones.  The test
## gathered data on the phone during different activities.
##
## This script first downloads the data.  It then loads the data and stores it in two
## variables, test and train.  It then combines both datasets into one and deletes 
## the original test and train.  It them removes all variables except the ones that repesent
## standard deviations and means.  It then creates a new dataset with only the average measurement
## for each variable by activity and subject that participated.

library(dplyr)
##Down load dataset into working directory
fileUrl<-'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
download.file(fileUrl,dest='./Data.zip',method='curl')
##unzip the dataset into working directory
unzip('./Data.zip',exdir='./')

## change working directory to unzipped folder
setwd('UCI HAR Dataset/')

##Load training dataset
trData<-read.table('train/X_train.txt')
trLabel<-read.table('features.txt')
trLabel<-as.character(trLabel$V2)
names(trData)<-trLabel
trData<-cbind(read.table('train/y_train.txt'),trData)
trData<-cbind(read.table('train/subject_train.txt'),trData)

##Load test dataset
teData<-read.table('test/X_test.txt')
teLabel<-read.table('features.txt')
teLabel<-as.character(teLabel$V2)
names(teData)<-teLabel
teData<-cbind(read.table('test/y_test.txt'),teData)
teData<-cbind(read.table('test/subject_test.txt'),teData)



##combine test and train
setData<-rbind(teData,trData)
remove(teData)
remove(trData)

## Set the column names for activity and subject
colnames(setData)[1]<-'Subject'
colnames(setData)[2]<-'Activity'

## load the activity labels
activities<-read.table('activity_labels.txt')
activities<-activities$V2
## change values in activity column to activity names
setData$Activity<-factor(setData$Activity,labels=activities)

##extract only the standard deviation and mean measurments
##get list of columns to keep
##create a character vector and add 1 and 2 that represent the 
## forst two columns that need to be kept
keep<-as.integer(c(1,2))

## use regex to find all columns that are "std()" or "mean()"
keep<-append(keep,grep('mean\\(|std\\()',names(setData)))

## use the resulting to vector to remove all unwanted columns
setData<-setData[,keep]

## group the dataset by subject and activity and create a new data set that has only the mean of each
## measured variable by subject and activity
setData<-group_by(setData,Subject,Activity)
newSetData<-summarise_all(setData,funs(mean))

