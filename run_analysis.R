# COURSERA - SPECIALISATION "DATA SCIENCE"
# Getting and Cleaning Data
# Assignment (week 04)
# ----------------------------------------
# OBJECTIVES:
# 
# create one R script "run_analysis.R" that does the following
#   1. Merges the training and the test sets to create one data set
#   2. Extracts only the measurements on the mean and standard deviation for
#      each measurement.
#   3. Uses descriptive activity names to name the activities in the data set
#   4. Appropriately labels the data set with descriptive variable names
#   5. From the data set in step 4, creates a second, independent tidy data set
#      with the average of each variable for each activity and each subject.
#
# -----------------------------------------
# DATA SOURCES & PREPARATION
#
#   It is necessary to download the data set from the following URL:
#   https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#
#   Download can be done either manually or by using R code.
#   Only important that the files are in a folder named "UCI HAR Dataset" in
#   your working directory.
#
#   Following R code demonstrates (a) download and (b) unzip of data set.
#   First "#" just needs to be deleted to run the code.
#
#   dir.create("./00_downloads") # create dummy folder for downloading files
#
#   dlFILE  <- "./00_downloads/UCIdataset.zip"
#   dlURL   <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#   download.file(dlURL, dlFILE, method = "auto") # download data set
#
#   unzip(dlFILE, overwrite = TRUE, exdir = ".") # unzip data set
#       
# ------------------------------------------
# STEP # 01 - MERGES TRAINING & TEST SETS TO CREATE ONE DATA SET
#
w_dir       <- getwd()                          # current working directory
ds_folder   <- "UCI HAR Dataset"                # folder name of data set
ds_dir      <- file.path(w_dir, ds_folder)      # path of data set
#
library(data.table)
#
# data sets of training and test
data_train  <- read.table(file.path(ds_dir, "train/X_train.txt"))
data_test   <- read.table(file.path(ds_dir, "test/X_test.txt"))
data_all    <- rbind(data_train, data_test)
#
# labels of training and test
label_train <- read.table(file.path(ds_dir, "train/y_train.txt"))
label_test  <- read.table(file.path(ds_dir, "test/y_test.txt"))
label_all   <- rbind(label_train, label_test)
#
# row = subject who performed the activity for each sample. 
# Its range is from 1 to 30.
subject_train   <- read.table(file.path(ds_dir, "/train/subject_train.txt"))
subject_test    <- read.table(file.path(ds_dir, "/test/subject_test.txt"))
subject_all     <- rbind(subject_train, subject_test)
#
# -------------------------------------------
# STEP # 02 - EXTRACTS ONLY THE MEASUREMENTS ON THE MEAN AND STANDARD
#             DEVIATION FOR EACH MEASUREMENT
#
# List of all features and Mean / STD
features_all        <- read.table(file.path(ds_dir,"features.txt"))
features_extract    <- grep("mean\\(\\)|std\\(\\)", features_all[, 2])
features_extract_n  <- features_all[features_extract,2]
#
# apply on data sets (training & test)
data_all            <- data_all[, features_extract]     # extract Mean & Std
names(data_all) <- features_all[features_extract, 2]    # naming
names(data_all) <- gsub("-mean()", "Mean", names(data_all))
names(data_all) <- gsub("-std()", "Std", names(data_all))
names(data_all) <- gsub("\\(\\)", "", names(data_all))  # delete "()"
names(data_all) <- gsub("-", "", names(data_all))       # delete "-"
#
# ------------------------------------------
# STEP # 03 - USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE
#             DATA SET
#
# read activity labels
label_activity  <- read.table(file.path(ds_dir, "activity_labels.txt"))
# create factor
label_activity  <- label_activity[label_all[, 1], 2]
# update label / activities
label_all[, 1]  <- label_activity
# update column name
names(label_all) <- "Activity"
#
# -------------------------------------------
# STEP # 04 - APPROPROATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAME
#
names(subject_all)  <- "Subject"
dt_complete         <- cbind(subject_all, label_all, data_all)
dt_complete$Subject <- as.factor(dt_complete$Subject)
write.table(dt_complete, "DataTable_complete.txt")
#
# --------------------------------------------
# STEP #05 - FROM THE DATA SET IN STEP 4, CREATES A SECOND, INDEPENDENT TIDY
#            DATA SET WITH THE AVERAGE OF EACH VARIABLE FOR EACH ACTIVITY
#            AND EACH SUBJECT
#
tidyData    <- aggregate(. ~Subject + Activity, dt_complete, mean)
tidyData    <- tidyData[order(tidyData$Subject, tidyData$Activity),]
write.table(tidyData, file = "tidyData.txt", row.names = FALSE)
