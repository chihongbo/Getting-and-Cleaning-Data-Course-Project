# Getting-and-Cleaning-Data-Course-Project

## Data Description

Raw data are obtained from UCI Machine Learning repository on the Human Activity Recognition Using Smartphones Data Set.
Activity Recognition (AR) aims to recognize the actions and goals of one or more agents from a series of observations on the agents' actions and the environmental conditions. The collectors used a sensor based approach employing smartphones as sensing tools. Smartphones are an effective solution for AR, because they come with embedded built-in sensors such as microphones, dual cameras, accelerometers, gyroscopes, etc.
The data set was built from experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (walking, walking upstairs, walking downstairs, sitting, standing, laying) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration and 3-axial angular velocity were captured at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually.
The obtained data set has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

## R Script Introduction

* The train and test data frames x_train, y_train, x_test, y_test, subject_train and subject_test were directly read (`read.table()`) from the the downloaded `UCI HAR Datasets`.
* The above data frames were merged together to `x_data`, `y_data`, and `subject_data` data frame for further analysis by using 'rbind()' function.
* The column names of the x_data data frame were obtained from features.txt. The features.txt was read into the sytem, and variables of x_data was firstly filtered by the requirement (mena and std), then the meaningful features names were assigned to the filtered columns of the x_data data frame.
* The activity names were read from the 'activity_labels.txt', the the y_data variables were replaced by the activity names directly.
* x_data, y_data and subject_data were merged into a big data frame `combine_data`.
* The ddply() function was used to split data frame `combine_data` by (subject, activity), apply `colMeans()` function, and return results in a data frame `avg_data`. The new data frame was finally written as `tidy_data.txt` by using `write.table()` function.
