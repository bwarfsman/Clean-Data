# Coursera Getting and Cleaing Data
# Final Project

Project to download raw smartphone data and create a R script to clean it 
and create a new table

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

Will need R installed 
with dply package

## run_Analysis.R

1.This Code first downloads the dataset from the website and unzips it to the working directory. 

2.Loads the training data from the training folder

3.Loads the features labels from the features.txt file and uses them to set the variable names

4.loads the activity data for training from the y_train.txt file

5.loads the subject data for training form the subject_train.txt file

6.appends the dataset from step 2 with the activity and subject data


7.the above 6 steps are repeated for the test data.

8.Once there is a full dataset, all values that are not std() or mean() are removed

9.The variables in dataset are then summarized by the mean of each activity for each subject and stored in a new dataset.



## Built With

* [Rstudio](http://www.rstudio.com)

## Repository inclues the script and a codebook

* **Bob Warfsman
https://github.com/bwarfsman/Clean-Data

