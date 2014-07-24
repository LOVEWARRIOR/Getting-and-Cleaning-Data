
#here's my codes.
#X_test,y_test,subject_test are dataframes which read the files
#so do train series
#clean1 is the merged data
#clean3 is the data with variables including mean , standard deviation subject and label
#ans is a clean data but without readable names 
#tidy data is my final data

testset<-cbind(y_test,X_test,subject_test)
trainset<- cbind(y_train,X_train,subject_train)


clean1<-rbind(trainset,testset)
clean3<-clean1[grep("mean\\(|std\\(|label|subject",names(clean1))]

#create a dataframe with same names with clean3

ans <-clean3[clean3[1,]=="adhqwhdouqiwjdoiq",] 

#this for loop computes the mean value of each variable for each label and each subject
for (i in 1:length(split_label))
{
        temp <- split_label[[i]]
        split_subject <- split(temp, temp$subject )
        for (j in 1:length(split_subject))
        {
                temp <- split_subject[[j]]
                ta <-clean3[clean3[1,]=="adhqwhdouqiwjdoiq",]
                for (k in names(ta))
                {
                  ta[1,k] = mean(temp[,k],na.rm=TRUE)       
                }
                ans <- rbind(ta,ans)
        }
                
}
tidy<-ans
tidy  <- ans
names(tidy)<-gsub("\\(\\)","",names(tidy))

names(tidy)<-gsub("-","'s",names(tidy))

names(tidy)<-gsub("'s","'s ",names(tidy))

names(tidy)<-gsub("std","standard deviation",names(tidy))

names(tidy)<-gsub("mean","Mean value",names(tidy))


activity<-c( "WALKING"
            , "WALKING_UPSTAIRS"
            , "WALKING_DOWNSTAIRS"
            , "SITTING"
            , "STANDING"
            , "LAYING"
)

for (i in 1:length(tidy$label))
{
        tidy[i,"label"] <-activity[as.numeric(tidy[i,"label"])]
}
names(tidy)<-gsub(" [XYZ]","",names(tidy))

names(tidy)<-gsub("Mean value's","Mean value",names(tidy))
