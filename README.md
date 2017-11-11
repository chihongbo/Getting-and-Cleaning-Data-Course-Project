# Getting-and-Cleaning-Data-Course-Project

## Background

The purpose of this project is to demonstrate student's ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. The student should be required to submit: 

* a tidy data set, 
* a link to a Github repository with your script for performing the analysis, and 
* a code book that describes the variables, the data, and any transformations or work that the student performed to clean up the data called CodeBook.md. The student should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

The data for the project can be downloaded from the link: [UCI HAR Dataset](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip). 

## R Project Introduction
For the purpose, one R script called `run_analysis.R` was developed, which does the following things:

- Merges the training and the test sets to create one data set by using `rbind()` function to the traing and test data files: `X_train.txt, y_train.txt, subject_train.txt, X_test.txt, y_test.txt and subject_test.txt`.
- Extracts only the measurements on the mean and standard deviation for each measurement by using regular expression function `grep()`.
- Uses descriptive activity names from `activity_labels.txt` to name the activities in the data set . 
- Appropriately labels the data set with descriptive variable names by using `gsub()` function to replace the abbreviated letters to some meaningful words from `features.txt` file.
- From the data set in step 4, creates a second, independent tidy data set `tidy_data.txt` with the average of each variable for each activity and each subject. In this step, `ddply()` function was used to split data frame by `(subject, activity)`, apply function('colMeans()' function), return Results in a new data frame. Finally the new data frame was written to the `tidy_data.txt` file by using 'write.table()' function.
