library(dplyr)
#set wd

setwd("C:/Users/Kai Chin/Documents/SMU/")

#read training data

X_train <- read.table("./Coursera/Project Week 4/UCI HAR Dataset/train/X_train.txt")
Y_train <- read.table("./Coursera/Project Week 4/UCI HAR Dataset/train/Y_train.txt")
sub_train <- read.table("./Coursera/Project Week 4/UCI HAR Dataset/train/subject_train.txt") 

#read test data

X_test <- read.table("./Coursera/Project Week 4/UCI HAR Dataset/test/X_test.txt")
Y_test <- read.table("./Coursera/Project Week 4/UCI HAR Dataset/test/Y_test.txt")
sub_test <- read.table("./Coursera/Project Week 4/UCI HAR Dataset/test/subject_test.txt") 

#read variables

var_names <- read.table("./Coursera/Project Week 4/UCI HAR Dataset/features.txt")

#read labels
labels <- read.table("./Coursera/Project Week 4/UCI HAR Dataset/activity_labels.txt")


#merge data ### q1

X_all <- rbind(X_train, X_test)
Y_all <- rbind(Y_train, Y_test)
sub_all <- rbind(sub_train, sub_test)


#set col names ### q3 ### q4
colnames(X_all) <- var_names[,2]
colnames(Y_all) <- "activityID"
colnames(sub_all) <- "subjectID"
colnames(labels) <- c("activityID", "subjectID")

dataset <- cbind(Y_all, sub_all, X_all)


#find mean and sd ###q2

select_var <- var_names[grep("mean\\(\\)|std\\(\\)",var_names[,2]),]
data_mean_sd <- dataset[, select_var[,1]]

#tidy dataset #q5

tidydata <- data_mean_sd %>% group_by(activityID, subjectID) %>% summarize_each(list(mean = mean))
write.table(tidydata, file = "./Coursera/Project Week 4/UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)



