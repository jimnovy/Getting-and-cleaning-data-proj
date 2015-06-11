## Code Book

This code book will describe the data used in this analysis, as well as the processing required to create the resulting tidy data set.

### Overview

Human Activity Recognition database built from the recordings of 30 subjects performing activities of daily living (ADL) while carrying a waist-mounted smartphone with embedded inertial sensors.

### Data Source

The 'Human Activity Recognition Using Smartphones Data Set' was retrieved by UCI's Machine Learning Repository at http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The files used are as follows:

* `features.txt`: Names of the 561 features.
* `activity_labels.txt`: Names and IDs for each of the 6 activities.

* `train/X_train.txt`: 7352 observations of the 561 features, for 21 of the 30 volunteers.
* `train/subject_train.txt`: A vector of 7352 integers, denoting the ID of the volunteer related to each of the observations in `X_train.txt`.
* `train/y_train.txt`: A vector of 7352 integers, denoting the ID of the activity related to each of the observations in `X_train.txt`.

* `test/X_test.txt`: 2947 observations of the 561 features, for 9 of the 30 volunteers.
* `test/subject_test.txt`: A vector of 2947 integers, denoting the ID of the volunteer related to each of the observations in `X_test.txt`.
* `test/y_test.txt`: A vector of 2947 integers, denoting the ID of the activity related to each of the observations in `X_test.txt`.

More information about the files is available in `README.txt`. More information about the features is available in `features_info.txt`.

### Data files that were not used

This analysis was performed using only the files above, and did not use the raw signal data. Therefore, the data files in the "Inertial Signals" folders were ignored.

### Processing steps

1. All of the relevant data files were read into data frames and activity names were mapped from IDs.
2. All feature columns were removed that did not contain the string "std" or "mean" without a "F" following it. This left 66 feature columns, plus the subjectID and activity columns.
3. Remaining feature column names were cleaned up and applied to the data frames.
4. Test and Training data sets were merged and grouped by "Subject.ID" and "Activity.ID".
5. A tidy data set was created containing the mean of each feature for each subject and each activity. Thus, subject #1 has 6 rows in the tidy data set (one row for each activity), and each row contains the mean value for each of the 66 features for that subject/activity combination. Since there are 30 subjects, there are a total of 180 rows.
6. The tidy data set was output to a CSV file.