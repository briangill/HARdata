#Data Codebook for Coursera Getting and Cleaning Data Course Project

The R script run_analysis.R downloads raw data as a zip file from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip, unzips the file, loads all necessary data into R, and processes it to create the tidy data file HAR_summary.txt.
 

##Study Design

Experiments were carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, 3-axial linear acceleration (tAcc-XYZ) and 3-axial angular velocity (tGyro-XYZ) time domain signals (prefix 't' to denote time) were captured at a constant rate of 50Hz. The experiments were video-recorded to label the data manually. The obtained dataset was been randomly partitioned into two sets, where 70% of the volunteers were selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity (tBodyAcc-XYZ and tGravityAcc-XYZ). The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally, a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals).

This results in the following list of signals, where '.XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

- tBodyAcx.XYZ
- tGravityAcc.XYZ
- tBodyAccJerk.XYZ
- tBodyGyro.XYZ
- tBodyGyroJerk.XYZ
- tBodyAccMag
- tGravityAccMag
- tBodyAccJerkMag
- tBodyGyroMag
- tBodyGyroJerkMag
- fBodyAcc.XYZ
- fBodyAccJerk.XYZ
- fBodyGyro.XYZ
- fBodyAccMag
- fBodyAccJerkMag
- fBodyGyroMag
- fBodyGyroJerkMag

For each of these signals, 17 different variables were then computed for each time window.  We will restrict our analysis to two of these variables -- the mean and standard deviation -- for each signal.  All other variables will be dropped.  For each signal, there will then be two variables, one for the mean and one for the standard deviation.  For example, for the fBodyAccMag signal, the two variables will be "fBodyAccMag.mean" for the mean and "fBodyAccMag.std" for the standard deviation.  For 3-axial signals, there will be two variables in each direction (X, Y, and Z).  For example, there are six variables for tBodyAcx.XYZ: "tBodyAcx.mean.X", "tBodyAcx.std.X", "tBodyAcx.mean.Y", "tBodyAcx.std.Y", "tBodyAcx.mean.Z", "tBodyAcx.std.Z".  

##Raw Data
The raw data can be found in the file https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.  This zipped file contains a number of different files needed for our analyses. The first two contain general information about the data and how it was collected:
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.

The following files will be loaded into R and directly used in our script to process the data:
- 'train/X_train.txt': The raw data for the variables discussed above for the 21 training subjects.
- 'test/X_test.txt': The raw data for the variables discussed above for the 9 test subjects.
- 'train/subject_train.txt': Subject number for each row in the training data.
- 'test/subject_test.txt': Subject number for each row in the test data.
- 'train/y_train.txt': Numeric activity labels for each row in the training data.
- 'test/y_test.txt': Numeric activity labels for each row in the test data.
- 'activity_labels.txt': Links the numeric activity labels with their descriptive activity name.
- 'features.txt': List of variable names for each column in the raw data.

##Data Processing
The R script run_analysis.R processes the raw data into a single tidy data file named HAR_summary.txt.  Steps in the data processing:
* Download and unzip raw data
* Load the 8 files listed above into R. "X_train" and "X_test" contain the primary data.
* Drop all variables from "X_train" and "X_test" except for the mean and standard deviation of each signal (as discussed above).
* Use "features" to add descriptive variable names to "X_train" and "X_test"
* Use "activity-labels" to convert "y_train" and "y_test" from numeric labels to descriptive activity labels.
* Add columns to "X_train" and "X_test" to add variables for the subject number and the activity type for each row.
* Merge the data from "X_train" and "X_test" into a single dataframe, combining together the test subjects and training subjects. 

The steps described above result in an initial tidy dataset with 68 variables (subject ID, activity type, and mean and standard deviation for each of 33 different signals). The dataset has 10,299 rows, each of which represents a short time interval of signal data from the cell phone for one subject performing one type of activity.  For each subject, there are numerous time intervals for each activity type.  For example, for subject 1, there are 95 rows for WALKING, 53 for WALKING_UPSTAIRS, 49 for WALKING_DOWNSTAIRS, etc.  

