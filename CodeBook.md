This file describes the variables, the data, and any transformations or work that I have performed to clean up the data. 
The site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
The data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
The run_analysis.R script performs the following steps to clean the data:
1. Read X_train.txt, y_train.txt and subject_train.txt and store them in X_train, y_train and subject_train variables respectively.
2. Read X_test.txt, y_test.txt and subject_test.txt and store them in X_test, y_test and subject_test variables respectively.
3. Merge X_train and X_test to generate mydata a 10299x561 data frame, merge y_train and y_test to generate w a 10299x1 data frame, merge subject_train and subject_test to generate Subject a 10299x1 data frame.
4. Read the features.txt file and store the data in a variable called features. We only extract the measurements on the mean and standard deviation. 
5. Creating df  10299x79 data frame which contains only he mean and standard deviation.
6. Giving names of columns of df.
7. Clean the column names of the subset. I remove the "()" and "-" symbols in the names, as well as make the first letter of "mean" and "std" a capital letter "M" and "S" respectively.
8. Transform the values of w according to the activity.
9. Combine the Subject, w and df by column to get a new cleaned tdata 10299x81 data frame. Properly name the first two columns, "Subject" and "Activity". The "Subject" column contains integers that range from 1 to 30 inclusive; the "Activity" column contains 6 kinds of activity names.
10. Write the  out to "merged_data.txt" file in current working directory.
11. Finally, generate a second independent tidy data set (Average) with the average of each measurement for each activity and each subject. I have 30 unique subjects and 6 unique activities, which result in a 180 combinations of the two. Then, for each combination, I calculate the mean of each measurement with the corresponding combination. 
12. Write the result out to "data_with_means.txt" file in current working directory. 
