#Requires stemmed.csv file of processed word tokens from all abstracts
#and train_output_changed.csv

abstracts=read.csv("stemmed.csv",header=FALSE)[[1]]
N=length(abstracts)
classed=read.csv("train_output_changed.csv",header=F)
attach(classed)

words=lapply(abstracts,function(x) strsplit(as.character(x)," ")[[1]])

bag=sort(table(unlist(words)),decreasing=TRUE)


write.csv(bag,"rawFreq.csv") 		#Creates the ranking of terms by raw frequency


