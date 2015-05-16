The original data is the result of experiments carried out with a group of 30 volunteers within an age bracket of 19-48 years(ID from 1 to 30).

Each person performed six activities(Walking,Walking_upstairs,Walking_downstairs,Sitting,Standing,Sitting) wearing a smartphone on the waist.
Using its embedded accelerometer and gyroscope, researchers captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 
The experiments have been video-recorded to label the data manually. 
The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

R script is used to handle the dataset.
The "dplyr" package is used.

Step1, read the dataset containing testing set and training set to R, then use "rbind()" to merge the training and testing dadaset to one data.frame called "total".

Step2, transform "total" to a "tbl"; read the features from "features.txt" to "feature"; use "grepl()" to extract the index of the measurement on mean() and std() separately, then merge the two part to one vector and sort it using "sort()"; use select() to extract the columns in the total table to "total_chosen".

Step3, read the activity labels into R; merge the test_lab and train_lab to "total_lab"; replace the numbers by descriptive activity names; merge the subjectID,activity labels,total_chosen to "entb".

Step4, use index of Step2 to get the feature names, then remove the brackets in the names using "gsub()" and replace "-" by "_" because the "-" would be recognized to a minus sign rather than a string; label the columns using "names()" by ("SubjectID","ActivityType",feature names).

Step5, group "entb" by ("SubjectID","ActivityType"), then average each colunm using "summarise_each()" to get the mean for each activity and each subject.
Write the last table "tidytab" to "Tidy_data.txt".