As a final step, we compute the average of each variable for each subject and each activity.  This results in a new dataset with a single row for each combination of subject and activity (180 total rows; 6 activities for each of the 30 subjects).  These variables are no longer a single mean or standard deviation of one of the signals; instead, they are an average across many means or standard deviations.  As a result, we will append "average." to the start of each variable name to indicate that it is an average of many values of the original variable.  For example, the average of the variable "tBodyAcc.mean.X" across all time intervals for each combination of subject and activity type will be named "average.tBodyAcc.mean.X".  We also include in this final dataset the number of observations that were average to produe each row.

##Complete List of Variables in Final Dataset
The complete list of variables in the final tidy dataset HAR_summary.txt is shown below.  

- "subject":        Subject number (1-30 for the 30 subjects) 
- "activity":       Activity type (one of 6 types: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) 
- "n.observations": Total number of observations for the subject and activity.
- "average.tBodyAcc.mean.X" 
- "average.tBodyAcc.mean.Y" 
- "average.tBodyAcc.mean.Z" 
- "average.tBodyAcc.std.X" 
- "average.tBodyAcc.std.Y" 
- "average.tBodyAcc.std.Z" 
- "average.tGravityAcc.mean.X" 
- "average.tGravityAcc.mean.Y" 
- "average.tGravityAcc.mean.Z" 
- "average.tGravityAcc.std.X" 
- "average.tGravityAcc.std.Y" 
- "average.tGravityAcc.std.Z" 
- "average.tBodyAccJerk.mean.X" 
- "average.tBodyAccJerk.mean.Y" 
- "average.tBodyAccJerk.mean.Z" 
- "average.tBodyAccJerk.std.X" 
- "average.tBodyAccJerk.std.Y" 
- "average.tBodyAccJerk.std.Z" 
- "average.tBodyGyro.mean.X" 
- "average.tBodyGyro.mean.Y" 
- "average.tBodyGyro.mean.Z" 
- "average.tBodyGyro.std.X" 
- "average.tBodyGyro.std.Y" 
- "average.tBodyGyro.std.Z" 
- "average.tBodyGyroJerk.mean.X" 
- "average.tBodyGyroJerk.mean.Y" 
- "average.tBodyGyroJerk.mean.Z" 
- "average.tBodyGyroJerk.std.X" 
- "average.tBodyGyroJerk.std.Y" 
- "average.tBodyGyroJerk.std.Z" 
- "average.tBodyAccMag.mean" 
- "average.tBodyAccMag.std" 
- "average.tGravityAccMag.mean" 
- "average.tGravityAccMag.std" 
- "average.tBodyAccJerkMag.mean" 
- "average.tBodyAccJerkMag.std" 
- "average.tBodyGyroMag.mean" 
- "average.tBodyGyroMag.std" 
- "average.tBodyGyroJerkMag.mean" 
- "average.tBodyGyroJerkMag.std" 
- "average.fBodyAcc.mean.X" 
- "average.fBodyAcc.mean.Y" 
- "average.fBodyAcc.mean.Z" 
- "average.fBodyAcc.std.X" 
- "average.fBodyAcc.std.Y" 
- "average.fBodyAcc.std.Z" 
- "average.fBodyAccJerk.mean.X" 
- "average.fBodyAccJerk.mean.Y" 
- "average.fBodyAccJerk.mean.Z" 
- "average.fBodyAccJerk.std.X" 
- "average.fBodyAccJerk.std.Y" 
- "average.fBodyAccJerk.std.Z" 
- "average.fBodyGyro.mean.X" 
- "average.fBodyGyro.mean.Y" 
- "average.fBodyGyro.mean.Z" 
- "average.fBodyGyro.std.X" 
- "average.fBodyGyro.std.Y" 
- "average.fBodyGyro.std.Z" 
- "average.fBodyAccMag.mean" 
- "average.fBodyAccMag.std" 
- "average.fBodyBodyAccJerkMag.mean" 
- "average.fBodyBodyAccJerkMag.std" 
- "average.fBodyBodyGyroMag.mean" 
- "average.fBodyBodyGyroMag.std" 
- "average.fBodyBodyGyroJerkMag.mean" 
- "average.fBodyBodyGyroJerkMag.std"
