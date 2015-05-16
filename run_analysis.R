library(dplyr)

test<-read.table("UCI HAR Dataset/test/X_test.txt")
test_lab<-read.table("UCI HAR Dataset/test/y_test.txt")
test_sub<-read.table("UCI HAR Dataset/test/subject_test.txt")
train<-read.table("UCI HAR Dataset/train/X_train.txt")
train_lab<-read.table("UCI HAR Dataset/train/y_train.txt")
train_sub<-read.table("UCI HAR Dataset/train/subject_train.txt")
total<-rbind(test,train) ##step1,merging the test sets and train sets

total_df<-tbl_df(total)
rm("test")
rm("train")
feature<-read.table("UCI HAR Dataset/features.txt")

lab1<-which(grepl("mean()",feature[,2],fixed=TRUE)=="TRUE")
lab2<-which(grepl("std()",feature[,2],fixed=TRUE)=="TRUE")
lab<-sort(c(lab1,lab2))
total_chosen<-select(total_df,lab) ##step2, extracting the measurements on the mean and standard deviation 

total_lab<-rbind(test_lab,train_lab)
from<-c("1","2","3","4","5","6")
to<-c("Walking","Walking_upstairs","Walking_downstairs","Sitting","Standing","Laying")
act<-mapvalues(total_lab[,1],from,to)
sub<-rbind(test_sub,train_sub)
entb<-cbind(sub,act,total_chosen) ##step3, descriptive activity names

lab_name<-feature[lab,2]
lab_name2<-gsub("\\(|\\)","",lab_name) ##remove brackets in names
lab_name3<-gsub("\\-","_",lab_name2)  ##replace the "-" by "_"
names(entb)<-c("SubjectID","ActivityType",as.character(lab_name3)) ##step4,labeling the data set with feature names

tab<-tbl_df(entb)
tidytab<-tab%>%
    group_by(SubjectID,ActivityType)%>%
    summarise_each(funs(mean)) ##step5, averageing each variable for each activity and each subject
write.table(tidytab,"Tidy_data.txt",row.names=FALSE)
