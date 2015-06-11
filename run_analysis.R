library(dplyr)

#Adjust WD as Needed, import files
setwd("UCI HAR Dataset")
vectnum <- rep(16,561)
xtest <- read.fwf("test/X_test.txt",vectnum,buffersize=200)
subjtest <- read.csv("test/subject_test.txt",header=F)
ytest <- read.csv("test/y_test.txt",header=F)
xtrain <- read.fwf("train/X_train.txt",vectnum,buffersize=200)
subjtrain <- read.csv("train/subject_train.txt",header=F)
ytrain <- read.csv("train/y_train.txt",header=F)
features <- read.csv("features.txt",header=F,sep=' ')
activities <- read.csv("activity_labels.txt",header=F,sep=' ')

#cleans and maps activity names in data
activities[,2] <- sapply(activities[,2],tolower)
ytest[,1] <- factor(as.character(ytest[,1]),activities[,1],activities[,2])
ytrain[,1] <- factor(as.character(ytrain[,1]),activities[,1],activities[,2])

#extract important features
import_feats<-sapply(features[,2],grepl,pattern="mean[^F]|std")
xtest <- xtest[,import_feats]
xtrain <- xtrain[,import_feats]

#clean and apply column names
cleaned_feats <- gsub('[-()]','',features[,2])
colnames(xtest)<-cleaned_feats[import_feats]
colnames(xtrain)<-cleaned_feats[import_feats]
colnames(subjtest)<-c("Subject.ID")
colnames(ytest)<-c("Activity.ID")
colnames(subjtrain)<-c("Subject.ID")
colnames(ytrain)<-c("Activity.ID")

#merge data
test <- cbind(subjtest,ytest,xtest)
train <- cbind(subjtrain,ytrain,xtrain)
data <- rbind(test,train)

#group data by Subject.ID and Activity.ID
gdata <- group_by(data,Subject.ID,Activity.ID)

#create tidy summary table
final <- summarise_each(gdata,c('mean'))

#write table to disk
write.table(final,"tidy.csv",row.name=F,sep=',')