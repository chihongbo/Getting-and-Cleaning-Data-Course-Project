library(plyr)
###############################################
# STEP 0 - Get data ###########################
###############################################

Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
File <- "UCI HAR Dataset.zip"

if (!file.exists(File)) {
  download.file(Url, File, mode = "wb")
}

dataSet <- "UCI HAR Dataset"
if (!file.exists(dataSet)) {
  unzip(File)
}

#################################################################
# Step 1 Merge the training and test sets to create one data set
#################################################################

x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")


x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)

subject_data <- rbind(subject_train, subject_test)

#################################################################################################
# Step 2 Extract only the measurements on the mean and standard deviation for each measurement
################################################################################################

features <- read.table("./UCI HAR Dataset/features.txt")
meanstd_column <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, meanstd_column]
meanstd_colname<-features[mean_and_std_features, 2]

# remove parethesis in the end of the name
meanstd_colname <- gsub("[\\(\\)-]", "", meanstd_colname)

# replace the column name with some real mean
meanstd_colname <- gsub("^f", "frequencyDomain", meanstd_colname)
meanstd_colname <- gsub("^t", "timeDomain", meanstd_colname)
meanstd_colname <- gsub("Acc", "Accelerometer", meanstd_colname)
meanstd_colname <- gsub("Gyro", "Gyroscope", meanstd_colname)
meanstd_colname <- gsub("Mag", "Magnitude", meanstd_colname)
meanstd_colname <- gsub("Freq", "Frequency", meanstd_colname)
meanstd_colname <- gsub("mean", "Mean", meanstd_colname)
meanstd_colname <- gsub("std", "StandardDeviation", meanstd_colname)
meanstd_colname <- gsub("BodyBody", "Body", meanstd_colname)


###############################################################################
# Step 3 Use descriptive activity names to name the activities in the data set
############################################################################

activities <- read.table("./UCI HAR Dataset/activity_labels.txt")

# update values with correct activity names
y_data[, 1] <- activities[y_data[, 1], 2]

#############################################################################
# Step 4 Label the data set with descriptive variable names
#############################################################################

# Define the X column names
names(x_data) <- meanstd_colname

# define the y column name
names(y_data) <- "activity"

# define the subject column name
names(subject_data) <- "subject"

##combine all the data in the one big date set
combine_data <- cbind(x_data, y_data, subject_data)

#############################################################################
# Step 5 Create a second, independent tidy data set with 
#the average of each variable for each activity and each subject
#############################################################################

# group by subject and activity and summarise using mean
avg_data <- ddply(combine_data, .(subject, activity), function(x) colMeans(x[, 1:66]))
# export the data to an external tidy data
write.table(avg_data, "tidy_data.txt", row.name=FALSE)