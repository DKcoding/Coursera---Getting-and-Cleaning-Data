Coursera: Getting and Cleaning Data - Project Assignment
================
Author: Dennis Krowiorz

Assignment objectives
---------------------

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this [article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

<http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

Here are the data for the project:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

You should create one R script called run\_analysis.R that does the following.

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
3.  Uses descriptive activity names to name the activities in the data set.
4.  Appropriately labels the data set with descriptive activity names.
5.  Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Instruction to reproduce data
-----------------------------

### Preparation

It is necessary to download the data set from the following URL: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

Download can be done either manually or by using R code. Only important that the files are in a folder named "UCI HAR Dataset" in your working directory.

The following steps describes each section of the R code of `run_analysis.R` resulting in a tidy data set `tidyData.txt`:

### Step 1 - Merges training and test sets to create one data set

The following files are read into tables and merged:

-   merge data set of training and test
    -   `/train/subject_train.txt`
    -   `/test/subject_test.txt`
-   merge labels of training test
    -   `/train/subject_train.txt`
    -   `/test/subject_test.txt`
-   merge subjects who performed activity
    -   `/train/subject_train.txt`
    -   `/test/subject_test.txt`

### Step 2 - Extracts only the measurements on the mean and standard deviation for each measurement

-   all features in file `features.txt` are read into a table and only
-   features with criteria "mean()" or "std()" are selected
-   selection of features is applied on merged data set
-   variable names are enhanced

### Step 3 - Uses descriptive activity names to name the activities in the data set

-   activity labels are read into table
-   a vector is created with the activity labels
-   activities are updated with activity label vector

### Step 4 - Approproately labels the data set with descriptive variable name

-   merge into one data set (a) subjects, (b) activities and (c) data set of training & test
-   enhance merged data set by updating column names and changing into factors where necessary

### Step 5 - Create a data set with the average of each variable for each activity and each subject

-   data set is aggregated by activity and subject and applying the average (=mean) on the data set
-   result is ordered
-   a file `tidyData.txt` is created
