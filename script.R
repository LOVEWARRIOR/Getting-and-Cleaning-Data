

#X_test,y_test,subject_test are dataframes which read the files
#so do train series
#names is read from the features.txt
X_test<-read.csv(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt",sep = "",header = FALSE)
y_test<-read.csv(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt",header =FALSE)
X_train<-read.csv(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt",header = FALSE,sep='')
y_train<-read.csv(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt",head = FALSE,sep=' ')


names<-read.csv(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Datasetfeatures.txt",header = FALSE, sep = "")
names(X_test)<-as.character(names[,"V2"])
names(X_train)<-as.character(names[,"V2"])
subject_test<-read.csv(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt",header = FALSE)
subject_train<-read.csv(".\\getdata-projectfiles-UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt",header = FALSE)

names(y_test)<-"label"
names(y_train)<-"label"
names(subject_train)<-"subject"
names(subject_test)<-"subject"
testset<-cbind(y_test,X_test,subject_test)
trainset<- cbind(y_train,X_train,subject_train)

clean1<-rbind(trainset,testset)
clean3<-clean1[grep("mean\\(|std\\(|label|subject",names(clean1))]
split_label<-split(clean3,clean3$label)

#create a dataframe with same names with clean3
ans <-clean3[clean3[1,]=="adhqwhdouqiwjdoiq",] 

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
