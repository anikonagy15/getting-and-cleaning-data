library(dplyr)
X_train <- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"")
X_test <- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"")
Subject <- rbind(subject_train, subject_test)
w <- rbind(y_train, y_test)
mydata <- rbind( X_train, X_test)
features <- read.table("UCI HAR Dataset/features.txt", quote="\"")
v1 <- grep("mean", as.character(features[,2]))
v2 <- grep("std", as.character(features[,2]))
v <- c(v1, v2)
sort(v, decreasing=FALSE)
df <- numeric()
for (i in 1:ncol(mydata)) {
        if (i %in% v) {
                df <- cbind(df,mydata[,i])    
        }
}
n <- numeric()
for (j in 1:nrow(features)) {
        if (j %in% v) {
                n <- rbind(n, features[j,])
        }
}
m <- t(n)
c <- m[2, ]
g <- t(c)
for (l in 1:ncol(g)) {
        g[,l] <- gsub("tBody", "TimeBody", g[,l])
        g[,l] <- gsub("fBody", "FreqBody", g[,l])
        g[,l] <- gsub("\\-mean\\(\\)\\-", "Mean", g[,l])
        g[,l] <- gsub("\\-std\\(\\)\\-", "Std", g[,l])
        g[,l] <- gsub("tGravity", "TimeGrav", g[,l])        
}
colnames(df) <- g
for (k in 1:nrow(w)) {
        if ((w[k,])=="1"){
                 w[k,]<- "WALKING"
        }
        if ((w[k,])=="2"){
               w[k,]<- "WALKING_UPSTAIRS"
        }
        if ((w[k,])=="3"){
               w[k,]<- "WALKING_DOWNSTAIRS"
        }
        if ((w[k,])=="4"){
               w[k,]<- "SITTING"
        }
        if ((w[k,])=="5"){
               w[k,]<- "STANDING"
        }
        if ((w[k,])=="6"){
               w[k,]<- "LAYING"
        }        
}
tdata <- data.frame(Subject, w, df)
colnames(tdata)[2] <-'Activity'
tdata <- arrange(tdata, Activity)
colnames(tdata)[1] <- 'Subject'
write.table(tdata, file="merged_data.txt",row.names=FALSE)
Average <- group_by(tdata, Activity, Subject) %>% summarise_each(funs(mean))
write.table(Average, file="data_with_means.txt",row.names=FALSE)
