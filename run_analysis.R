library(dplyr)

## Download raw data to working directory and unzip data
dataURL = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists("har_raw.zip")){
      download.file(dataURL, destfile = "har_raw.zip")
      }
unzip("har_raw.zip")

## Load Data and Labels into R

# Load names of variables
features <- read.table("./UCI HAR Dataset/features.txt")

# Load descriptive labels for the six axticity types
activitylabels <- read.table("./UCI HAR Dataset/activity_labels.txt")

# Load main data files for both test subjects and training subjects
# Name variables using labels from "features" above.  Remove parentheses from the names.
xtest <- read.table("./UCI HAR Dataset/test/X_test.txt", 
                    header = FALSE, col.names = sub("\\(\\)", "",features[,2]))
xtrain <- read.table("./UCI HAR Dataset/train/X_train.txt",
                     header = FALSE, col.names = sub("\\(\\)", "",features[,2]))

## Extract only the mean and standard deviation of each measurement
xtest <- select(xtest, grep("mean\\(\\)|std", features[,2]))
xtrain <- select(xtrain, grep("mean\\(\\)|std", features[,2]))

# Load activity type for each observation in both dataframes
ytest <- read.table("./UCI HAR Dataset/test/y_test.txt")
ytrain <- read.table("./UCI HAR Dataset/train/y_train.txt")

## Give activity labels descriptive names
ytestf <- factor(ytest[,1], levels = 1:6, labels = activitylabels[,2])
ytrainf <- factor(ytrain[,1], levels = 1:6, labels = activitylabels[,2])

# Load subject number for each observation in both the test and training data
subjecttest <- read.table("./UCI HAR Dataset/test/subject_test.txt",col.names = "subject")
subjecttrain <- read.table("./UCI HAR Dataset/train/subject_train.txt",col.names = "subject")

## Add subject number and activity type to each obervation in each dataframe
xtest <- data.frame(subjecttest, activity = ytestf, xtest)
xtrain <- data.frame(subjecttrain, activity = ytrainf, xtrain)

## Merge test and training data
HAR_data <- rbind(xtest, xtrain)

# Create a second, independent tidy data set with the average of each variable for each activity 
# and each subject

# Compute average of each variable for each activity and each subject
HAR_summary <- HAR_data %>% group_by(subject, activity) %>% summarize_each(funs(mean))

# Determine the number of observations in each group by activity and subject
HAR_ngroups <- HAR_data %>% group_by(subject, activity) %>% summarize(n.observations = length(subject))

# Merge together the averages for each subject and each activity along with the number of obs
HAR_summary <- full_join(HAR_ngroups, HAR_summary, c("subject", "activity"))

# Rename variables containing averages to indicate that they are averages
names(HAR_summary)[4:69] <- paste("average",names(HAR_summary)[4:69],sep=".")

# Write this dataframe to a file
write.table(HAR_summary, "HAR_summary.txt", row.name=FALSE)
